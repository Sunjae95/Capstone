import 'dart:io';

import 'package:capstone_agomin/profile/profiledata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    // ignore: await_only_futures
    _user = await _firebaseAuth.currentUser;
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    StorageReference storageReference =
        _firebaseStorage.ref().child("profile/${_user.uid}");

    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드 완료까지 대기
    await storageUploadTask.onComplete;

    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
    });
  }

  Widget _buildCameraButton() {
    return InkWell(
      child: Icon(
        Icons.photo_camera,
        color: Colors.white,
      ),
      onTap: () async {
        await getImage(ImageSource.camera);
      },
    );
  }

  Widget _buildPhotoAlbumButton() {
    return InkWell(
      child: Icon(
        Icons.photo_library,
        color: Colors.white,
      ),
      onTap: () async {
        await getImage(ImageSource.gallery);
      },
    );
  }

  Widget _inputImage() {
    return Container(
      width: 250,
      height: 250,
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            // constraints: BoxConstraints.expand(),
            child: _image == null
                ? Image.asset('assets/gomiLogo.jpg')
                : Image.network(_profileImageURL),
          ),
          Container(
            color: Colors.black54,
            height: 40,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildCameraButton(),
              _buildPhotoAlbumButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 16, top: 12, bottom: 32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.assignment_ind),
                    labelText: "이름",
                  ),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.cake),
                    labelText: "나이",
                  ),
                ),
                TextFormField(
                  controller: _speciesController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.tag_faces),
                    labelText: "견종",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputData() {
    return RaisedButton(
      child: Text('저장하기'),
      onPressed: () {
        ProfileData input = ProfileData(
          profileImageURL: _profileImageURL,
          name: _nameController.text,
          age: _ageController.text,
          species: _speciesController.text,
        );
        Navigator.pop(context, input);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _inputImage(),
              _inputForm(size),
              SizedBox(
                height: 50,
              ),
              _inputData(),
            ],
          ),
        ),
      ),
    );
  }
}
