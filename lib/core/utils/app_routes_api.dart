class AppRoutesApi {
  static const String baseUrl = "http://192.168.5.178:8080";
  static const String authLogin = "$baseUrl/auth/login";
  static const String authRegister = "$baseUrl/auth/register";
  static const String refreshToken = "$baseUrl/auth/refreshToken";

  //travel
  static const String getTravelByUser = "$baseUrl/travel/getTravelsByUser";
  static const String createTravel = "$baseUrl/travel";
  static const String deleteTravel = "$baseUrl/travel/delete";

  //activity
  static const String getActivitiesByTravel =
      "$baseUrl/activity/getActivitiesByTravelId";
  static const String createActivity = "$baseUrl/activity/create";
  static const String deleteActivity = "$baseUrl/activity/delete";

  //link
  static const String createLink = "$baseUrl/link/create";
  static const String deleteLink = "$baseUrl/link/delete";

  //guest
  static const String createGuest = "$baseUrl/guest/create";
  static const String deleteGuest = "$baseUrl/guest/delete";
  static const String actionInviteGuest = "$baseUrl/guest/actionInviteToTravel";
}
