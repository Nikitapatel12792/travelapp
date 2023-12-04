import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sizer/sizer.dart';

class locview extends StatefulWidget {
  final String? data;
  int? sta;
  locview({Key? key, this.data,this.sta}) : super(key: key);

  @override
  State<locview> createState() => _locviewState();
}

class _locviewState extends State<locview> {
bool _isLoading =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.sta == 0 ?Text("Book your next trip",style: TextStyle(
        fontFamily: "Poppins",fontSize: 16.sp
        ),) : Text("Our Partner",style: TextStyle(
    fontFamily: "Poppins",fontSize: 16.sp
    ),),
        automaticallyImplyLeading: true,
      ),
      body:(widget.data == "")?Center(child: Text( "No Link Available.",style: TextStyle(
        fontSize: 12.sp,fontFamily: "Poppins"
      ),)): Stack(
        children: [

          InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse(Uri.encodeFull(widget.data.toString()))),
            onLoadStop: (InAppWebViewController controller, Uri? url) =>
                setState(() => _isLoading = false),
            androidOnGeolocationPermissionsShowPrompt:
                (InAppWebViewController controller, String origin) async {
              return GeolocationPermissionShowPromptResponse(
                  origin: origin, allow: true, retain: true);
            },
          ),
          Visibility(
            visible: _isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
