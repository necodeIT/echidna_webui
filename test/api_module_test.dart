import 'package:echidna_webui/config/config.dart';
import 'package:echidna_webui/modules/api/api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(debugLogHandler);

  loadEnv();

  setUp(() {
    Modular.init(ApiModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group('Api Service', () {
    test('should get licenses', () async {
      final service = Modular.get<ApiService>();

      final response = await service.get('admin/licenses', token: 'token');

      expect(response.body?.isLeft, isTrue);
    });

    test('Get Customer 1', () async {
      final service = Modular.get<ApiService>();

      final response = await service.get('admin/customers/', pathParameter: 1, token: 'token');

      expect(response.body?.isRight, isTrue);
    });

    test('Update Customer', () async {
      final service = Modular.get<ApiService>();

      final response = await service.patch('admin/customers/', pathParameter: 1, token: 'token', body: {'name': 'Test1'});

      expect(response.body?.isRight, isTrue);
    });
  });
}
