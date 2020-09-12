

import 'package:chat_app/widgets/chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream : FirebaseAuth.instance.idTokenChanges(),
          builder: (ctx, futureSnapshot) { 
             if(futureSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),
              );
             }
           return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        final chatDocs = chatSnapshot.data.docs;
        return  ListView.builder(
            
            reverse: true,
            itemCount: chatDocs.length,
             itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index].data()['text'],
              chatDocs[index].data()['username'],
              chatDocs[index].data()['userImage'],
              chatDocs[index].data()['userId'] == futureSnapshot.data.uid,
              key: ValueKey(chatDocs[index].id),
                ),
               
          );
          } );
          }
      
    );}
          
} 