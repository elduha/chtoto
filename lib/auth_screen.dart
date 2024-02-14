import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'BusScreen.dart';

class AuthScreen extends StatelessWidget {
  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.purple.shade300,
                  Colors.blue.shade300,
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.flutter_dash,
                  size: 120,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text('Get Started', style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => BusScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => _launchURL('https://www.youtube.com/?gl=KZ'),
                      child: Text('Terms and Conditions', style: TextStyle(color: Colors.white70)),
                    ),
                    TextButton(
                      onPressed: () => _launchURL('http://google.com/'),
                      child: Text('Privacy Policy', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
