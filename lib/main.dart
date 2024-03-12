import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Converter.dart';
import 'package:fluttertest/Login.dart';
import 'package:fluttertest/Signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyC1DvLecsN9coRXWQpqeS9EmNGSwQftVuc',
       appId: '1:1068435807420:android:0839ccb83e271e1cd684b9',
        messagingSenderId: '1068435807420',
         projectId: 'currenseeapp-794eb')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle sign = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.fromLTRB(90, 20, 90, 20),
      foregroundColor: Color.fromARGB(255, 137, 0, 155),
      backgroundColor: Color.fromARGB(255, 245, 195, 252),
    );
    final ButtonStyle login = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      padding: EdgeInsets.fromLTRB(90, 20, 90, 20),
      backgroundColor: Color.fromARGB(255, 137, 0, 155),
      foregroundColor: Color.fromARGB(255, 238, 236, 238),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Text("Sidebar"),
          ),
          ListTile(
            title: Text("Login"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          ListTile(
            title: Text("Signup"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
          )
        ],
      )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 77, 0, 136), // Top color (dark)
              Color.fromARGB(255, 160, 21, 240), // Middle color (mix)
              Colors.white, // Bottom color (white)
            ],
            stops: [
              0.0,
              0.7,
              1.0
            ], // 0% to 70% for top color, 70% to 100% for middle color, 100% for bottom color
          ),
        ),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Converter()));
                  },
                  child: Text("Convert Page")),
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Text("Currency Converter",
                  style: TextStyle(
                    color: Color.fromARGB(255, 248, 248, 248),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        // Here you define the shadow properties
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  )),
              Text("Powered By Financial Pvt Ltd",
                  style: TextStyle(
                      color: Color.fromARGB(255, 248, 248, 248),
                      fontWeight: FontWeight.normal,
                      fontSize: 12)),
              Container(
                child: Image(
                  image: AssetImage('images/aa.png'), // Check the path here
                  height: 400,
                  width: 400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: login,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("LOGIN")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: sign,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text("SIGN UP")),
            ],
          ),
        ),
      ),
    );
  }
}
