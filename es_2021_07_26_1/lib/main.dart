import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyApp(),
      );
    });
  }
}

// ignore: public_member_api_docs
class MyApp extends StatelessWidget {
  // ignore: public_member_api_docs
  MyApp({Key? key}) : super(key: key);
  MediaQueryData? queryData;
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    print(queryData?.devicePixelRatio);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          'App bars',
          style: TextStyle(fontSize: 30.0),
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: queryData?.devicePixelRatio as double,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: const Center(
                  child: AutoSizeText(
                    'This string will be automatically resized to fit in two lines.',
                    style: TextStyle(fontSize: 30.0),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: queryData?.devicePixelRatio as double,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: 100 / 100,
                  child: Image.network(
                    'https://hatrabbits.com/wp-content/uploads/2017/01/random.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
