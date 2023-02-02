import 'package:flutter/material.dart';
import 'package:fyp/user/model/cards.dart';
import 'package:get/get.dart';

import 'Sell_Card_screen.dart';

class CardDetailsScreen extends StatefulWidget {

  final Cards? cardInfo;

  CardDetailsScreen({this.cardInfo,});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
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
              onPressed: (){
                Get.to(sellCardScreen());
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
      body: Stack(
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




          Align(
            alignment: Alignment.bottomCenter,
            child: cardInfoWidget(),
          )

        ],
      ),
    );
  }



  cardInfoWidget()
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
            //Name Pack Languages
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.cardInfo!.Card_Name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
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
                      fontSize: 18,
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
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18,),

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
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 16,),

                            Text(
                              widget.cardInfo!.Card_Special!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 16,),

                            Text(
                              widget.cardInfo!.Card_Effect!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        )
                      ],
                    )
                ),
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
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 16,),

                        Text(
                          "DEF/" + widget.cardInfo!.Card_Defence.toString()!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
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

            const SizedBox(height: 18,),


          ],
        ),
      ),
    );
  }
}





