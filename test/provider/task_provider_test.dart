// Generate the mocks
@GenerateMocks([RemoteServices, LocalStorage])
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:maids/models/task_model.dart';
import 'package:maids/providers/task_provider.dart';
import 'package:maids/services/local_storage.dart';
import 'package:maids/services/remote_services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockRemoteServices mockRemoteServices;
  late TaskProvider taskProvider;

  setUp(() {
    registerServices();
    mockRemoteServices = MockRemoteServices();
    taskProvider = TaskProvider();
  });

  group('TaskProvider Tests', () {
    test('fetchTasks adds tasks to the list and saves them locally', () async {
      final taskList = [
        TaskModel(userId: 1, todo: 'Task 1', completed: false, id: 223),
        TaskModel(userId: 2, todo: 'Task 2', completed: false, id: 212),
      ];

      when(mockRemoteServices.fetchTasks(limit: anyNamed('limit'), skip: anyNamed('skip')))
          .thenAnswer((_) async => taskList);

      await taskProvider.fetchTasks();

      expect(taskProvider.tasks.length, 0);
      verify(mockRemoteServices.fetchTasks(limit: 10, skip: 0)).called(1);
      verify(LocalStorage.saveTasks(taskList)).called(1);
    });

    test('addTask adds a task and saves them locally', () async {
      final task = TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 342);

      when(mockRemoteServices.addTask(task)).thenAnswer((_) async => task);

      await taskProvider.addTask(task);

      expect(taskProvider.tasks.contains(task), true);
      verify(mockRemoteServices.addTask(task)).called(1);
      verify(LocalStorage.saveTasks(taskProvider.tasks)).called(1);
    });

    test('updateTask updates a task and saves them locally', () async {
      final task = TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 234);
      taskProvider.tasks = [task];

      when(mockRemoteServices.updateTask(task.id, task.completed)).thenAnswer((_) async => task);

      final updatedTask = TaskModel(id: 1, todo: 'Task 1', completed: true, userId: 623);

      await taskProvider.updateTask(updatedTask);

      expect(taskProvider.tasks.first.completed, true);
      verify(mockRemoteServices.updateTask(task.id, updatedTask.completed)).called(1);
      verify(LocalStorage.saveTasks(taskProvider.tasks)).called(1);
    });

    test('deleteTask deletes a task and saves them locally', () async {
      final task = TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 432);
      taskProvider.tasks = [task];

      when(mockRemoteServices.deleteTask(task.id)).thenAnswer((_) async => true );

      await taskProvider.deleteTask(task.id);

      expect(taskProvider.tasks.contains(task), false);
      verify(mockRemoteServices.deleteTask(task.id)).called(1);
      verify(LocalStorage.saveTasks(taskProvider.tasks)).called(1);
    });

    test('fetchTasks handles timeout exception', () async {
      when(mockRemoteServices.fetchTasks(limit: anyNamed('limit'), skip: anyNamed('skip')))
          .thenThrow(TimeoutException('Timeout'));

      await taskProvider.fetchTasks();

      expect(taskProvider.isLoading, false);
      verify(mockRemoteServices.fetchTasks(limit: 10, skip: 0)).called(1);
    });

    test('toggleLoading sets isLoading and notifies listeners', () {
      bool listenerCalled = false;
      taskProvider.addListener(() {
        listenerCalled = true;
      });

      taskProvider.toggleLoading(true);

      expect(taskProvider.isLoading, true);
      expect(listenerCalled, true);
    });
  });
}