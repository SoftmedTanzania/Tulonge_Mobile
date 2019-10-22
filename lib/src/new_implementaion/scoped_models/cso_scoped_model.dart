import 'package:chw/src/new_implementaion/scoped_models/connected.dart';
import 'package:chw/src/new_implementaion/models/cso_model.dart';

mixin ScoScopedModel on ConnectedModel {
  String selectedCsoId;

  Cso get getSelectedCso {
    try {
      return csos.firstWhere((Cso cso) => selectedCsoId == cso.id);
    } catch(e) {
      return null;
    }
  }

  setSelectedCso(String id) {
    this.selectedCsoId = id;
    notifyListeners();
  }

  Cso getCsoById(String id) {
    try {
      return csos.firstWhere((Cso cso) => id == cso.id);
    } catch(e) {
      return null;
    }
  }

}