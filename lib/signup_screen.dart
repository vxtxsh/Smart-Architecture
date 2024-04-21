import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'standard/rounded_button.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 95, 43, 10), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 95, 46, 7), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),

  labelStyle: TextStyle(color: Colors.white),
);

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 98, 46, 16),
        title: const Text(
          "Smart Architecture",
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 114, 42, 24),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                         ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Password')),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  colour: Color.fromARGB(255, 75, 41, 8),
                  title: 'Register',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, 'home_screen');
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
