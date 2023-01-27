class User
{
  int User_ID;
  String User_Name;
  String User_Email;
  String User_Password;

    User(
        this.User_ID,
        this.User_Name,
        this.User_Email,
        this.User_Password,
  );

    Map<String, dynamic> toJson() =>
        {
          'User_ID': User_ID.toString(),
          'User_Name': User_Name.toString(),
          'User_Email': User_Email.toString(),
          'User_Password': User_Password.toString(),
        };

}