// ignore: file_names
// ignore: file_names
import 'dart:convert';

import 'package:ecommerceapp/User/fragment/dashboard_of_fragment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../models/user_model.dart';
import '../userPreferences/user_preferences.dart';
import 'signup_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isObsecure = true.obs;

  loginUserNow() async {
    try {
      var res = await http.post(Uri.parse(API.logIn), body: {
        "user_email": emailController.text.trim(),
        "user_password": passwordController.text.trim()
      });

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success'] == true) {
          Fluttertoast.showToast(msg: "You are Logged-in successfully.");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          await RememberUserPrefs.storeUserInfo(userInfo);
          Future.delayed(const Duration(milliseconds: 2000), () {
            Get.to(DashboardOfFragment());
          });
        } else {
          Fluttertoast.showToast(
              msg:
                  "Incorrect Credentials ,\n Please write correct password or email, Try Again");
        }
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: cons.minHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: Image.asset("images/UMElogo4.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  validator: (val) => val == ""
                                      ? "Please write your Email"
                                      : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.deepPurple.shade50,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.purple.shade700,
                                      ),
                                      hintText: "umeapp42@gmail.com",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white60),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6)),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Obx(() => TextFormField(
                                      controller: passwordController,
                                      obscureText: isObsecure.value,
                                      validator: (val) => val == ""
                                          ? "Please write your Password"
                                          : null,
                                      decoration: InputDecoration(
                                          fillColor: Colors.deepPurple.shade50,
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons.key,
                                            color: Colors.purple.shade700,
                                          ),
                                          suffixIcon: Obx(() => GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =
                                                      !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors
                                                      .deepPurple.shade700,
                                                ),
                                              )),
                                          hintText: "*******",
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white60),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white60),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white60),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white60),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 14, vertical: 6)),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                MaterialButton(
                                  onPressed: () => {
                                    if (formkey.currentState!.validate())
                                      {loginUserNow()}
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 101, 57, 223),
                                          Color.fromARGB(255, 196, 42, 196),
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 15),
                                    child: const Text("Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ));
                              },
                              child: const Text(
                                "SignUp Here",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurpleAccent),
                              ),
                            )
                          ],
                        ),
                        const Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Are you an Admin?",
                              style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Click Here",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurpleAccent),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
