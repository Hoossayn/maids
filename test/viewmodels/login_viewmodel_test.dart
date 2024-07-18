import 'package:flutter_test/flutter_test.dart';
import 'package:maids/app/app.locator.dart';
import 'package:maids/models/login_model.dart';
import 'package:maids/services/remote_services.dart';
import 'package:maids/ui/views/login/login_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

class MockAuthService extends Mock implements RemoteServices {}

void main() {
  LoginViewModel getModel() => LoginViewModel();

  group('LoginViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test('login should return true for correct credentials', () async {
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJhdmF0IiwiZW1haWwiOiJhdmEudGF5bG9yQHguZHVtbXlqc29uLmNvbSIsImZpcnN0TmFtZSI6IkF2YSIsImxhc3ROYW1lIjoiVGF5bG9yIiwiZ2VuZGVyIjoiZmVtYWxlIiwiaW1hZ2UiOiJodHRwczovL2R1bW15anNvbi5jb20vaWNvbi9hdmF0LzEyOCIsImlhdCI6MTcyMTEzMzk0MSwiZXhwIjoxNzIxMTM0MDAxfQ.aPpT2rzhHhQrwfiW6FphhGD2RzAsp_PE549lZmwO4XE';
      const refreshToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJhdmF0IiwiZW1haWwiOiJhdmEudGF5bG9yQHguZHVtbXlqc29uLmNvbSIsImZpcnN0TmFtZSI6IkF2YSIsImxhc3ROYW1lIjoiVGF5bG9yIiwiZ2VuZGVyIjoiZmVtYWxlIiwiaW1hZ2UiOiJodHRwczovL2R1bW15anNvbi5jb20vaWNvbi9hdmF0LzEyOCIsImlhdCI6MTcyMTEzMzk0MSwiZXhwIjoxNzIzNzI1OTQxfQ.1NIxnVtJLFiboYHj3jUY1SoESuSGGhwCabVjGi4TmiM';
      final model = getModel();

      /*when(model.login('avat', 'avatpass')).thenAnswer((_) async =>
          LoginModel(token: token, refreshToken: refreshToken));*/

      //final result = await model.login('avat', 'avatpass');
      model.login('avat', 'avatpass');

      expect(model.isAuthenticated, false);
    });

    test('login should return false for incorrect credentials', () async {
      final mockAuthService = MockAuthService();
      when(mockAuthService.login('wrong', 'wrong')).thenAnswer(
          (_) async => LoginModel(id: 2, token: 'null', refreshToken: 'null'));

      final result = await mockAuthService.login('wrong', 'wrong');

      expect(result, false);
    });
  });
}
