import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;
  void _pickImage() async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    var _image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    setState(() {
                      _pickedImage = _image;
                    });
                  },
                  icon: Icon(
                    Icons.camera_enhance_rounded,
                    size: 70,
                  ),
                  label: Text('Camera'),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                    onPressed: () async {
                      var _image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(() {
                        _pickedImage = _image;
                      });
                    },
                    icon: Icon(
                      Icons.photo,
                      size: 70,
                    ),
                    label: Text('Gallery')),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage:
              _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        Container(
          child: ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColorDark,
            ),
            label: Text(
              'Edit',
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).primaryColorLight.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
