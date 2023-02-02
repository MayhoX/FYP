import 'package:flutter/material.dart';
import 'package:fyp/user/fragments/favorites_fragment_screen.dart';
import 'package:fyp/user/fragments/home_fragments_screen.dart';
import 'package:fyp/user/fragments/order_fragments_screen.dart';
import 'package:fyp/user/fragments/profile_fragment_screen.dart';
import 'package:fyp/user/userPreferences/current_user.dart';
import 'package:get/get.dart';



class DashboardOfFragments extends StatelessWidget {

  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final List<Widget> _fragmentScreens =
  [
    HomeFragmentsScreen(),
    FavoritesFragmentsScreen(),

    OrderFragmentsScreen(),
    ProfileFragmentsScreen(),
  ];

  final List _navigationBar =
  [
    {
      'active_icon': Icons.home,
      'non_active_icon': Icons.home_outlined,
      'label': 'Home',
    },
    {
      'active_icon': Icons.favorite,
      'non_active_icon': Icons.favorite_border,
      'label': 'Favorites',
    },
    {
      'active_icon': Icons.shopping_basket,
      'non_active_icon': Icons.shopping_basket_outlined,
      'label': 'Orders',
    },
    {
      'active_icon': Icons.person,
      'non_active_icon': Icons.person_outline,
      'label': 'Profile',
    },
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CurrentUser(),
      initState: (currentState)
      {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller)
      {
        return Scaffold(
          backgroundColor: Colors.white,
          body:SafeArea(
            child: Obx(
                ()=>_fragmentScreens[_indexNumber.value]
            ),
          ),

          //NavBar
          bottomNavigationBar: Obx(
              ()=>BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value){
                 _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black26,
                items: List.generate(4, (index) {
                  var navBar = _navigationBar[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(navBar["non_active_icon"]),
                    activeIcon: Icon(navBar["active_icon"]),
                    label: navBar['label'],
                  );
                }),
              ),
          ),
        );
      },
    );
  }
}
