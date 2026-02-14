part of 'main.dart';

class _Styling {
  static void _statusBarTransparency() => SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  static void _allowedOrientations() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  static void apply() {
    _statusBarTransparency();
    _allowedOrientations();
  }
}
