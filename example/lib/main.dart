import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_manager_example/pages/home.dart';
import 'package:window_manager_example/utils/config.dart';

void main(List<String> args) async {
  print(args);

  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.ensureInitialized(args.isEmpty ? 0 : int.parse(args[0]));

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  WindowManager.current.waitUntilReadyToShow(windowOptions, () async {
    await WindowManager.current.show();
    await WindowManager.current.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    sharedConfigManager.addListener(_configListen);
    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _themeMode = sharedConfig.themeMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final botToastBuilder = BotToastInit();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      builder: (context, child) {
        child = virtualWindowFrameBuilder(context, child);
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
    );
  }
}
