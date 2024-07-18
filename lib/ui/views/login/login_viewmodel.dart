import 'package:flutter/cupertino.dart';
import 'package:maids/app/app.router.dart';
import 'package:maids/utilities/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../main.dart';
import '../../../models/login_model.dart';
import '../../../services/remote_services.dart';

class LoginViewModel extends BaseViewModel {
  final _remoteService = locator<RemoteServices>();
  final _navigationService = locator<NavigationService>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late LoginModel loginModel;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<LoginModel> login(String username, String password) async {
    loginModel = await _remoteService.login(username, password);
    if (loginModel.token.isNotEmpty) {
      _isAuthenticated = true;
      prefs.setInt(userId, loginModel.id);
      _navigationService.replaceWithHomeView();
    }
    notifyListeners();
    return loginModel;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
