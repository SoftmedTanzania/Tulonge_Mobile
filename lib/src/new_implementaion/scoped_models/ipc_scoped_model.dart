import 'package:chw/src/new_implementaion/scoped_models/connected.dart';

mixin IpcScopedModel on ConnectedModel {
  bool _completing = false;

  bool get completing => this._completing;

  setCompleting(bool val) {
    this._completing = val;
    notifyListeners();
  }

  num get numberOfUnsyncedSessions =>
      this.ipcs.where((ipc) => !ipc.isSynchronized && ipc.isCompleted).length;
}
