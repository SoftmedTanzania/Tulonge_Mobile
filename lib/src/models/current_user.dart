class CurrentUser {
  String fullname;
  String email;

  CurrentUser.fromJson(Map<String, dynamic> parseJson)
      : fullname = parseJson['name'],
        email = 'leoa.august27@gmail.com';
}
