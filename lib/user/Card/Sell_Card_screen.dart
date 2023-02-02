import 'package:flutter/material.dart';
import 'package:get/get.dart';


class sellCardScreen extends StatefulWidget {

  @override
  State<sellCardScreen> createState() => _sellCardScreenState();
}


class _sellCardScreenState extends State<sellCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Sell Card",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,

        ),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
