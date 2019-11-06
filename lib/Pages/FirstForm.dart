import 'package:fluter/models/Message_model.dart';
import 'package:fluter/models/User_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstForm extends StatefulWidget {
  final String username;
  final String userId;
  final String chatId;
  final User user;

  const FirstForm({Key key, this.username, this.userId, this.user, this.chatId})
      : super(key: key);

  @override
  _FirstFormState createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  static const String chats_ref = "chats";
  final firestore = Firestore.instance;

  CollectionReference get chatsCollection => firestore.collection(chats_ref);
  TextEditingController _controller = TextEditingController();

  final rand = Random();
  final String username = "Rediet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: getMessages(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return builder(snapshot.data);
              },
            ),
          ),
          _bottomBar(context),
        ],
      )),
    );
  }

  Row _bottomBar(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tag_faces),
        ),
        Expanded(
          child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Type message ")),
        ),
        IconButton(
          onPressed: () => _save(),
          icon: Icon(Icons.send),
        )
      ],
    );
  }

  Widget builder(List<Message> messages) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(height: 13.0);
      },
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        Message message = messages[index];
        if (message.id == widget.userId)
          return _buildMessageRow(message, current: true);
        return _buildMessageRow(message, current: false);
      },
    );
  }

  Row _buildMessageRow(Message message, {bool current}) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment:
          current ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 7.0,
            horizontal: 25.0,
          ),
          decoration: BoxDecoration(
              color:
                  current ? Theme.of(context).primaryColor : Colors.redAccent,
              borderRadius: current
                  ? BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0))
                  : BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
          child: Text(
            message.detail,
            style: TextStyle(
                color: current ? Colors.white : Colors.black, fontSize: 14.0),
          ),
        )
      ],
    );
  }

  _save() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    Message message =
        Message(unread: true, detail: _controller.text, userId: widget.userId);
    await chatsCollection.document().setData(message.toMap());
    _controller.clear();
  }

  Stream<List<Message>> getMessages() {
    return chatsCollection
        .orderBy("time", descending: true)
        .snapshots()
        .map(mapToMessages);
  }

  List<Message> mapToMessages(QuerySnapshot snapshot) {
    try {
      return snapshot.documents.map<Message>((doc) {
        print(doc.data);
        return Message.fromMap(doc.data);
      }).toList();
    } catch (e) {
      print(e);
      return <Message>[];
    }
  }
}
