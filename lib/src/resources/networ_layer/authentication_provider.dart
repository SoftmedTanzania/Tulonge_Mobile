import 'package:chw/src/resources/networ_layer/api_provider.dart';

class AuthenticationProvider {
  ApiProvider app = new ApiProvider();

  login(username, password) async {
    try {
      var user = await app.userLogin(username, password);
      var structure = await getStructure();
      return user;
    } catch (e) {
      throw new Exception(e.message);
    }
  }

  getStructure() async {
    try {
      var user = await app.getStructure();
      return user;
    } catch (e) {
      throw new Exception(e.message);
    }
  }

  currentLoggedIn() async {
    return await app.retrieveLoginUser();
  }
}
