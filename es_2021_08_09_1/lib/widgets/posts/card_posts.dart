import 'package:myapp/models/posts/post.dart';
import 'package:flutter/material.dart';

class CardPosts extends StatelessWidget {
  final Post_ post;
  final void Function()? actionShare;
  CardPosts({Key? key, required this.post, this.actionShare}) : super(key: key);
  final double titleTextSize = 25;
  final double textSize = 20;

  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Card(
            color: Colors.blueAccent,
            elevation: 5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'POST',
                    style: TextStyle(
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${post.userId}',
                          style: TextStyle(
                            fontSize: textSize,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${post.id}',
                          style: TextStyle(
                            fontSize: textSize,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${post.title}',
                          style: TextStyle(
                            fontSize: textSize,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${post.body}',
                          style: TextStyle(
                            fontSize: textSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: actionShare,
              child: Icon(
                Icons.share,
                size: ((30 * dataLayout.size.width) / 426 < 65)
                    ? (30 * dataLayout.size.width) / 426
                    : 65,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
