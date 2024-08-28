class AppRoutesApi {
  static const String baseUrl = "http://192.168.5.178:8080";
  static const String authLogin = "$baseUrl/auth/login";
  static const String authRegister = "$baseUrl/auth/register";
  static const String refreshToken = "$baseUrl/auth/refreshToken";

  //travel
  static const String getTravelByUser = "$baseUrl/travel/getTravelsByUser";
  static const String createTravel = "$baseUrl/travel";

  //activity
  static const String getActivitiesByTravel =
      "$baseUrl/activity/getActivitiesByTravelId";
  static const String createActivity = "$baseUrl/activity/create";
}
