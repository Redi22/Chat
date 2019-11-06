import 'package:fluter/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUp extends StatefulWidget {
  static const String id = "SIGNUP";
  static final String path = "lib/hor_list/SignUp.dart";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email , _password;
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
                      height: 300,
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
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0x44ff3a5a) , Color(0x44fe494d)]),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: FirstWaveCliper(),
                    child: Container(
                      width: double.infinity,
                      height: 300,
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
                          Text(
                            "Let's Chat",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30
                            ),

                          )
                        ],
                      ),
                    ),

                  )
                ],
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
                  onSaved: (input)=> _email = input,
                  validator: (input) {
                    if(input.isEmpty){
                      return "Please enter an email";
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
                  onSaved: (input) => _password = input,
                  validator: (input) {
                    if(input.length < 8){
                      return "must be more than 8 characters";

                    }
                    return null;
                  },
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
                        _handleSignIn();
                      },
                      child: Text(
                        "Sign Up",
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
            ],
        ),
      ),
    );
  }
  Future<void>  _handleSignIn() async {
    final formState = _formKey.currentState;
    FirebaseUser user;
    if(formState.validate()){
      formState.save();
      try{
        await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        user = await _auth.currentUser();
        print("signed in " + user.displayName);
        print("userId ${user.uid}");
        Navigator.of(context).push(MaterialPageRoute(builder:(_)=>HomePage(username:user.displayName, userId: user.uid,)));

      }catch(e){
        print(e.message);
      }
    }


  }
}

class FirstWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
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
    // TODO: implement shouldReclip
    return false;
  }

}
class ThirdWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
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
    // TODO: implement shouldReclip
    return false;
  }

}
class SecondWaveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
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
    // TODO: implement shouldReclip
    return false;
  }

}
