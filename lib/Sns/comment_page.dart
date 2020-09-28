import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  final DocumentSnapshot doc;

  CommentPage(this.doc);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('댓글'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _commentStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((doc) {
              return ListTile(
                leading: Text(doc.data()['writer']),
                title: Text(doc.data()['comment']),
              );
            }).toList(),
          );
        }
      ),
    );
  }

  Stream<QuerySnapshot> _commentStream(){
    return FirebaseFirestore.instance
        .collection('post')
        .doc(doc.id)
        .collection('comment')
        .snapshots();
  }

}
