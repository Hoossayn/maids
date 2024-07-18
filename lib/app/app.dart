import 'package:maids/services/dio_service.dart';
import 'package:maids/services/local_storage.dart';
import 'package:maids/services/remote_services.dart';
import 'package:maids/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:maids/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:maids/ui/views/home/home_view.dart';
import 'package:maids/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:maids/ui/views/login/login_view.dart';
import 'package:maids/ui/views/task_details/task_details_view.dart';
import 'package:maids/ui/views/add_task/add_task_view.dart';
import 'package:maids/ui/views/update_task/update_task_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: TaskDetailsView),
    MaterialRoute(page: AddTaskView),
    MaterialRoute(page: UpdateTaskView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DioService),
    LazySingleton(classType: RemoteServices),
    LazySingleton(classType: LocalStorage)
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
