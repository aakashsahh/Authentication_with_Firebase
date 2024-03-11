import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/forgot.dart';
import 'package:login_firebase/signup.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("An error occured", e.message.toString());
    } catch (e) {
      Get.snackbar("An error Occured", e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(hintText: 'Enter your email'),
                  ),
                  TextField(
                    controller: password,
                    decoration: const InputDecoration(hintText: 'Enter your password'),
                  ),
                  ElevatedButton(onPressed: (() => signIn()), child: const Text("Login")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: (() => Get.to(Signup())), child: const Text("Register now")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: (() => Get.to(Forgot())), child: const Text("Forgot Password"))
                ],
              ),
            ),
          );
  }
}
