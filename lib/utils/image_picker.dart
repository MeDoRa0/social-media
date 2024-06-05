import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

//this method is used to pick image in post
/*pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return await file.readAsBytes();
  }
}*/



Future<Uint8List?> pickImage(BuildContext context) async {
  final ImagePicker imagePicker = ImagePicker();

  // Function to show the picker dialog
  return await showModalBottomSheet<Uint8List?>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Photo Library'),
              onTap: () async {
                final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  final bytes = await file.readAsBytes();
                  Navigator.of(context).pop(bytes);
                } else {
                  Navigator.of(context).pop(null);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () async {
                final XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
                if (file != null) {
                  final bytes = await file.readAsBytes();
                  Navigator.of(context).pop(bytes);
                } else {
                  Navigator.of(context).pop(null);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
