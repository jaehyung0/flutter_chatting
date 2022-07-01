import 'package:chatting/chatting/chat/message.dart';
import 'package:chatting/chatting/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    final user = _authentication.currentUser;
    if(user!=null){
      try {
        loggedUser = user;
        print(loggedUser!.email);
      }catch(e){
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        actions: [
          IconButton(
              onPressed: (){
                _authentication.signOut();
                //Navigator.pop(context);
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Messages()
              ),
              NewMessage()
            ],
          ),
        ),
      )
    );
  }
}
