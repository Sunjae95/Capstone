
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  String contents;
  String displayName;
  String email;
  String photoUrl;
  String userPhotoUrl;

  Post({this.contents, this.displayName, this.email, this.photoUrl, this.userPhotoUrl});

  Map toMap(Post post) {
    var data = Map<String, dynamic>();
    data['contents'] = post.contents;
    data['displayName'] = post.displayName;
    data['email'] = post.email;
    data['photoUrl'] = post.photoUrl;
    data['userPhotoUrl'] = post.userPhotoUrl;
    return data;
  }

  Post.fromMap(Map<String, dynamic> mapData) {
    this.contents = mapData['contents'];
    this.displayName = mapData['displayName'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    this.userPhotoUrl = mapData['userPhotoUrl'];
  }

}