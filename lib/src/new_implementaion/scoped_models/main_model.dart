import 'package:chw/src/new_implementaion/scoped_models/material_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/village_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/connected.dart';
import 'package:chw/src/new_implementaion/scoped_models/cso_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/educated_group_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/education_type_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/ipc_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/participant_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/referral_type_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/specific_message_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/target_audience_scoped_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/user_scoped_model.dart';

import 'package:chw/src/new_implementaion/scoped_models/newIpc.dart';

class MainModel extends Model
    with
    ConnectedModel,
    ScoScopedModel,
    EducatedGroupScopedModel,
    EducationTypeScopedModel,
    IpcScopedModel,
    ParticipantScopedModel,
    ReferralTypeScopedModel,
    SpecificMessageScopedModel,
    TargetAudienceScopedModel,
    newIpcScopedModel,
    VillageScopedModel,
    MaterialScopedModel,
    UserScopedModel {}