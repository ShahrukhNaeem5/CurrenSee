import 'package:flutter/material.dart';
import 'package:fluttertest/Login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style2 =
        ElevatedButton.styleFrom(
          textStyle:
           const TextStyle(fontSize: 20),
                          padding: EdgeInsets.fromLTRB(90, 20, 90, 20),
                          backgroundColor: Color.fromARGB(255, 137, 0, 155),
                          foregroundColor: Color.fromARGB(255, 238, 236, 238),


           
           );
   return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page")
        
        ),
        body: Center(
          child:Column(
            children: [
              Container(
                child:Image.network("https://media.istockphoto.com/id/1139665893/vector/customer-profile-account-in-a-mobile-application-digital-marketing-user-overview-data.jpg?s=612x612&w=0&k=20&c=njEANxMHKQSFrGhcyqaeU9W7gLldMEHSO26ip2eOMnE="),

                width: 450,
                height: 400,
                

              ),

              SizedBox(height: 20,),

              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  
                  children: [
                    TextField(
                decoration: InputDecoration(
                  
                  
                  labelText: "Username",
                  fillColor: Colors.amber,
                  ),
                  ),
                    TextField(
                decoration: InputDecoration(
                  
                  labelText: "Password",
                  ),
                  ),

                  ],
                ),
              ),

             
              
              
               ElevatedButton(
                style: style2,
                
                onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
              }, child: Text("SignUp")),
              SizedBox(height: 10,),
              
              
            ],
          ),
        ),
        );
   
  }
}