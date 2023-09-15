import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  User? userData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;

    return Padding(
      padding: devicePadding,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "sign up screen",
          ),
        ),
        body: Container(
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,

                      hintText: " Name ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextFormField(
                    controller: emailController,
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

                      hintText: "Enter email ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        debugPrint("is valid");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      } else {
                        debugPrint("is not valid");
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextFormField(
                    controller: passwordController,
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
                      hintText: "Enter passcode ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Color(0xFF00AB6C)),
                      fixedSize: MaterialStatePropertyAll(
                        Size(screenWidth / 0.1, screenHeight / 16),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      // fixedSize: MaterialStatePropertyAll(
                      // Size(width: 10, height!),
                      // ),
                    ),
                    // onPressed: onPress ?? () {},
                    onPressed: () {
                      signup();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          ("login"),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((value) => {
                debugPrint(value.user.toString()),
                setState(() {}),
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        debugPrint('The password provided is too weak. ------------------------------------->>');
      } else if (e.code == 'wrong-password') {
        debugPrint('The account already exists for that email. ------------------------------------->>');
      }
    } catch (e) {
      debugPrint('$e ------------------------------------->>');
    }
  }
}
