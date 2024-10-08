import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  if (kDebugMode) {
    print(args);
  }
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await WindowManager.ensureInitialized(args.isEmpty ? 0 : int.parse(args[0]));
  await WindowManager.current.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(640, 480),
      title: 'window_manager_test',
    ),
    () async {
      await WindowManager.current.show();
      await WindowManager.current.focus();
    },
  );

  testWidgets('getBounds', (tester) async {
    expect(
      await WindowManager.current.getBounds(),
      isA<Rect>().having((r) => r.size, 'size', const Size(640, 480)),
    );
  });

  testWidgets(
    'isAlwaysOnBottom',
    (tester) async {
      expect(await WindowManager.current.isAlwaysOnBottom(), isFalse);
    },
    skip: Platform.isMacOS || Platform.isWindows,
  );

  testWidgets('isAlwaysOnTop', (tester) async {
    expect(await WindowManager.current.isAlwaysOnTop(), isFalse);
  });

  testWidgets('isClosable', (tester) async {
    expect(await WindowManager.current.isClosable(), isTrue);
  });

  testWidgets('isFocused', (tester) async {
    expect(await WindowManager.current.isFocused(), isTrue);
  });

  testWidgets('isFullScreen', (tester) async {
    expect(await WindowManager.current.isFullScreen(), isFalse);
  });

  testWidgets(
    'hasShadow',
    (tester) async {
      expect(await WindowManager.current.hasShadow(), isTrue);
    },
    skip: Platform.isLinux,
  );

  testWidgets('isMaximizable', (tester) async {
    expect(await WindowManager.current.isMaximizable(), isTrue);
  });

  testWidgets('isMaximized', (tester) async {
    expect(await WindowManager.current.isMaximized(), isFalse);
  });

  testWidgets(
    'isMinimizable',
    (tester) async {
      expect(await WindowManager.current.isMinimizable(), isTrue);
    },
    skip: Platform.isMacOS,
  );

  testWidgets('isMinimized', (tester) async {
    expect(await WindowManager.current.isMinimized(), isFalse);
  });

  testWidgets(
    'isMovable',
    (tester) async {
      expect(await WindowManager.current.isMovable(), isTrue);
    },
    skip: Platform.isLinux || Platform.isWindows,
  );

  testWidgets('getOpacity', (tester) async {
    expect(await WindowManager.current.getOpacity(), 1.0);
  });

  testWidgets('getPosition', (tester) async {
    expect(await WindowManager.current.getPosition(), isA<Offset>());
  });

  testWidgets('isPreventClose', (tester) async {
    expect(await WindowManager.current.isPreventClose(), isFalse);
  });

  testWidgets('isResizable', (tester) async {
    expect(await WindowManager.current.isResizable(), isTrue);
  });

  testWidgets('getSize', (tester) async {
    expect(await WindowManager.current.getSize(), const Size(640, 480));
  });

  testWidgets(
    'isSkipTaskbar',
    (tester) async {
      expect(await WindowManager.current.isSkipTaskbar(), isFalse);
    },
    skip: Platform.isWindows,
  );

  testWidgets('getTitle', (tester) async {
    expect(await WindowManager.current.getTitle(), 'window_manager_test');
  });

  testWidgets('getTitleBarHeight', (tester) async {
    expect(await WindowManager.current.getTitleBarHeight(), isNonNegative);
  });

  testWidgets('isVisible', (tester) async {
    expect(await WindowManager.current.isVisible(), isTrue);
  });
}
