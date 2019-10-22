import 'package:chw/src/new_implementaion/scoped_models/connected.dart';
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/new_implementaion/database/database_providers/village_database_provider.dart';

mixin VillageScopedModel on ConnectedModel {
  Village newVillage;

  setNewVillage({Village village}) {
    if (village == null) {
      this.newVillage = new Village(id: makeid(), name: '', leaderName: '', leaderPhone: '');
    } else {
      this.newVillage = village;
    }
    this.notifyListeners();
  }

  saveVillage(Map<String, dynamic> map) async {
    this.newVillage = Village.fromServer(map);
    VillageDataProvider villageDataProvider = VillageDataProvider();
    await villageDataProvider.addOrUpdateVillage(this.newVillage);
    this.initializeVillage();
  }

  deleteVillage(String villageId) async {
    VillageDataProvider villageDataProvider = VillageDataProvider();
    await villageDataProvider.deleteVillage(villageId);
    this.initializeVillage();
  }

  Village getVillage(String villageId) {
    Village selectedVillage = villages.firstWhere((v) => v.id == villageId);
    if (selectedVillage != null) {
      return selectedVillage;
    }
    return null;
  }
}