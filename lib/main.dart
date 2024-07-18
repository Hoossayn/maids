import 'package:flutter/material.dart';
import 'package:maids/app/app.bottomsheets.dart';
import 'package:maids/app/app.dialogs.dart';
import 'package:maids/app/app.locator.dart';
import 'package:maids/app/app.router.dart';
import 'package:maids/providers/task_provider.dart';
import 'package:maids/utilities/context_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  prefs = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: GestureDetector(
        onTap: () => ContextUtil.hideKeyboard(context),
        child: MaterialApp(
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
        ),
      ),
    );
  }
}
