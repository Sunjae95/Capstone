import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comment_page.dart';

class FeedWidget extends StatefulWidget {
  final DocumentSnapshot doc;

  final User user;

  FeedWidget(this.doc, this.user);

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentCount = widget.doc.data()['commentCount'] ?? 0;
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.doc.data()['userPhotoUrl']),
          ),
          title: Text(
            widget.doc.data()['email'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.more_vert),
        ),
        Image.network(
          widget.doc.data()['photoUrl'],
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.doc.data()['LikedUsers']?.contains(widget.user.email) ??
                      false
                  ? GestureDetector(
                      onTap: _unlike,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                  : GestureDetector(
                      onTap: _like, child: Icon(Icons.favorite_border)),
              SizedBox(
                width: 8.0,
              ),
              Icon(Icons.comment),
              SizedBox(
                width: 8.0,
              ),
              Icon(Icons.send),
            ],
          ),
          trailing: Icon(Icons.bookmark_border),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Text(
              '좋아요 ${widget.doc.data()['LikedUsers']?.length ?? 0}개',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Text(
              widget.doc.data()['email'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(widget.doc.data()['contents']),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        if (commentCount > 0)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentPage(widget.doc),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '댓글 $commentCount개 모두 보기',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Text(widget.doc.data()['lastComment'] ?? ''),
                ],
              ),
            ),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: _commentController,
                  onSubmitted: (text) {
                    _writeComment(text);
                    _commentController.text = '';
                  },
                  decoration: InputDecoration(
                    hintText: '댓글 달기',
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  // 좋아요
  void _like() {
    // 기존 좋아요 리스트로 복사하기
    final List likedUsers =
        List<String>.from(widget.doc.data()['likedUsers'] ?? []);

    // 나를 추가
    likedUsers.add(widget.user.email);

    //업데이트할 항목을 문서로 준비
    final updateData = {
      'likedUsers': likedUsers,
    };

    FirebaseFirestore.instance
        .collection('post')
        .doc(widget.doc.id)
        .update(updateData);
  }

  // 좋아요 취소
  void _unlike() {
    // 기존 좋아요 리스트로 복사하기
    final List likedUsers =
        List<String>.from(widget.doc.data()['likedUsers'] ?? []);

    // 나를 추가
    likedUsers.remove(widget.user.email);

    //업데이트할 항목을 문서로 준비
    final updateData = {
      'likedUsers': likedUsers,
    };

    FirebaseFirestore.instance
        .collection('post')
        .doc(widget.doc.id)
        .update(updateData);
  }

  // 댓글 작성
  void _writeComment(String text) {
    final data = {
      'writer' : widget.user.email,
      'comment' : text,
    };

    // 댓글 추가
    FirebaseFirestore.instance.collection('post')
    .doc(widget.doc.id)
    .collection('comment')
    .add(data);

    final updateData = {
      'lastComment' : text,
      'commentCount' : (widget.doc.data()['commentCount'] ?? 0 ) +1,
    };

    FirebaseFirestore.instance
    .collection('post')
    .doc(widget.doc.id)
    .update(updateData);


  }
}
