import 'package:chat_app/widgets/chats/messages.dart';
import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
   final fbm = FirebaseMessaging();
   fbm.requestNotificationPermissions();
   fbm.configure(onMessage: (msg) {
     print(msg);
     return;
   }, onLaunch: (msg) {
     print(msg);
     return;
   }, onResume: (msg) {
     print(msg);
     return;
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('FlutterChat'),
      actions: <Widget>[
        DropdownButton(icon: Icon(
          Icons.more_vert, 
          color: Theme.of(context).primaryIconTheme.color,
          ),
          items: [
            DropdownMenuItem(child: Container(child: Row(children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8,),
              Text('Logout'),
            ],
            ),
            ),
            value: 'logout',
            ),
          ],
          onChanged: (itemIdetifier) {
            if (itemIdetifier == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          ),
      ],),
        body: Container(child: Column(children: <Widget>[
          Expanded(
            child: Messages(),
            ),
            NewMessage(),
        ],),),
          
              
              );  
  }
}