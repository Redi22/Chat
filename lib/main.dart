// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:fluter/pages/SignIn.dart';
import 'package:fluter/pages/SignUp.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
        title: "sera plz ",
        theme: ThemeData(
          primaryColor: Color(0xffff3a5a)

        ),
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      initialRoute: MyApp.id,
      routes: {
          MyApp.id : (context) => MyApp(),
        SignIn.id : (context) => SignIn(),
        SignUp.id : (context) => SignUp(),



      },
    ) );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const String id = "MYAPP";

  @override
  Widget build(BuildContext context) {

   return Scaffold(


       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Hero(
             tag: "logo",
             child: Container(

               child: Icon(
                   Icons.chat,
                 color:  Color(0xffff3a5a) ,
                 size: 100,
               ),
               ),
             ),

           Text(
               "Were",
             style: TextStyle(
                fontSize: 40.0,
               fontStyle: FontStyle.italic,
             ),
            ),
           SizedBox(
             height: 150.0,
           ),
           CustomButton(
             text: "Sign Up",
             callback: (){
               Navigator.of(context).pushNamed(SignUp.id);
             },),
           SizedBox(
             height: 50.0,
           ),
           Container(
             padding: EdgeInsets.symmetric(
               horizontal: 80.0,
             ),
            child: Row(
              children: <Widget>[
                Text("Already have an account?"),
                InkWell(

                   onTap:() { Navigator.of(context).pushNamed(SignIn.id);},
                   child: Container(
                     child: Text("  Login" , style: TextStyle(color: Color(0xffff3a5a)),),
                   ),
                 ),
              ],
            ),

           )


         ],
       )
   );


  }
}
class CustomButton extends StatelessWidget {
  const CustomButton({Key key, this.callback , this.text}) : super(key: key);
  final VoidCallback callback;
  final String text;


  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.all(8.0),

      child: Material(
        color: Color(0xffff3a5a),

        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(text),

        ),
      ),
    );
  }
}
