import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di.dart';
import 'core/config/network_config.dart';
import 'app/app_widget.dart';

part 'main_styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NetworkConfig.setup();
  init();
  _Styling.apply();

  runApp(const AppWidget());
}
