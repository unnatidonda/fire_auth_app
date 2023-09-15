import 'package:fire_auth_app/view/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Padding(
        padding: devicePadding,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(screenWidth / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
                        return "Enter email id ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      labelText: "email",
                      hintText: "Enter email ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9]{6}$").hasMatch(value!)) {
                        return "Enter Passcode";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      labelText: "password",
                      hintText: "Enter password ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), fixedSize: MaterialStatePropertyAll(Size(screenWidth / 1, screenHeight / 18)), backgroundColor: const MaterialStatePropertyAll(Colors.orange)),
                    onPressed: () {
                      loginuser();
                      if (formkey.currentState!.validate()) {
                        debugPrint("is valid");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const HomeView(),
                        //   ),
                        // );
                      } else {
                        debugPrint("is not valid");
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginuser() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,
          )
          .then(
            (value) => (value) {
              debugPrint(value.user.toString());
              setState(() {});
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.------------------------------------------------------------------->>>');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.------------------------------------------------------------------->>>');
      }
    } catch (e) {
      debugPrint("$e ------------------------------------------------------------------->>>");
    }
  }
}
