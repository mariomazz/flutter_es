import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/apis/api.service.dart';
import '../theme/colors.dart';
import '../widget/padding.dart';
import '../widget/rounded_card.dart';
import '../widget/title.dart';
import 'models/chat_obj.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingcontroller = TextEditingController();

  late final List<ChatObj> _totalChatItems = [
    const ChatObj(value: "Ciao come possiamo aiutarti ?", type: ChatType.answer)
  ];

  Future<ChatObj?> _sendQuestion(String question) async {
    final answer = await ApiService.instance.sendQuestion(question);
    return answer != null
        ? ChatObj(value: answer, type: ChatType.answer)
        : null;
  }

  Future<void> _eventNewQuestion(String question) async {
    if (question.isNotEmpty) {
      final answer = await _sendQuestion(question);
      if (answer != null) {
        setState(() {
          _totalChatItems.addAll(
              [ChatObj(type: ChatType.question, value: question), answer]);
          _textEditingcontroller.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            js.context.callMethod('postMessageApp', ['Il Mio Messaggio']);
          },
          child: PaddingCS(
            child: SvgPicture.asset(
              "icons/svg/angle-left-solid.svg",
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: ColorsCS.primary,
        title: const Text("Ciao come possiamo aiutarti ?"),
        elevation: 0,
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            PaddingCS(
              child: TitleCS(
                data: formatDate(
                  DateTime.now(),
                  [dd, ' ', MM, ' ', yyyy],
                  locale: const ItalianDateLocale(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(child: _chatItems(_totalChatItems)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: SizedBox.expand(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: TextField(
                  onSubmitted: (value) async => await _eventNewQuestion(value),
                  controller: _textEditingcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Scrivi il messaggio qui...',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Material(
                  color: Colors.grey.shade300,
                  child: InkWell(
                    onTap: () async =>
                        await _eventNewQuestion(_textEditingcontroller.text),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            "icons/svg/paper-plane-solid.svg",
                            color: ColorsCS.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatItems(List<ChatObj> chatItems) {
    return ListView.builder(
      itemCount: chatItems.length,
      itemBuilder: (context, i) {
        final chatItem = chatItems.elementAt(i);
        return Row(
          mainAxisAlignment: chatItem.type == ChatType.answer
              ? MainAxisAlignment.start
              : chatItem.type == ChatType.question
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
          children: [
            PaddingCS(
              child: RoundedCard(
                data: chatItem.value,
                backgroundColor: chatItem.type == ChatType.answer
                    ? Colors.white
                    : chatItem.type == ChatType.question
                        ? ColorsCS.primary
                        : Colors.white,
                textColor: chatItem.type == ChatType.answer
                    ? Colors.black
                    : chatItem.type == ChatType.question
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
