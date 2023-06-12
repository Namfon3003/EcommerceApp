import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../userPreferences/current_user.dart';
import 'favorites_fragment_screen.dart';
import 'home_fragment_screen.dart';
import 'order_fragment_screen.dart';
import 'profile_fragment_screen.dart';

class DashboardOfFragment extends StatelessWidget {
  // const DashboardOfFragment({super.key});
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  List<Widget> _fragmentScreen = [
    HomeFragmentScreen(),
    FavoritesFragmentScreen(),
    OrderFragmentScreen(),
    ProfileFragmentScreen()
  ];

  List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home"
    },
    {
      "active_icon": Icons.favorite,
      "non_active_icon": Icons.favorite_border,
      "label": "Favorites"
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "Orders"
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outlined,
      "label": "Profile"
    }
  ];
  RxInt _indexNumber = 0.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body:
                SafeArea(child: Obx(() => _fragmentScreen[_indexNumber.value])),
            bottomNavigationBar: Obx(() => BottomNavigationBar(
                  currentIndex: _indexNumber.value,
                  onTap: (value) {
                    _indexNumber.value = value;
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: Color.fromARGB(255, 96, 9, 146),
                  unselectedItemColor: Color.fromARGB(255, 111, 94, 139),
                  items: List.generate(4, (index) {
                    var navBtnProperties = _navigationButtonsProperties[index];
                    return BottomNavigationBarItem(
                        backgroundColor: Color.fromARGB(255, 237, 235, 238),
                        icon: Icon(navBtnProperties["non_active_icon"]),
                        activeIcon:
                            Icon(navBtnProperties["active_icon"], size: 50),
                        label: navBtnProperties["label"]);
                  }),
                )));
      },
    );
  }
}
