import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonImagePicker extends StatefulWidget {
  const PersonImagePicker({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<PersonImagePicker> createState() => _PersonImagePickerState();
}

class _PersonImagePickerState extends State<PersonImagePicker> {
  File? _imageFile;

  Future<void> pickPic(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(pickedFile.path);
    });

    widget.onPickImage(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: const AssetImage("assets/images/profileImg.png"),
          backgroundColor: Colors.grey,
          foregroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            icon: const Icon(Icons.image),
            label: Text(
              'Add Image',
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Event Image",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {
              pickPic(
                ImageSource.gallery,
              );
            },
            icon: const Icon(
              Icons.image,
            ),
            label: const Text(
              "Gallery",
            ),
          ),
        ],
      ),
    );
  }
}
