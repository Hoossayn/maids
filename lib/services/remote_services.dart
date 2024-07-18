import '../app/app.locator.dart';
import '../enums/http_verbs.dart';
import '../main.dart';
import '../models/login_model.dart';
import '../models/task_model.dart';
import 'dio_service.dart';

class RemoteServices {
  final _dioService = locator<DioService>();

  static Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json",
  };
  static String get token => prefs.getString("token") ?? "";
  static String get refreshToken => prefs.getString("refresh_token") ?? "";

  Future<LoginModel> login(String name, String password) async {
    final response = await _dioService.makeHttpRequest(
      verb: HttpVerbs.post,
      path: 'https://dummyjson.com/auth/login',
      body: {
        "username": name,
        "password": password,
        "expiresInMins": 15,
      },
    );
    if(response['message'] != null ){
      print('asfsdfsd');
      print(response['message']);
    } else {

    }
    return LoginModel.fromJson(response);
  }

  Future<List<TaskModel>> fetchTasks({int limit = 10, int skip = 10}) async {
    final response = await _dioService.makeHttpRequest(
        verb: HttpVerbs.get,
        path: 'https://dummyjson.com/todos',
        queryParameters: {'limit': limit, 'skip': skip});
    return TaskModels.fromJson(response).todos.map((e) => TaskModel(
            id: e.id, todo: e.todo, completed: e.completed, userId: e.userId))
        .toList();
  }

  Future<TaskModel> addTask(TaskModel model) async {
    final response = await _dioService.makeHttpRequest(
        verb: HttpVerbs.post,
        path: 'https://dummyjson.com/todo/add',
        body: {
          "todo": model.todo,
          "completed": model.completed,
          "userId": model.userId
        });
    return TaskModel.fromJson(response);
  }

  Future<bool> deleteTask(int id) async {
    final response = await _dioService.makeHttpRequest(
        verb: HttpVerbs.delete, path: 'https://dummyjson.com/todo/$id');
    if (response != null) {
      return true;
    }
    return false;
  }

  Future<TaskModel> updateTask(int id, bool completed) async {
    final response = await _dioService.makeHttpRequest(
        verb: HttpVerbs.update,
        path: 'https://dummyjson.com/todo/$id',
        body: {"completed": completed});
    return TaskModel.fromJson(response);
  }
}
