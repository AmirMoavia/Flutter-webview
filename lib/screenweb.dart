import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class ScreenWeb extends StatefulWidget {
  const ScreenWeb({super.key});

  @override
  State<ScreenWeb> createState() => _ScreenWebState();
}

class _ScreenWebState extends State<ScreenWeb> {
  late InAppWebViewController inAppWebViewController;
 

  @override
  Widget build(BuildContext context) {
    Future<bool> willpopdialog() async {
      return await showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) => AlertDialog(
                scrollable: true,
                title: const Text('Alert'),
                content: const Text('Do you want to exit the app?'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        }
                      },
                      child: const Text(
                        'Exit',
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('NO')),
                ],
              ));
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WillPopScope(
              onWillPop: () async {
                if (await inAppWebViewController.canGoBack()) {
                  inAppWebViewController.goBack();

                  return false;
                } else {
                  return willpopdialog();
                }
              },
              child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse('https://www.youtube.com/')),
                  onWebViewCreated: (InAppWebViewController controller) {
                    inAppWebViewController = controller;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
