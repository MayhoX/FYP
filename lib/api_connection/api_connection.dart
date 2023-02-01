class API{

  //ipconfig to change ip
  static const hostConnect = 'http://192.168.233.1/api_fyp';

  static const hostConnectUser = '$hostConnect/user';
  static const hostConnectCard = '$hostConnect/card';


  //Register
  static const register = '$hostConnectUser/register.php';
  static const validateEmail = '$hostConnectUser/validate_email.php';

  //Login
  static const login = '$hostConnectUser/login.php';

  //upload card
  static const uploadCard = '$hostConnectCard/upload.php';

  static const getTrendingCard = '$hostConnectCard/trending.php';

  static const getAllCard = '$hostConnectCard/allcard.php';





}