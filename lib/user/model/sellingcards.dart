class SellingCards
{
  int? SellCard_ID ;
  int? Card_ID ;
  int? SellCard_Seller ;
  double? SellCard_Price;
  int? SellCard_Qty;
  String? SellCard_Description;
  String? SellCard_Date;
  String? SellCard_state;


  SellingCards({
    this.SellCard_ID,
    this.Card_ID,
    this.SellCard_Seller,
    this.SellCard_Price,
    this.SellCard_Qty,
    this.SellCard_Description,
    this.SellCard_Date,
    this.SellCard_state,
  });

  factory SellingCards.fromJson(Map<String, dynamic> json) => SellingCards(
    SellCard_ID: int.parse(json["SellCard_ID"]),
    Card_ID: int.parse(json["Card_ID"]),
    SellCard_Seller: int.parse(json["SellCard_Seller"]),
    SellCard_Price: double.parse(json["SellCard_Price"]),
    SellCard_Qty: int.parse(json["SellCard_Qty"]),
    SellCard_Description: json["SellCard_Description"],
    SellCard_Date: json["SellCard_Date"],
    SellCard_state: json["SellCard_state"],

  );



}