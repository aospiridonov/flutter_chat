import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFunc);

  final void Function(File pickedImage) imagePickFunc;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      if (pickedImageFile != null) {
        _pickedImage = File(pickedImageFile.path);
      } else {
        print('No image selected.');
      }
      widget.imagePickFunc(_pickedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add image')),
      ],
    );
  }
}
