import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/admin/Admin_Main_screen.dart';
import 'package:fyp/api_connection/api_connection.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class AdminUploadCardScreen extends StatefulWidget {


  @override
  State<AdminUploadCardScreen> createState() => _AdminUploadCardScreenState();
}



class _AdminUploadCardScreenState extends State<AdminUploadCardScreen> {

  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var packController = TextEditingController();
  var descriptionController = TextEditingController();
  var languagesController = TextEditingController();
  var gameController = TextEditingController();
  var rareController = TextEditingController();
  var imageLink = "";
  var levelController = TextEditingController();
  var specialController = TextEditingController();
  var effectController = TextEditingController();
  var attributeController = TextEditingController();
  var attackController = TextEditingController();
  var defenceController = TextEditingController();
  var passwordController = TextEditingController();







  CaptureImageWithCamera() async
  {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);

    Get.back();

    setState(()=> pickedImageXFile);
  }

  PickImageWithGallery() async
  {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);

    Get.back();

    setState(()=> pickedImageXFile);

  }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (context)
      {
        return SimpleDialog(
          title: const Text(
            "Card Image",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: ()
              {
                CaptureImageWithCamera();
              },
              child: const Text(
                "Capture with Phone Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            SimpleDialogOption(
              onPressed: ()
              {
                PickImageWithGallery();
              },
              child: const Text(
                "Select with Phone Gallery",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            SimpleDialogOption(
              onPressed: ()
              {
                Get.back();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),

          ],
        );
      }
    );
  }

  Widget defaultScreen(){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Card",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.black54,
                size: 200,
              ),

              Material(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: ()
                  {
                    showDialogBox();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 28,
                    ),
                    child: Text(
                      "Add New Card",
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
      ),
    );
  }

  Widget uploadItemFormScrren(){
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
          "Upload Card Form",
          ),

          centerTitle: true,
          leading: IconButton(
            onPressed: ()
            {
              setState(()
              {
                pickedImageXFile = null;
                nameController.clear();
                packController.clear();
                descriptionController.clear();
                languagesController.clear();
                gameController.clear();
                rareController.clear();
                levelController.clear();
                specialController.clear();
                effectController.clear();
                attributeController.clear();
                attackController.clear();
                defenceController.clear();
                passwordController.clear();
              });
              Get.to(AdminMainScreen());
            },
            icon: const Icon(
              Icons.clear,
            ),
          ),
          actions: [

          ],

        ),
      body: ListView(
        children: [

          Container(
            height: 600,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  File(pickedImageXFile!.path),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
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
              child: Padding (
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [

                          //name
                          TextFormField(
                            controller: nameController,
                            validator: (val) =>
                            val == "" ? "Please input card name" : null,
                            decoration: InputDecoration(

                              hintText: "Card Name",
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

                          const SizedBox(height: 18,),

                          //Pack
                          TextFormField(
                            controller: packController,
                            validator: (val) =>
                            val == "" ? "Please input card pack" : null,
                            decoration: InputDecoration(

                              hintText: "Card Pack",
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

                          const SizedBox(height: 18,),

                          //description
                          TextFormField(
                            controller: descriptionController,
                            validator: (val) =>
                            val == "" ? "Please input card description" : null,
                            decoration: InputDecoration(
                              hintText: "Description",
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

                          const SizedBox(height: 18,),

                          //languages
                          TextFormField(
                            controller: languagesController,
                            validator: (val) =>
                            val == "" ? "Please input card languages" : null,
                            decoration: InputDecoration(

                              hintText: "Card Languages",
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

                          const SizedBox(height: 18,),

                          //game
                          TextFormField(
                            controller: gameController,
                            validator: (val) =>
                            val == "" ? "Please input card game" : null,
                            decoration: InputDecoration(

                              hintText: "Card Game",
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

                          const SizedBox(height: 18,),

                          //rare
                          TextFormField(
                            controller: rareController,
                            validator: (val) =>
                            val == "" ? "Please input card rare" : null,
                            decoration: InputDecoration(

                              hintText: "Card Rare",
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

                          const SizedBox(height: 18,),

                          //Level
                          TextFormField(
                            controller: levelController,
                            validator: (val) =>
                            val == "" ? "Please input card level" : null,
                            decoration: InputDecoration(

                              hintText: "Card Level",
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

                          const SizedBox(height: 18,),

                          //Special
                          TextFormField(
                            controller: specialController,
                            validator: (val) =>
                            val == "" ? "Please input card special" : null,
                            decoration: InputDecoration(

                              hintText: "Card Special",
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

                          const SizedBox(height: 18,),

                          //Effect
                          TextFormField(
                            controller: effectController,
                            validator: (val) =>
                            val == "" ? "Please input card Effect" : null,
                            decoration: InputDecoration(

                              hintText: "Card Effect",
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

                          const SizedBox(height: 18,),

                          //Attribute
                          TextFormField(
                            controller: attributeController,
                            validator: (val) =>
                            val == "" ? "Please input card Attribute" : null,
                            decoration: InputDecoration(

                              hintText: "Card Attribute",
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

                          const SizedBox(height: 18,),

                          //Attack
                          TextFormField(
                            controller: attackController,
                            validator: (val) =>
                            val == "" ? "Please input card Attack" : null,
                            decoration: InputDecoration(

                              hintText: "Card Attack",
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

                          const SizedBox(height: 18,),

                          //Defence
                          TextFormField(
                            controller: defenceController,
                            validator: (val) =>
                            val == "" ? "Please input card Defence" : null,
                            decoration: InputDecoration(

                              hintText: "Card Defence",
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

                          const SizedBox(height: 18,),

                          //Password
                          TextFormField(
                            controller: passwordController,
                            validator: (val) =>
                            val == "" ? "Please input card Password" : null,
                            decoration: InputDecoration(

                              hintText: "Card Password",
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

                          const SizedBox(height: 18,),

                          //Upload
                          Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: (){
                                if (formKey.currentState!.validate())
                                {
                                  Fluttertoast.showToast(msg: "Uploading...");
                                  uploadItemImage();
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                ),
                                child: Text(
                                  'Upload',
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
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  uploadItemImage() async
  {
    var requestAPI = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.imgur.com/3/image")
    );

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestAPI.fields['title'] = imageName;
    requestAPI.headers['Authorization'] = 'Client-ID ' + 'f1fac75daa8dcce';

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      pickedImageXFile!.path,
      filename: imageName,
    );

    requestAPI.files.add(imageFile);
    var responseAPI = await requestAPI.send();

    var responseDataAPI = await responseAPI.stream.toBytes();

    var resultAPI= String.fromCharCodes(responseDataAPI);

    Map<String, dynamic> jsonRes=  json.decode(resultAPI);
    imageLink = (jsonRes['data']['link']).toString();
    String deleteHash = (jsonRes['data']['deletehash']).toString();

    saveCardInfoToDatabase();


  }

  saveCardInfoToDatabase() async
  {




    try
    {
      var response = await http.post(
        Uri.parse(API.uploadCard),
        body:
          {
            'Card_ID': '1',
            'Card_Name': nameController.text.trim().toString(),
            'Card_Pack': packController.text.trim().toString(),
            'Card_Description': descriptionController.text.trim().toString(),
            'Card_Languages': languagesController.text.trim().toString(),
            'Card_Game': gameController.text.trim().toString(),
            'Card_Rare': rareController.text.trim().toString(),
            'Card_ImageURL': imageLink.trim().toString(),
            'Card_Level': levelController.text.trim().toString(),
            'Card_Special': specialController.text.trim().toString(),
            'Card_Effect': effectController.text.trim().toString(),
            'Card_Attribute': attributeController.text.trim().toString(),
            'Card_Attack': attackController.text.trim().toString(),
            'Card_Defence': defenceController.text.trim().toString(),
            'Card_Password': passwordController.text.trim().toString(),

          },
      );

      if(response.statusCode == 200)
      {
        var resBodyOfUpload = jsonDecode(response.body);

        if(resBodyOfUpload['success'] == true)
        {
          Fluttertoast.showToast(msg: "Upload success");

          setState(()=> pickedImageXFile=null);
          setState(()
          {
            pickedImageXFile = null;
            nameController.clear();
            packController.clear();
            descriptionController.clear();
            languagesController.clear();
            gameController.clear();
            rareController.clear();
            levelController.clear();
            specialController.clear();
            effectController.clear();
            attributeController.clear();
            attackController.clear();
            defenceController.clear();
            passwordController.clear();
          });

          Get.to(AdminMainScreen());
        }
        else
        {
            Fluttertoast.showToast(msg: "200");
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Upload Error");
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
    return pickedImageXFile == null ? defaultScreen() : uploadItemFormScrren();
  }
}
