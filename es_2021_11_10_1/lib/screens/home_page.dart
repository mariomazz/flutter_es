import 'package:auto_animated/auto_animated.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:es_2021_11_10_1/widget/info_card.dart';
import 'package:es_2021_11_10_1/widget/pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    required this.navigateToQrcopage,
    this.popUpValue = false,
    this.scanValue,
  }) : super(key: key);
  VoidCallback navigateToQrcopage;
  bool popUpValue;
  String? scanValue;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double stateBottomButtonEffect = 0;
  TextStyle textStylePopUp = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        stateBottomButtonEffect = 1;
      });
    });
    if (widget.popUpValue &&
        (widget.scanValue != '' && widget.scanValue != null)) {
      WidgetsBinding.instance!
          .addPostFrameCallback((_) => Navigator.of(context).push(
                PopUp(bodyPopUp: _bodyPopUp()),
              ));
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(),
                      Text(
                        'Card Manager',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 16,
                                color: Colors.black.withAlpha(15),
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Icon(
                              Icons.logout_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: InfoCard(),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transazioni',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: LiveList(
                            itemCount: 5,
                            itemBuilder: (context, index, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(0, 0.3),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: ListTile(
                                    title: Text(
                                      'Mario Mazzarelli',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text('25 mar 2014',
                                        style: TextStyle(fontSize: 15)),
                                    trailing: Container(
                                      child: Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            '25',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Positioned(
                                          right: 1,
                                          bottom: 1,
                                          child: Text(
                                            'Pt',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: stateBottomButtonEffect,
            child: RawMaterialButton(
              onPressed: () => widget.navigateToQrcopage.call(),
              /* onPressed: () => Navigator.of(context).push(
                PopUp(bodyPopUp: bodyPopUpData()),
              ), */
              elevation: 2.0,
              fillColor: Theme.of(context).secondaryHeaderColor,
              child: Icon(
                Icons.qr_code_2_outlined,
                size: 35.0,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyPopUp() {
    var dataLayout = MediaQuery.of(context);
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    40 / 375 * dataLayout.size.width,
                  ),
                ),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Inserisci il numero di punti',
                                style: textStylePopUp,
                              ),
                            ),
                            Container(
                              width: 280 / 428 * dataLayout.size.width,
                              height: 60 / 926 * dataLayout.size.height,
                              child: TextField(
                                maxLength: 4,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontSize: 30),
                                decoration: InputDecoration(
                                  counterText: "",
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "10",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20 / 926 * dataLayout.size.height,
                            ),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 60 / 926 * dataLayout.size.height,
                                    width: 60 / 428 * dataLayout.size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.25),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('5',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white)),
                                    )),
                              ),
                              SizedBox(
                                width: 15 / 428 * dataLayout.size.width,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 60 / 926 * dataLayout.size.height,
                                    width: 60 / 428 * dataLayout.size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.50),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('10',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white)),
                                    )),
                              ),
                              SizedBox(
                                width: 15 / 428 * dataLayout.size.width,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 60 / 926 * dataLayout.size.height,
                                    width: 60 / 428 * dataLayout.size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.75),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('15',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white)),
                                    )),
                              ),
                              SizedBox(
                                width: 15 / 428 * dataLayout.size.width,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    height: 60 / 926 * dataLayout.size.height,
                                    width: 60 / 428 * dataLayout.size.width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text('20',
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white)),
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: 50 / 926 * dataLayout.size.height,
                            ),
                            CustomSlidingSegmentedControl<int>(
                              backgroundColor:
                                  Color(0XFFC2C2C2).withOpacity(0.5),
                              thumbColor:
                                  Theme.of(context).secondaryHeaderColor,
                              children: {
                                0: Container(
                                  width: 80 / 428 * dataLayout.size.width,
                                  child: Center(
                                    child:
                                        Icon(Icons.remove, color: Colors.white),
                                  ),
                                ),
                                1: Container(
                                  width: 80 / 428 * dataLayout.size.width,
                                  child: Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              },
                              duration: Duration(milliseconds: 200),
                              radius: 30.0,
                              onValueChanged: (index) {
                                print(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Conferma',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 22,
            right: 90,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    40 / 375 * dataLayout.size.width,
                  ),
                ),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.scanValue ?? 'errore',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
