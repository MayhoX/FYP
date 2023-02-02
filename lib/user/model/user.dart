class User
{
  int User_ID;
  String User_Name;
  String User_Email;
  String User_Password;
  String User_States;

    User(
        this.User_ID,
        this.User_Name,
        this.User_Email,
        this.User_Password,
        this.User_States,
    );

    factory User.fromJson(Map<String, dynamic> json) => User(
      int.parse(json['User_ID']),
      json['User_Name'],
      json['User_Email'],
      json['User_Password'],
      json['User_States'],
    );

    Map<String, dynamic> toJson() =>
        {
          'User_ID': User_ID.toString(),
          'User_Name': User_Name.toString(),
          'User_Email': User_Email.toString(),
          'User_Password': User_Password.toString(),
          'User_States': User_States.toString(),
        };

}