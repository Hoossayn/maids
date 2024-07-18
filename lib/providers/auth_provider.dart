import 'package:flutter/cupertino.dart';
import 'package:maids/models/login_model.dart';

import '../app/app.locator.dart';
import '../services/remote_services.dart';

class AuthProvider with ChangeNotifier {
  final _remoteService = locator<RemoteServices>();

  late LoginModel? loginModel;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    loginModel = await _remoteService.login(username, password);
    if (loginModel!.token.isNotEmpty) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
