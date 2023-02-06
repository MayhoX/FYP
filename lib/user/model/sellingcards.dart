class SellingCards
{
  int? SellCard_ID ;
  int? Card_ID ;
  int? SellCard_Seller ;
  double? SellCard_Price;
  int? SellCard_Qty;
  String? SellCard_Description;
  String? SellCard_ImageURL;
  String? SellCard_Date;
  String? SellCard_state;

  int? User_ID;
  String? User_Name;


  SellingCards({
    this.SellCard_ID,
    this.Card_ID,
    this.SellCard_Seller,
    this.SellCard_Price,
    this.SellCard_Qty,
    this.SellCard_Description,
    this.SellCard_ImageURL,
    this.SellCard_Date,
    this.SellCard_state,

    this.User_ID,
    this.User_Name,
  });

  factory SellingCards.fromJson(Map<String, dynamic> json) => SellingCards(
    SellCard_ID: int.parse(json["SellCard_ID"]),
    Card_ID: int.parse(json["Card_ID"]),
    SellCard_Seller: int.parse(json["SellCard_Seller"]),
    SellCard_Price: double.parse(json["SellCard_Price"]),
    SellCard_Qty: int.parse(json["SellCard_Qty"]),
    SellCard_Description: json["SellCard_Description"],
    SellCard_ImageURL: json["SellCard_ImageURL"],
    SellCard_Date: json["SellCard_Date"],
    SellCard_state: json["SellCard_state"],

    User_ID: int.parse(json["User_ID"]),
    User_Name: json["User_Name"],
  );



}