import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluter/models/User_model.dart';
import 'package:flutter/material.dart';
import 'package:fluter/pages/FirstForm.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  final String username;
  final String userId;
  User user;
  static const String id = "HOMEPAGE";

   HomePage({Key key, this.username, this.userId}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xffff3a5a),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.menu),

        ),
        title: Text("$username"),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon( Icons.lock_open),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon( Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon( Icons.folder),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) => FirstForm(userId: userId , username: username,)));},
                child: ListTile(
                  leading:
                    CircleAvatar(
                      child: Text("$username[0]")
                      ,
                    ),
                    title:
                    Text("$username")
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
  }

