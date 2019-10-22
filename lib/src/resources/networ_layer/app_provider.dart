//import 'package:contact_archive/models/contact.dart';
import 'api_provider.dart';

class AppProvider {
  ApiProvider api = new ApiProvider();
  login(username, password) async {
    try {
      var user = await api.userLogin(username, password);
      return user;
    } catch(e){
      throw Exception(e.message);
    }
  }

  currentLoggedIn() async{
    return await api.retrieveLoginUser();
  }


}
