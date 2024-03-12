import 'package:flutter/material.dart';
import 'package:fluttertest/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class AnimatedSignupImage extends StatefulWidget {
  @override
  _AnimatedSignupImageState createState() => _AnimatedSignupImageState();
}

class _AnimatedSignupImageState extends State<AnimatedSignupImage>
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
          child: Container(
            child: Image(
              image: AssetImage('images/SignUp.jpg'),
              height: 400,
              width: 400,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
        TextEditingController FirstNameController=TextEditingController();
        TextEditingController LastNameController=TextEditingController();
        TextEditingController EmailController=TextEditingController();
        TextEditingController PasswordController=TextEditingController();
        TextEditingController CountryController=TextEditingController();



    final ButtonStyle style2 = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: EdgeInsets.fromLTRB(90, 20, 90, 20),
      backgroundColor: Color.fromARGB(255, 137, 0, 155),
      foregroundColor: Color.fromARGB(255, 238, 236, 238),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedSignupImage(), // Include the AnimatedSignupImage widget

            SizedBox(height: 20),

            Container(
              margin: EdgeInsets.all(20),
              child:  Column(
                children: [
                  TextField(
                    controller: FirstNameController,
                      decoration: InputDecoration(
                      labelText: "First Name",
                      
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  TextField(
                    controller: LastNameController,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  TextField(
                    controller: EmailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    controller: PasswordController,
                       obscureText: true,
                    decoration: InputDecoration(

                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  TextField(
                    controller: CountryController,
                    decoration: InputDecoration(
                      labelText: "Country",
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
  style: style2,
  onPressed: () async {
    CollectionReference tab = FirebaseFirestore.instance.collection("UserRegistration");
    String email = EmailController.text;

    // Check if the email already exists
    QuerySnapshot emailSnapshot = await tab.where('Email', isEqualTo: email).get();

    if (emailSnapshot.docs.isNotEmpty) {
      // Email already exists
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Exists'),
            content: Text('The provided email is already registered. Please use a different email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Email doesn't exist, proceed with registration
      String id = randomNumeric(2);
      await tab.doc(id).set({
        'Id': id,
        'FirstName': FirstNameController.text,
        'LastName': LastNameController.text,
        'Email': EmailController.text,
        'Password': PasswordController.text,
        'Country': CountryController.text,
      }).then((_) {
        // Registration successful, redirect to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }).catchError((e) => print('Failed to add user: $e'));
    }
  },
  child: Text('Sign Up'),
)


            /* ElevatedButton(
                 style: style2,

              onPressed: ()async{
                CollectionReference tab = FirebaseFirestore.instance.collection("UserRegistration");
                String Id = randomNumeric(2);
                tab.doc(Id).set({
                  'Id': Id,
                  'FirstName' : FirstNameController.text,
                  'LastName' :LastNameController.text, 
                  'Email' :EmailController.text, 
                  'Password' :PasswordController.text, 
                  'Country' :CountryController.text, 
                }).then((value) => 
                print ('user add')).catchError((e)=> print('faild to add $e'));
                  
                },
       child: Text('Sign Up')), */
      



           
            ,SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
