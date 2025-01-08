import 'package:echidna_webui/modules/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;

  setUp(() {
    Modular.init(AuthModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  // Your unit tests here.
}
