import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(String) onImagePicked;
  ProfileImagePicker({super.key, required this.onImagePicked});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: await _showPickerDialog(), // either camera or gallery
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
      widget.onImagePicked(_imagePath!);
    }
  }

  Future<ImageSource> _showPickerDialog() async {
    return await showModalBottomSheet<ImageSource>(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ) ??
        ImageSource.gallery; // default fallback
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: _pickImage,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: ScreenUtil().setHeight(141),
                      height: ScreenUtil().setHeight(141),
                      
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: _imageFile != null ? FileImage(_imageFile!) : AssetImage('assets/algenie_logo.png'),
                              
                          )
                      )
                  ),
                  Positioned(
                      bottom: -2,
                      left: 0,
                      right: 0,
                      child: Image.asset('assets/Subtraction.png',
                          fit: BoxFit.fitHeight,
                          height: ScreenUtil().setHeight(37.2),
                          width: ScreenUtil().setWidth(124.71))),
                  Positioned(
                      bottom: -5,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10)),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 30,
                            )),
                      ))
                ],
              ),
            ],
          )),
    );
  }
}
