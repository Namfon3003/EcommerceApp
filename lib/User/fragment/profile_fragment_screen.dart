import 'package:ecommerceapp/User/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/Login_Screen.dart';
import '../userPreferences/user_preferences.dart';

class ProfileFragmentScreen extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async {
    var resultResponse = await Get.dialog(AlertDialog(
      backgroundColor: Color.fromARGB(255, 252, 250, 250),
      title: Text(
        "Sign Out",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Text(
        "Are you sure? \nYou want to Sign Out from app",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "No",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: "loggedeOut");
          },
          child: const Text(
            "Yes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 7, 139, 25)),
          ),
        )
      ],
    ));

    if (resultResponse == "loggedeOut") {
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(HomePage());
      });
    }
  }

  Widget userInfoPrifile(IconData iconData, String userData) {
    return Container(
      // child: ,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 238, 225, 238)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Color.fromARGB(255, 141, 13, 173),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 58, 4, 71),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/namfon.jpg"),
                    radius: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  userInfoPrifile(Icons.person, _currentUser.user.user_name),
                  SizedBox(
                    height: 10,
                  ),
                  userInfoPrifile(Icons.email, _currentUser.user.user_email),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        signOutUser();
                      },
                      borderRadius: BorderRadius.circular(32),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: Text(
                            "Sign out",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 248, 247, 248),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
