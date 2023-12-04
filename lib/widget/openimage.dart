import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class openimage extends StatefulWidget {
  String imageid;
   openimage({Key? key,required this.imageid}) : super(key: key);

  @override
  State<openimage> createState() => _openimageState();
}
class _openimageState extends State<openimage> {
  Uint8List? _imageData;
  Future<void> _saveImage() async {
    final response = await http.get(Uri.parse(widget.imageid));
    setState(() {
      _imageData = response.bodyBytes;
    });
    if (_imageData != null && _imageData!.isNotEmpty) {
      final result = await ImageGallerySaver.saveImage(_imageData!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Image saved to gallery'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error in save Image'),
      ));
    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imageid);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb4776e6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Image"),
            GestureDetector(
              onTap: (){
                _saveImage();
              },
              child: const Icon(Icons.download),
            )
          ],
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Image.network(widget.imageid.toString(),height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
      ),
    );
  }
}
