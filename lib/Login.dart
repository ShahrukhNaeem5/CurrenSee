import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertest/Converter.dart';

class BouncingImage extends StatefulWidget {
  @override
  _BouncingImageState createState() => _BouncingImageState();
}

class _BouncingImageState extends State<BouncingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Define position (translation) animation
    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0, // Adjust this value to control the bounce height
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Set up a repeating bounce animation
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, _positionAnimation.value),
          child: child,
        );
      },
      child: Image(
        image: AssetImage('images/Login.jpg'), // Adjust the path accordingly
        height: 400,
        width: 400,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController useremailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style2 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: EdgeInsets.fromLTRB(90, 20, 90, 20),
      backgroundColor: Color.fromARGB(255, 137, 0, 155),
      foregroundColor: Color.fromARGB(255, 238, 236, 238),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          children: [
            BouncingImage(),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: useremailController,
                    decoration: InputDecoration(
                      labelText: "User Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: style2,
              onPressed: () {
                getUserData(useremailController.text);
              },
              child: Text("LOGIN"),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void getUserData(String useremail) {
    FirebaseFirestore.instance
        .collection('UserRegistration')
        .where('Email', isEqualTo: useremail)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        // Email found in database, navigate to Converter page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Converter()),
        );
      } else {
        // Email not found in database, show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Email Incorrect"),
              content: Text("The provided email is not registered."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}
