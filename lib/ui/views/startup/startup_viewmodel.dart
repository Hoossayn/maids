import 'package:maids/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:maids/app/app.locator.dart';
import 'package:maids/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  Future runStartupLogic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 3));

    if(prefs.getInt(userId) == null ) {
      _navigationService.replaceWithLoginView();
    } else {
      _navigationService.replaceWithLoginView();
    }



  }
}
