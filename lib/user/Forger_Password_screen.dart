import 'package:flutter/material.dart';
import 'package:fyp/user/login_screen.dart';
import 'package:get/get.dart';

class ForgerPasswordScreen extends StatefulWidget {
  @override
  State<ForgerPasswordScreen> createState() => _ForgerPasswordScreenState();
}

class _ForgerPasswordScreenState extends State<ForgerPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.asset(
                      "images/CardAppLogo.png",
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,30,30,8),
                        child: Column(
                          children: [

                            //email password login

                            Form(
                              key: formKey,
                              child: Column(
                                children: [


                                  //Email textbox
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) =>
                                    val == "" ? "Please input email" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),


                                  //register button

                                  Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          'Forget Password',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),

                            //back to login

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    'Login?'
                                ),
                                TextButton(
                                  onPressed: ()
                                  {
                                    Get.to(LoginScreen());
                                  },
                                  child: const Text(
                                      "Here"
                                  ),
                                ),
                              ],
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
