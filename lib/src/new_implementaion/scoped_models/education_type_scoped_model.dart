import 'package:chw/src/new_implementaion/models/specific_message_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/connected.dart';

mixin EducationTypeScopedModel on ConnectedModel {

  List<SpecificMessage> getSpecificMessageByType(String id) {
    return specificMessages.where((message) => message.educationType == id);
  }
}