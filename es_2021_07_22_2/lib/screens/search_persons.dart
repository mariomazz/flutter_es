import 'package:es_2021071916/widgets/my-app-bar.dart';
import 'package:flutter/material.dart';

class ScreenSearchPersons extends StatefulWidget {
  ScreenSearchPersons({Key? key, this.filterList}) : super(key: key);
  String? filterList;
  @override
  _ScreenSearchPersonsState createState() => _ScreenSearchPersonsState();
}

class _ScreenSearchPersonsState extends State<ScreenSearchPersons> {
  String valueTextField = "";
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Scaffold(
        appBar: MyAppbar(
          color: Colors.lightBlueAccent,
        ),
        body: Center(
          child: widget.filterList == null
              ? const Text(
                  'search persons',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'search persons filter : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.filterList}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Filter",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          valueTextField = val;
                          setState(() {
                            valueTextField = val;
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'change filter',
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/', arguments: valueTextField);
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
