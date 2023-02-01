class Cards
{
  int? Card_ID;
  String? Card_Name;
  String? Card_Pack;
  String? Card_Description;
  String? Card_Languages;
  String? Card_Game;
  String? Card_Rare;
  String? Card_ImageURL;
  String? Card_Level;
  String? Card_Special;
  String? Card_Effect;
  String? Card_Attribute;
  int? Card_Attack;
  int? Card_Defence;
  int? Card_Password;

  Cards({
    this.Card_ID,
    this.Card_Name,
    this.Card_Pack,
    this.Card_Description,
    this.Card_Languages,
    this.Card_Game,
    this.Card_Rare,
    this.Card_ImageURL,
    this.Card_Level,
    this.Card_Special,
    this.Card_Effect,
    this.Card_Attribute ,
    this.Card_Attack,
    this.Card_Defence,
    this.Card_Password,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    Card_ID: int.parse(json["Card_ID"]),
    Card_Name: json["Card_Name"],
    Card_Pack: json["Card_Pack"],
    Card_Description: json["Card_Description"],
    Card_Languages: json["Card_Languages"],
    Card_ImageURL: json["Card_ImageURL"],
    Card_Level: json["Card_Level"],
    Card_Special: json["Card_Special"],
    Card_Effect: json["Card_Effect"],
    Card_Attribute: json["Card_Attribute"],
    Card_Attack: int.parse(json["Card_Attack"]),
    Card_Defence: int.parse(json["Card_Defence"]),
    Card_Password: int.parse(json["Card_Password"]),
  );



}