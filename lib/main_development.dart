import 'package:kasi_chat/app/app.dart';
import 'package:kasi_chat/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
