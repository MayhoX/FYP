import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/api_connection/api_connection.dart';
import 'package:get/get.dart';

import '../controllers/sell_card_controller.dart';
import '../model/cards.dart';
import '../userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class sellCardScreen extends StatefulWidget {

  final Cards? cardInfo;


  sellCardScreen({this.cardInfo});


  @override
  State<sellCardScreen> createState() => _sellCardScreenState();
}


class _sellCardScreenState extends State<sellCardScreen> {

  final CurrentUser _currentUser = Get.put(CurrentUser());
  final sellCardController = Get.put(SellCardController());

  var formKey = GlobalKey<FormState>();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();

  sellCard() async
  {
    try
    {

      var Res = await http.post(
        Uri.parse(API.sellcard),
        body: {
          "CardID": widget.cardInfo!.Card_ID.toString(),
          "SellerID": _currentUser.user.User_ID.toString(),
          "Price": priceController.text.trim(),
          "Qty": sellCardController.qty.toString(),
          "Description": descriptionController.text.trim(),
          "Date": DateTime.now().toString(),
        },
      );

      if(Res.statusCode == 200)
      {

        var resBodyOfSellCard = jsonDecode(Res.body);

        if (resBodyOfSellCard['success'] == true)
        {
          Fluttertoast.showToast(msg: "Sell Card Successfully");

          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.back();
          });

        }else{
          Fluttertoast.showToast(msg: "Input Error.");
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "200");
      }

    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }



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

      body: SingleChildScrollView(

        child: Column(
          children: [
            FadeInImage(
              height: MediaQuery.of(context).size.height* 0.64,
              width: MediaQuery.of(context).size.width,

              fit: BoxFit.cover,
              placeholder: const AssetImage("images/ImageError.png"),
              image: NetworkImage(
                widget.cardInfo!.Card_ImageURL!,
              ),
              imageErrorBuilder: (context, error, stackTraceError)
              {
                return const Center(
                  child:  Icon(
                    Icons.broken_image_outlined,
                  ),
                );
              },
            ),


            SellCardWidget(),





          ],
        ),

      ),



    );
  }

  Widget SellCardWidget()
  {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.4,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,-3),
              blurRadius: 6,
              color: Colors.black,
            ),
          ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 18,),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 18,),

            Form(
              key: formKey,
              child: Column(
                children: [

                  //Price
                  TextFormField(
                    controller: priceController,
                    validator: (val) =>
                    val == "" ? "Please input Selling Price" : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: Colors.black,
                      ),
                      hintText: "Price",
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
                      fillColor: Colors.black26,
                      filled: true,
                    ),
                  ),

                  const SizedBox(height: 18,),

                  //Qty
                  Obx(
                      ()=> Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Quantity",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                           const SizedBox(width: 12,),

                           DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                    offset: Offset(2.0,2.0),
                                    blurRadius: 4.0
                                )
                              ]
                            ),
                            child: Row(
                                children: [
                                  IconButton(
                                    onPressed: ()
                                    {
                                      if(sellCardController.qty - 1 >= 1)
                                      {
                                        sellCardController.setQtyCard(sellCardController.qty - 1);
                                      }

                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color:  Colors.black,
                                    ),
                                  ),
                                  Text(
                                    sellCardController.qty.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: ()
                                    {
                                      sellCardController.setQtyCard(sellCardController.qty + 1);
                                    },
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color:  Colors.black,
                                    ),
                                  ),
                                ],
                            ),
                          ),
                        ],
                      )
                  ),

                  const SizedBox(height: 18,),

                  //Description
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.black,
                      ),
                      hintText: "Description (optional)",
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
                      fillColor: Colors.black26,
                      filled: true,
                    ),
                  ),

                  const SizedBox(height: 18,),

                  Material(
                    elevation: 4,
                    color: Colors.red,
                    borderRadius:  BorderRadius.circular(10),
                    child: InkWell(
                      onTap: ()
                      {
                        sellCard();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: const Text(
                          "Sell",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )


                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

}
