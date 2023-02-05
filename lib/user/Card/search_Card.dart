import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/api_connection/api_connection.dart';
import 'package:get/get.dart';
import '../model/cards.dart';
import 'package:http/http.dart' as http;


class SearchCard extends StatefulWidget {

  // final String? searchKeyWords;

  // SearchCard({this.searchKeyWords});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {

  TextEditingController searchController = TextEditingController();

  Future<List<Cards>> readSearchRecordFound() async
  {
    List<Cards> searchList = [];

    if (searchController.text != "")
    {
      try
      {
        var res = await http.post(
          Uri.parse(API.searchCard),
            body:
            {
              "keyword": searchController.text
            }
        );

        if (res.statusCode == 200)
        {
          var responseBodyOfSearchCards = jsonDecode(res.body);

          if(responseBodyOfSearchCards['success'] == true)
          {
            ((responseBodyOfSearchCards['CardData'] ??[])as List).forEach((eachData)
            {
              searchList.add(Cards.fromJson(eachData));
            });

          }
          else
          {
            // Fluttertoast.showToast(msg: "200");
          }


        }

      }
      catch(e)
      {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }

    }
    return searchList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: showSearchBarWidget(context),
        titleSpacing:  0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ) ,
      body: SearchCardWidget(context),
    );
  }


  showSearchBarWidget(context)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: searchController,
        autofocus: true,
        onChanged: (value){
          setState((){});
          SearchCardWidget(context);
        },
        decoration: InputDecoration(
          hintText: "Search..",
          helperStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          suffixIcon: IconButton(
            onPressed: (){
              searchController.text ="";
            },
            icon: const Icon(
              Icons.close_outlined,
              color:  Colors.black,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  SearchCardWidget(context)
  {
    return FutureBuilder(
      future: readSearchRecordFound(),
      builder: (context, AsyncSnapshot<List<Cards>> dataSnapShot)
      {
        if(dataSnapShot.connectionState == ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(dataSnapShot.data == null)
        {
          return const Center(
            child: Text(
              "No Trending Card found!",
            ),
          );
        }
        if(dataSnapShot.data!.length >0)
        {
          return ListView.builder(
            itemCount: dataSnapShot.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index)
            {
              Cards eachCardRecord = dataSnapShot.data![index];
              return GestureDetector(
                onTap: (){
                  // Get.to(CardDetailsScreen(cardInfo: eachCardRecord));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == dataSnapShot.data!.length -1 ? 16 : 8
                  ),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow:
                    const [
                      BoxShadow(
                        offset: Offset(0,0),
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

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachCardRecord.Card_Name!,
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
                                    eachCardRecord.Card_Languages!,
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
                          placeholder: const AssetImage("images/ImageError.png"),
                          image: NetworkImage(
                            eachCardRecord.Card_ImageURL!,
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
                      ),
                    ],
                  ),
                ),
              );
            },

          );
        }
        else
        {
          return const Center(

          );
        }
      },
    );
  }
}



