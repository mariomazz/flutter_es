import 'package:flutter/material.dart';
import 'screens/10_connection_lost.dart';
import 'screens/11_broken_link.dart';
import 'screens/12_artical_not_found.dart';
import 'screens/13_no_space.dart';
import 'screens/14_no_result_found.dart';
import 'screens/15_payment_faild.dart';
import 'screens/16_time_error.dart';
import 'screens/17_location_error.dart';
import 'screens/18_router_offline.dart';
import 'screens/19_connection_faild.dart';
import 'screens/1_no_connection.dart';
import 'screens/20_no_file.dart';
import 'screens/21_camera_access.dart';
import 'screens/2_404_error.dart';
import 'screens/3_something_went_wrong.dart';
import 'screens/4_file_not_found.dart';
import 'screens/5_something_wrong.dart';
import 'screens/6_error.dart';
import 'screens/7_error_2.dart';
import 'screens/8_404_error_2.dart';
import 'screens/9_location_access.dart';

List<Widget> screenList = [
  NoConnectionScreen(),
  Error404Screen(),
  Error404Screen2(),
  SomethingWentWrongScreen(),
  FileNotFoundScreen(),
  SomethingWrongScreen(),
  ErrorScreen(),
  Error2Screen(),
  LocationAccessScreen(),
  ConnectionLostScreen(),
  BrokenLinkScreen(),
  ArticleNotFoundScreen(),
  NoSpaceScreen(),
  NoResultFoundScreen(),
  PaymentFaildScreen(),
  TimeErrorScreen(),
  LocationErrorScreen(),
  RouterOfflineScreen(),
  ConnectionFaildScreen(),
  NoFileScreen(),
  CameraAccessScreen(),
];

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '20 Flutter Error State Pages',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          itemCount: screenList.length,
          itemBuilder: (context, index) {
            return screenList[index];
          },
        ),
      ),
    );
  }
}
