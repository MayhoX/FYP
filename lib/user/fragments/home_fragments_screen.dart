import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/api_connection/api_connection.dart';
import 'package:fyp/user/Card/Card_details_screen.dart';
import 'package:fyp/user/Card/search_Card.dart';
import 'package:fyp/user/model/cards.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class HomeFragmentsScreen extends StatelessWidget {

  TextEditingController searchController = TextEditingController();

  Future<List<Cards>> getTrending() async
  {
    List<Cards> trendingCardList = [];

    try
    {
      var Res = await http.post(
        Uri.parse(API.getTrendingCard),
      );

      if(Res.statusCode == 200)
      {
        var responseBody = jsonDecode(Res.body);
        if (responseBody["success"] == true)
        {
          (responseBody['CardData'] as List).forEach((eachRecord)
          {
            trendingCardList.add(Cards.fromJson(eachRecord));
            
          });
        }
      }
      else
      {
        Fluttertoast.showToast(msg: ("200"));
      }

    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

    return trendingCardList;
  }

  Future<List<Cards>> getAll() async
  {
    List<Cards> allCardList = [];

    try
    {
      var Res = await http.post(
        Uri.parse(API.getAllCard),
      );

      if(Res.statusCode == 200)
      {
        var responseBody = jsonDecode(Res.body);
        if (responseBody["success"] == true)
        {
          (responseBody['CardData'] as List).forEach((eachRecord)
          {
            allCardList.add(Cards.fromJson(eachRecord));

          });
        }
      }
      else
      {
        Fluttertoast.showToast(msg: ("200"));
      }

    }
    catch(e)
    {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }

    return allCardList;
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 16,),

          showSearchBarWidget(),

          const SizedBox(height: 26,),

          //Trending
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Trending",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          PopularWidget(context),

          const SizedBox(height: 24,),

          //New
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "New",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),

          allCardWidget(context),

        ],
      ),
    );



  }


  showSearchBarWidget()
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: searchController,
        onTap: (){
          Get.to(SearchCard());
        },
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: (){
              Get.to(SearchCard());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
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

  Widget PopularWidget(context)
  {
    return FutureBuilder(
      future: getTrending(),
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
        if(dataSnapShot.data!.length > 0)
        {
            return Container(
              height: 400,
              child: ListView.builder(
                itemCount: dataSnapShot.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index)
                {
                  Cards eachCardData = dataSnapShot.data![index];
                  return GestureDetector(
                  onTap: (){
                    Get.to(CardDetailsScreen(cardInfo: eachCardData));
                  },
                  child: Container(
                  width: 200,
                  margin: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  10,
                  index == dataSnapShot.data!.length-1 ? 16 : 8,
                  10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow:
                    const [
                      BoxShadow(
                        offset: Offset(0,3),
                        blurRadius: 6,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                    child: Column(
                      children: [


                        //Trending Card Image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                          child: FadeInImage(
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                            placeholder: const AssetImage("images/ImageError.png"),
                            image: NetworkImage(
                              eachCardData.Card_ImageURL!,
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

                        //Card Info
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      eachCardData.Card_Name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    eachCardData.Card_Languages!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8,),


                              //=================================================================================ADD Price OR Somethink
                              Row(
                                children: [

                                ],
                              )

                            ],
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
        else
        {
           return const Center(
             child: Text("Empty, No Data."),
           );
        }
      },

    );
  }

  Widget allCardWidget(context)
  {
    return FutureBuilder(
      future: getAll(),
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
                  Get.to(CardDetailsScreen(cardInfo: eachCardRecord));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == dataSnapShot.data!.length -1 ? 16 : 8
                  ),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(20),
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
                              ),

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
            child: Text("Empty, No Data."),
          );
        }
      },
    );
  }


}
