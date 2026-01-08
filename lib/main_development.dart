import 'package:kasi_chat/bootstrap.dart';
import 'package:kasi_chat/features/app/app.dart';

Future<void> main() async {
  await bootstrap(() => const AppView());
}
