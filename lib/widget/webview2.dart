import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';



class webview2 extends StatefulWidget {
  final String? data;
  const webview2({Key? key, this.data}) : super(key: key);

  @override
  State<webview2> createState() => _webview2State();
}

class _webview2State extends State<webview2> {
  String? encodedURl;

  String? url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb4776e6),
        automaticallyImplyLeading: true,
        title: const Text("location"),
      ),
      body: InAppWebView(
        initialUrlRequest:
        URLRequest(url: Uri.parse(Uri.encodeFull(widget.data.toString()))),
        androidOnGeolocationPermissionsShowPrompt:
            (InAppWebViewController controller, String origin) async {
          return GeolocationPermissionShowPromptResponse(
              origin: origin,
              allow: true,
              retain: true
          );
        },
      ),
    );
  }
}
