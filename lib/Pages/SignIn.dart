import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluter/pages/HomePage.dart';

class SignIn extends StatefulWidget {
  static const String id = "SIGNIN";
  static final String path = "lib/hor_list/SignIn.dart";
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email, _password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(

          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: SecondWaveCliper(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0x22ff3a5a) , Color(0x22fe494d)]),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: ThirdWaveCliper(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0x44ff3a5a) , Color(0x44fe494d)]),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: FirstWaveCliper(),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffff3a5a) , Color(0xfffe494d)]),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                          size: 60,
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),

                )
              ],
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  onSaved: (input) => _email = input ,
                  validator: (input){
                    if(input.isEmpty){
                      return "Please provide an email";
                    }
                    return null;

                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric( horizontal: 20 , vertical: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  
                  validator: (input) {
                    if(input.length < 8){
                      return " Password must be more than 8 characters" ;
                    }
                    return null;
                  },
                  onSaved: (input)=> _password = input ,

                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.red,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric( horizontal: 20 , vertical: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color(0xffff3a5a),
                  child: FlatButton(
                      onPressed: (){
                       signIn();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight:  FontWeight.w700,
                            fontSize: 18
                        ),
                      ))
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child:
                InkWell(
                  onTap: (){},
                  child:
                  Text("Forgot Password?"),
                )
            ),

          ],
        ),
      ),

    );
  }
  Future<void> signIn() async{
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();
      print(_email);
      try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email?.trim() , password: _password);
       FirebaseUser user = await FirebaseAuth.instance.currentUser();
       print(user.displayName);
       Navigator.of(context).push(MaterialPageRoute(builder:(_)=>HomePage( username: user.email , userId: user.uid,)));
      }catch(e){
        print(e.message);
      }
    }

}

  }

class FirstWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6 , size.height - 75);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 100);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);


    var secondEndPoint = Offset(size.width , size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}
class ThirdWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6 , size.height - 65);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 100);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);


    var secondEndPoint = Offset(size.width , size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}
class SecondWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.7 , size.height - 40);
    var firstControlPoint = Offset(size.width * 0.25, size.height );
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);


    var secondEndPoint = Offset(size.width , size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}

