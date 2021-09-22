import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final String data = '<div><a href="https://www.google.com/">google</a><a href="https://www.facebook.com/">facebook</a><a href="https://www.instagram.com/">instagram</a></div>';

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      print('browser launch');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('titolo'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Html(
            data: data,
            onLinkTap: (link, _, __, ___) => _launchUrl(link!),
          ),
        ),
      ),
    );
  }
}
