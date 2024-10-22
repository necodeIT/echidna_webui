import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:license_server_admin_panel/modules/api/api.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(debugLogHandler);

  setUp(() {
    Modular.init(ApiModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group('Api Service', () {
    test('should get licenses', () async {
      final service = Modular.get<ApiService>();

      final response = await service.get('admin/licenses');

      expect(response.body?.isLeft, isTrue);
    });
  });
}
