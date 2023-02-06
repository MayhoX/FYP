import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/api_connection/api_connection.dart';
import 'package:fyp/user/controllers/buy_card_controller.dart';
import 'package:fyp/user/model/cards.dart';
import 'package:fyp/user/model/sellingcards.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../userPreferences/current_user.dart';
import 'Sell_Card_screen.dart';
import '../controllers/buy_card_controller.dart';

class CardDetailsScreen extends StatefulWidget {
  final Cards? cardInfo;

  CardDetailsScreen({
    this.cardInfo,
  });

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  final buyCardController = Get.put(BuyCardController());
  var formKey = GlobalKey<FormState>();

  Future<List<SellingCards>> getSellngCard() async {
    List<SellingCards> sellingCardList = [];
    try {
      var Res = await http.post(
        Uri.parse(API.sellCardList),
        body: {
          "CardID": widget.cardInfo!.Card_ID.toString(),
        },
      );

      if (Res.statusCode == 200) {
        var responseBodyOfCardList = jsonDecode(Res.body);
        if (responseBodyOfCardList["success"] == true) {
          (responseBodyOfCardList['CardListData'] as List)
              .forEach((eachRecord) {
            sellingCardList.add(SellingCards.fromJson(eachRecord));
          });
        }
      } else {
        Fluttertoast.showToast(msg: ("200"));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

    return sellingCardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Card",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Text(
                "Sell",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(sellCardScreen(cardInfo: widget.cardInfo));
                },
                icon: const Icon(
                  Icons.sell,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              height: MediaQuery.of(context).size.height * 0.64,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              placeholder: const AssetImage("images/ImageError.png"),
              image: NetworkImage(
                widget.cardInfo!.Card_ImageURL!,
              ),
              imageErrorBuilder: (context, error, stackTraceError) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                  ),
                );
              },
            ),
            cardInfoWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: const [
                      Icon(Icons.add_task),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "User Upload Picture",
                      ),
                    ],
                  )),
            ),
            cardListWidget(context),
          ],
        ),
      ),
    );
  }

  BuyCard(eachCardRecord) async {
    try {
      SellingCards record = eachCardRecord;

      var totalPrice = buyCardController.qty * record.SellCard_Price!;
      var Res = await http.post(
        Uri.parse(API.buycard),
        body: {
          "SellCardID": record.SellCard_ID!.toString(),
          "CardID": record.Card_ID!.toString(),
          "BuyerID": _currentUser.user.User_ID.toString(),
          "SellerID": record.User_ID!.toString(),
          "Qty": buyCardController.qty.toString(),
          "TotalPrice": totalPrice.toString(),
          "Date": DateTime.now().toString(),
        },
      );

      if (Res.statusCode == 200) {
        var resBodyOfSellCard = jsonDecode(Res.body);

        if (resBodyOfSellCard['success'] == true) {
          Fluttertoast.showToast(msg: "Buy Card Successfully");

          Future.delayed(const Duration(milliseconds: 1000), () {
            // Get.back
          });
        } else {
          Fluttertoast.showToast(msg: "Input Error.");
        }
      } else {
        Fluttertoast.showToast(msg: "200");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  cardInfoWidget() {
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
              offset: Offset(0, -3),
              blurRadius: 6,
              color: Colors.black,
            ),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),

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

            const SizedBox(
              height: 18,
            ),
            //Name Pack Languages
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.cardInfo!.Card_Name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.cardInfo!.Card_Pack!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.cardInfo!.Card_Languages!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 18,
            ),

            //Rare Special Effect ATK DEF
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.cardInfo!.Card_Rare!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.cardInfo!.Card_Special!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.cardInfo!.Card_Effect!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "ATK/" + widget.cardInfo!.Card_Attack.toString()!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "DEF/" + widget.cardInfo!.Card_Defence.toString()!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 18,
            ),

            Text(
              widget.cardInfo!.Card_Description!,
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardListWidget(context) {
    return FutureBuilder(
      future: getSellngCard(),
      builder: (context, AsyncSnapshot<List<SellingCards>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          return const Center(
            child: Text(
              "No Trending Card found!",
            ),
          );
        }
        if (dataSnapShot.data!.length > 0) {
          return ListView.builder(
            itemCount: dataSnapShot.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              SellingCards eachCardRecord = dataSnapShot.data![index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Center(
                                child: Column(
                                  children: [
                                    //Seller Name
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                        const Text(
                                          "Seller: ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          eachCardRecord.User_Name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),

                                    //Price
                                    Row(
                                      children: [
                                        const Text(
                                          "Price ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.attach_money,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          eachCardRecord.SellCard_Price!
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    //Qty
                                    Row(
                                      children: [
                                        const Text(
                                          "Quantity: ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          eachCardRecord.SellCard_Qty!
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                  //Seller Name
                                ),
                              ),
                            ),
                            Obx(
                              () => DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (buyCardController.qty - 1 >= 1) {
                                          buyCardController.setQtyCard(
                                              buyCardController.qty - 1);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      buyCardController.qty.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (buyCardController.qty <
                                            eachCardRecord.SellCard_Qty!) {
                                          buyCardController.setQtyCard(
                                              buyCardController.qty + 1);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {
                                  //  if (formKey.currentState!.validate())
                                  //  {
                                  BuyCard(eachCardRecord);
                                  //  }
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    'Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).whenComplete(() {
                    buyCardController.resetQty();
                  });
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 6,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              //Seller Name
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    "Seller: ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    eachCardRecord.User_Name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              //Price
                              Row(
                                children: [
                                  const Text(
                                    "Price ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.attach_money,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    eachCardRecord.SellCard_Price!.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              //Qty
                              Row(
                                children: [
                                  const Text(
                                    "Quantity: ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    eachCardRecord.SellCard_Qty!.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: eachCardRecord!.SellCard_ImageURL != null
                            ? const Icon(Icons.add_task)
                            : const Icon(
                                Icons.sms_failed_outlined,
                                color: Colors.white,
                              ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: FadeInImage(
                          height: 150,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder:
                              const AssetImage("images/ImageError.png"),
                          image: NetworkImage(
                            // widget.cardInfo!.Card_ImageURL!,
                            eachCardRecord!.SellCard_ImageURL != null
                                ? eachCardRecord!.SellCard_ImageURL!
                                : widget.cardInfo!.Card_ImageURL!,
                          ),
                          imageErrorBuilder: (context, error, stackTraceError) {
                            return const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Empty, No Data."),
          );
        }
      },
    );
  }
}
