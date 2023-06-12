import 'package:ecommerceapp/User/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'User/authentication/login_screen.dart';
import 'User/fragment/dashboard_of_fragment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: RememberUserPrefs.readUserInfo(),
          builder: (context, dataSnapshot) {
            //return const HomePage();
            if (dataSnapshot.data == null) {
              return HomePage();
            } else {
              return DashboardOfFragment();
            }
          },
        ));
  }
}
