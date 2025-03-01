import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart' as cropper;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:gallery_saver/gallery_saver.dart';

void main() {
  runApp(PhotoEditorApp());
}

class PhotoEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoEditorScreen(),
    );
  }
}

class PhotoEditorScreen extends StatefulWidget {
  @override
  _PhotoEditorScreenState createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends State<PhotoEditorScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick Image from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Crop Image
  Future<void> _cropImage() async {
    if (_image == null) return;
    CroppedFile? croppedFile = await cropper.ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
      ],
      uiSettings: [AndroidUiSettings(toolbarTitle: 'Crop Image')],
    );
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
      });
    }
  }

  // Open Image Editor
  Future<void> _editImage() async {
    if (_image == null) return;
    Uint8List imageBytes = await _image!.readAsBytes();
    var editedImage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageEditor(image: imageBytes)),
    );
    if (editedImage != null) {
      setState(() {
        _image = File(editedImage.path);
      });
    }
  }

  // Save Image to Gallery
  Future<void> _saveImage() async {
    if (_image == null) return;
    await GallerySaver.saveImage(_image!.path);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Image Saved to Gallery!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Photo Editor")),
      body: Column(
        children: [
          SizedBox(height: 10),
          _image != null
              ? Image.file(
                _image!,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              )
              : Text("No Image Selected"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text("Gallery"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text("Camera"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _cropImage, child: Text("Crop")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _editImage, child: Text("Edit")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _saveImage, child: Text("Save")),
            ],
          ),
        ],
      ),
    );
  }
}
