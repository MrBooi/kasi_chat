import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterAppBlocRefreshStream extends ChangeNotifier {
  GoRouterAppBlocRefreshStream() {
    // Listen to your Bloc's stream and call notifyListeners() on changes
    // For example:
    // myBloc.stream.listen((state) {
    //   notifyListeners();
    // });
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
