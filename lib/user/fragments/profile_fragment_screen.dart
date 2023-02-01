import 'package:flutter/material.dart';
import 'package:fyp/user/login_screen.dart';
import 'package:fyp/user/userPreferences/current_user.dart';
import 'package:fyp/user/userPreferences/user_preferences.dart';
import 'package:get/get.dart';




class ProfileFragmentsScreen extends StatelessWidget
{

  final CurrentUser _currentUser = Get.put(CurrentUser());

  LogoutUser() async
  {
    var result = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure Logout?",
        ),
        actions: [
          TextButton(
              onPressed: (){
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
          TextButton(
              onPressed: (){
                Get.back(result: "logout");
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          )
        ],
      ),
    );

    if(result == "logout")
    {
      RememberUserPrefs.removeUserInfo().then((value)
        {
          Get.off(LoginScreen());
        });
    }

  }

  Widget userInfoItem(IconData iconData, String userData)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 16,),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Center(
            child: Image.asset(
              "images/Duck.jpg",
              width: 100,
            ),
          ),
            
          const SizedBox(height: 20,),

          userInfoItem(Icons.person, _currentUser.user.User_Name),

          const SizedBox(height: 20,),

          userInfoItem(Icons.email, _currentUser.user.User_Email),


          const SizedBox(height: 20,),

          Center(
            child: Material(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: ()
                {
                  LogoutUser();
                },
                borderRadius: BorderRadius.circular(32),
                child: const Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child:  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ),
          )

        ],
    );
  }
}

