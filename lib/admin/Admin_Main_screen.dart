import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/admin/Admin_Upload_Card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../user/login_screen.dart';
import '../user/userPreferences/user_preferences.dart';

class AdminMainScreen extends StatelessWidget {
  LogoutUser() async {
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
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
          TextButton(
              onPressed: () {
                Get.back(result: "logout");
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ))
        ],
      ),
    );

    if (result == "logout") {
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Admin Page",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            children: [
              Center(
                child: Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(AdminUploadCardScreen());
                    },
                    borderRadius: BorderRadius.circular(32),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 120,
                        vertical: 12,
                      ),
                      child: Text(
                        "Upload Card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Material(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      LogoutUser();
                    },
                    borderRadius: BorderRadius.circular(32),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
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
        },
      ),
    );
  }
}
