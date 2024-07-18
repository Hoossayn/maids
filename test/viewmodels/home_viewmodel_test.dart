import 'package:flutter_test/flutter_test.dart';
import 'package:maids/app/app.locator.dart';
import 'package:maids/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel(context: null);

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

  });
}
