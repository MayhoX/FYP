class buyCard
{
  int? BuyCard_ID;
  int? BuyCard_SellCardID;
  int? BuyCard_CardID;
  int? BuyCard_BuyerID;
  int? BuyCard_SellerID;
  int? BuyCard_Qty;
  double? BuyCard_TotalPrice;
  DateTime? BuyCard_Date;
  String? BuyCard_State;



  buyCard({
    this.BuyCard_ID,
    this.BuyCard_SellCardID,
    this.BuyCard_CardID,
    this.BuyCard_BuyerID,
    this.BuyCard_SellerID,
    this.BuyCard_Qty,
    this.BuyCard_TotalPrice,
    this.BuyCard_Date,
    this.BuyCard_State,

  });

  factory buyCard.fromJson(Map<String, dynamic> json) => buyCard(
    BuyCard_ID: int.parse(json["BuyCard_ID"]),
    BuyCard_SellCardID: int.parse(json["BuyCard_SellCardID"]),
    BuyCard_CardID : int.parse(json["BuyCard_CardID "]),
    BuyCard_BuyerID: int.parse(json["BuyCard_BuyerID"]),
    BuyCard_SellerID: int.parse(json["BuyCard_SellerID"]),
    BuyCard_Qty: int.parse(json["BuyCard_Qty"]),
    BuyCard_TotalPrice: double.parse(json["BuyCard_TotalPrice"]),
    BuyCard_Date: json["SellCard_Date"],
    BuyCard_State: json["SellCard_state"],

  );



}