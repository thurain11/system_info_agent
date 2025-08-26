import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_info_agent/system_info_agent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await SystemInfoAgent.init();
    });
  }

  String? userAgent, webViewUserAgent;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion = SystemInfoAgent.userAgent!;
      userAgent = SystemInfoAgent.userAgent!;
      webViewUserAgent = SystemInfoAgent.webViewUserAgent!;
      debugPrint("User Agent ----> $userAgent");
      debugPrint("Web User Agent ----> $webViewUserAgent");
    } on PlatformException {
      userAgent = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(title: const Text('System Info Agent app')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userAgent == null || webViewUserAgent == null
                ? Center(child: Text("User Agent"))
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$userAgent"),
                        SizedBox(height: 20),
                        Text("$webViewUserAgent"),
                      ],
                    ),
                  ),
            SizedBox(height: 40),

            OutlinedButton(
              onPressed: initPlatformState,
              child: Text("Get user agent"),
            ),
          ],
        ),
      ),
    );
  }
}
