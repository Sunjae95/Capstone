import 'package:capstone_agomin/Helper/repository.dart';
import 'package:capstone_agomin/Helper/user.dart';
import 'package:capstone_agomin/Home/Follow/friend_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _repository = Repository();
  // ignore: unused_field
  Member _users = Member();
  Member me;
  Member user, followingUser;
  List<Member> usersList = List<Member>();
  List<String> followingUIDs = List<String>();
  @override
  void initState() {
    // _repository.getCurrentUser().then((user) {
    //   print("USER : ${user.displayName}");
    //   //follower load
    //   _repository.fetchFollowUsers(user).then((updatedList) {
    //     setState(() {
    //       usersList = updatedList.cast<Member>();
    //     });
    //   });
    // });
    super.initState();
    followee();
  }

  Future<void> followee() async {
    User currentUser = await _repository.getCurrentUser();
    //User객체에서 Member객체로 전환
    Member user = await _repository.fetchUserDetailsById(currentUser.uid);
    setState(() {
      this.me = user;
    });
    //여기부터 시작
    followingUIDs = await _repository.fetchFollowingUids(currentUser);

    for (var i = 0; i < followingUIDs.length; i++) {
      print("String 형식의 List배열 : ${followingUIDs[i]}");
      this.user = (await _repository.fetchUserDetailsById(followingUIDs[i]));
      print("user List에 등록: ${this.user.uid}");
      usersList.add(this.user);
      print("User displayname: ${usersList[i].displayName}");
      print("User uid:${usersList[i].uid}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: new Color(0xfff8faf8),
          centerTitle: true,
          title: Text('Followers', style: TextStyle(color: Colors.black)),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     onPressed: () {
          //       showSearch(
          //           context: context,
          //           delegate: ChatSearch(usersList: usersList));
          //     },
          //   )
          // ],
        ),
        //follower load
        body: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ChatDetailScreen(
                                photoUrl: usersList[index].photoUrl,
                                name: usersList[index].displayName,
                                receiverUid: usersList[index].uid,
                              ))));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(usersList[index].photoUrl),
                  ),
                  title: Text(usersList[index].displayName),
                ),
              ),
            );
          }),
        ));
  }
}

class ChatSearch extends SearchDelegate<String> {
  List<Member> usersList;
  ChatSearch({this.usersList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Member> suggestionsList = query.isEmpty
        ? usersList
        : usersList.where((p) => p.displayName.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: ((context, index) => ListTile(
            onTap: () {
              //   showResults(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChatDetailScreen(
                            photoUrl: suggestionsList[index].photoUrl,
                            name: suggestionsList[index].displayName,
                            receiverUid: suggestionsList[index].uid,
                          ))));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(suggestionsList[index].photoUrl),
            ),
            title: Text(suggestionsList[index].displayName),
          )),
    );
  }
}
