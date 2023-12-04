import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class pdfview extends StatefulWidget {
  String? data;
  pdfview({Key? key,this.data}) : super(key: key);
  @override
  State<pdfview> createState() => _pdfviewState();
}
class _pdfviewState extends State<pdfview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Pdf view");
  }
  late final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xffb4776e6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Pdf file"),
              GestureDetector(
                onTap: ()async{
                  var response = await http.get(Uri.parse(widget.data.toString()));
                  String fileName = widget.data.toString().split('/').last;

                  Directory? storageDirectory =Platform.isAndroid ?await getExternalStorageDirectory(): await getDownloadsDirectory();
                  String directoryPath = storageDirectory!.path;
                  File file = File('$directoryPath/$fileName');
                  // Directory directory = await getApplicationDocumentsDirectory();
                  String filePath = '${storageDirectory.path}/$fileName';
                  // File file = new File(filePath);
                  print(file);
                  await file.writeAsBytes(response.bodyBytes);
                  if (await canLaunch('file:$filePath')) {
                    await launch('file:$filePath');
                  } else {
                    throw 'Could not launch $filePath';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('file saved.'),
                  ));

                },
                child: const Icon(Icons.download),
              )
            ],
          ),
        ),
        body: const PDF().cachedFromUrl(
          widget.data.toString(),
          maxAgeCacheObject:const Duration(days: 30), //duration of cache
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        )
      // PDFView(
      //   filePath: 'https://www.example.com/myfile.pdf',
      //   enableSwipe: true,
      //   swipeHorizontal: true,
      //   autoSpacing: true,
      //   pageFling: true,
      //   defaultPage: 0,
      //   fitPolicy: FitPolicy.BOTH,
      //   // title: Text('My PDF File'),
      // ),
    );
  }
}