import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
class ImageContainer extends StatefulWidget {
  final Function getImage;
  ImageContainer(this.getImage);
  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File _pickedImage;
  Future<void> _imagePicker() async{
   File _selectedImage=await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth:600 );
   if(_selectedImage==null) return;
    setState(() {
      _pickedImage=_selectedImage;
    });
    final appDir= await syspaths.getApplicationDocumentsDirectory();
    final fileName=path.basename(_selectedImage.path);
    _selectedImage.copy('${appDir.path}/$fileName');
    widget.getImage(_pickedImage);
    
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            )
          ),
          child: _pickedImage==null?Text("No Image Chosen",textAlign: TextAlign.center,):Image.file(_pickedImage,fit: BoxFit.cover, width: double.infinity,)
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Select an image"),
            onPressed: _imagePicker,
          ),
        )
      ],
      
    );
  }
}