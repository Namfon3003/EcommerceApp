import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';
import '../models/user_model.dart';
import 'package:logger/logger.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var log = Logger();
  var formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail),
          body: {'user_email': emailController.text.trim()});

      if (res.statusCode == 200) {
        // log.d("status ok");
        var resBodyOfValidateEmail = jsonDecode(res.body);

        if (resBodyOfValidateEmail["emailFound"] == true) {
          Fluttertoast.showToast(
              msg: "Email is already in someone else use.Try another email.");
        } else {
          registerAndSaveRecord();
        }
      }
    } catch (e) {
      // ignore: avoid_print
      log.d(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registerAndSaveRecord() async {
    User userModels = User(1, nameController.text.trim(),
        emailController.text.trim(), passwordController.text.trim());

    try {
      var res =
          await http.post(Uri.parse(API.signUp), body: userModels.toJson());
      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);
        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulation, you are SignUp successfully.");

          setState(() {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
          });
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "Error occured, Try again.");
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
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
                                  controller: nameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Your Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.deepPurple.shade50,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple.shade700,
                                      ),
                                      hintText: "Your Name",
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
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Your Email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.deepPurple.shade50,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.purple.shade700,
                                      ),
                                      hintText: "Email",
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
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return "Please enter password";
                                        }
                                        return null;
                                      },
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
                                          hintText: "Password",
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
                                      {
                                        validateUserEmail(),
                                      }

                                    // log.d("tab btn")
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
                                    child: const Text("Sign Up",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 15,
                        ),
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
