class AppConstants {
  static const String BASE_URL = 'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';
  static const String User_URL = 'user';


  static const String Login_URL = 'https://auth.exampur.xyz/auth/login';
  static const String homeBanner_URL = 'banners';
  // sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';

  static bool isPrint = true;

  static void printLog(message) {
    if(isPrint)
      print(message);
    else
      print('Exampur');
  }
}