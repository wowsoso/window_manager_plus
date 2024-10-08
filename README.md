# window_manager_plus

[![pub version][pub-image]][pub-url] [![All Contributors][all-contributors-image]](#contributors)

[pub-image]: https://img.shields.io/pub/v/window_manager_plus.svg
[pub-url]: https://pub.dev/packages/window_manager_plus
[all-contributors-image]: https://img.shields.io/github/all-contributors/pichillilorenzo/window_manager_plus?color=ee8449&style=flat-square

This plugin allows Flutter desktop apps to create and manage multiple windows, such as resizing and repositioning, and communicate between them.

This is a fork and a re-work of the original [window_manager](https://pub.dev/packages/window_manager) plugin.
With inspiration from the [desktop_multi_window](https://pub.dev/packages/desktop_multi_window) plugin,
this new implementation allows the creation and management of multiple windows.

**Linux is not currently supported.**

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Platform Support](#platform-support)
- [Quick Start](#quick-start)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Listening events](#listening-events)
    - [Quit on close](#quit-on-close)
      - [macOS](#macos)
    - [Confirm before closing](#confirm-before-closing)
    - [Hidden at launch](#hidden-at-launch)
      - [Linux](#linux)
      - [macOS](#macos-1)
      - [Windows](#windows)
- [Articles](#articles)
- [Who's using it?](#whos-using-it)
- [API](#api)
  - [WindowManager](#windowmanager)
    - [Methods](#methods)
      - [waitUntilReadyToShow](#waituntilreadytoshow)
      - [destroy](#destroy)
      - [close](#close)
      - [isPreventClose](#ispreventclose)
      - [setPreventClose](#setpreventclose)
      - [focus](#focus)
      - [blur  `macos`  `windows`](#blur--macos--windows)
      - [isFocused  `macos`  `windows`](#isfocused--macos--windows)
      - [show](#show)
      - [hide](#hide)
      - [isVisible](#isvisible)
      - [isMaximized](#ismaximized)
      - [maximize](#maximize)
      - [unmaximize](#unmaximize)
      - [isMinimized](#isminimized)
      - [minimize](#minimize)
      - [restore](#restore)
      - [isFullScreen](#isfullscreen)
      - [setFullScreen](#setfullscreen)
      - [isDockable  `windows`](#isdockable--windows)
      - [isDocked  `windows`](#isdocked--windows)
      - [dock  `windows`](#dock--windows)
      - [undock  `windows`](#undock--windows)
      - [setAspectRatio](#setaspectratio)
      - [setBackgroundColor](#setbackgroundcolor)
      - [setAlignment](#setalignment)
      - [center](#center)
      - [getBounds](#getbounds)
      - [setBounds](#setbounds)
      - [getSize](#getsize)
      - [setSize](#setsize)
      - [getPosition](#getposition)
      - [setPosition](#setposition)
      - [setMinimumSize](#setminimumsize)
      - [setMaximumSize](#setmaximumsize)
      - [isResizable](#isresizable)
      - [setResizable](#setresizable)
      - [isMovable  `macos`](#ismovable--macos)
      - [setMovable  `macos`](#setmovable--macos)
      - [isMinimizable  `macos`  `windows`](#isminimizable--macos--windows)
      - [setMinimizable  `macos`  `windows`](#setminimizable--macos--windows)
      - [isClosable  `windows`](#isclosable--windows)
      - [isMaximizable  `macos`  `windows`](#ismaximizable--macos--windows)
      - [setMaximizable](#setmaximizable)
      - [setClosable  `macos`  `windows`](#setclosable--macos--windows)
      - [isAlwaysOnTop](#isalwaysontop)
      - [setAlwaysOnTop](#setalwaysontop)
      - [isAlwaysOnBottom](#isalwaysonbottom)
      - [setAlwaysOnBottom  `linux`  `windows`](#setalwaysonbottom--linux--windows)
      - [getTitle](#gettitle)
      - [setTitle](#settitle)
      - [setTitleBarStyle](#settitlebarstyle)
      - [getTitleBarHeight](#gettitlebarheight)
      - [isSkipTaskbar](#isskiptaskbar)
      - [setSkipTaskbar](#setskiptaskbar)
      - [setProgressBar  `macos`  `windows`](#setprogressbar--macos--windows)
      - [setIcon  `windows`](#seticon--windows)
      - [isVisibleOnAllWorkspaces  `macos`](#isvisibleonallworkspaces--macos)
      - [setVisibleOnAllWorkspaces  `macos`](#setvisibleonallworkspaces--macos)
      - [setBadgeLabel  `macos`](#setbadgelabel--macos)
      - [hasShadow  `macos`  `windows`](#hasshadow--macos--windows)
      - [setHasShadow  `macos`  `windows`](#sethasshadow--macos--windows)
      - [getOpacity](#getopacity)
      - [setOpacity](#setopacity)
      - [setBrightness](#setbrightness)
      - [setIgnoreMouseEvents](#setignoremouseevents)
      - [startDragging](#startdragging)
      - [startResizing  `linux`  `windows`](#startresizing--linux--windows)
      - [grabKeyboard  `linux`](#grabkeyboard--linux)
      - [ungrabKeyboard  `linux`](#ungrabkeyboard--linux)
  - [WindowListener](#windowlistener)
    - [Methods](#methods-1)
      - [onWindowClose](#onwindowclose)
      - [onWindowFocus](#onwindowfocus)
      - [onWindowBlur](#onwindowblur)
      - [onWindowMaximize](#onwindowmaximize)
      - [onWindowUnmaximize](#onwindowunmaximize)
      - [onWindowMinimize](#onwindowminimize)
      - [onWindowRestore](#onwindowrestore)
      - [onWindowResize](#onwindowresize)
      - [onWindowResized  `macos`  `windows`](#onwindowresized--macos--windows)
      - [onWindowMove](#onwindowmove)
      - [onWindowMoved  `macos`  `windows`](#onwindowmoved--macos--windows)
      - [onWindowEnterFullScreen](#onwindowenterfullscreen)
      - [onWindowLeaveFullScreen](#onwindowleavefullscreen)
      - [onWindowDocked  `windows`](#onwindowdocked--windows)
      - [onWindowUndocked  `windows`](#onwindowundocked--windows)
      - [onWindowEvent](#onwindowevent)
- [Contributors](#contributors)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Platform Support

| Linux | macOS | Windows |
|:-----:|:-----:|:-------:|
|   ❌   |   ✅   |   ✅️    |

## Quick Start

### Setup to support multiple windows

#### macOS

Change the file `macos/Runner/MainFlutterWindow.swift` as follows:

```diff
import Cocoa
import FlutterMacOS
+ import window_manager_plus

class MainFlutterWindow: NSPanel {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        RegisterGeneratedPlugins(registry: flutterViewController)
+        
+        WindowManagerPlusPlugin.RegisterGeneratedPlugins = RegisterGeneratedPlugins
        
        super.awakeFromNib()
    }
    
    override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
        super.order(place, relativeTo: otherWin)
        hiddenWindowAtLaunch()
    }
}
```

#### Windows

Change the file `windows/runner/main.cpp` as follows:

```diff
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include <iostream>

#include "flutter_window.h"
#include "utils.h"

+ #include "window_manager/window_manager_plugin.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance,
                      _In_opt_ HINSTANCE prev,
                      _In_ wchar_t* command_line,
                      _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments = GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.CreateAndShow(L"window_manager_example", origin, size)) {
    return EXIT_FAILURE;
  }
-  window.SetQuitOnClose(true);
+  window.SetQuitOnClose(false);
+
+  WindowManagerPluginSetWindowCreatedCallback(
+      [](std::vector<std::string> command_line_arguments) {
+        flutter::DartProject project(L"data");
+
+        project.set_dart_entrypoint_arguments(
+            std::move(command_line_arguments));
+
+        auto window = std::make_shared<FlutterWindow>(project);
+        Win32Window::Point origin(10, 10);
+        Win32Window::Size size(1280, 720);
+        if (!window->CreateAndShow(L"window_manager_example", origin, size)) {
+          std::cerr << "Failed to create a new window" << std::endl;
+        }
+        window->SetQuitOnClose(false);
+        return std::move(window);
+      });

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
```

`window->SetQuitOnClose(false);` is necessary to prevent the application from closing when the window is closed.

If you want to close the App only when the main window is closed, you can set `window->SetQuitOnClose(true);` in the main window.
The others called inside the `WindowManagerPluginSetWindowCreatedCallback` should be set to `false`.

### Usage

```dart
import 'package:flutter/material.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

// Must add args argument.
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await WindowManagerPlus.ensureInitialized(args.isEmpty ? 0 : int.tryParse(args[0]) ?? 0);

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  WindowManagerPlus.current.waitUntilReadyToShow(windowOptions, () async {
    await WindowManagerPlus.current.show();
    await WindowManagerPlus.current.focus();
  });

  runApp(MyApp());
}

```

> Please see the example app of this plugin for a full example.

#### Listening events

The `WindowListener` mixin class is used to listen to window events.
If this is used as a Global Listener using the `WindowManagerPlus.addGlobalListener` static method,
the `windowId` parameter will be the ID of the window that emitted the event,
otherwise, it will be always `null`.

```dart
import 'package:flutter/cupertino.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    super.initState();
    WindowManagerPlus.current.addListener(this);
  }

  @override
  void dispose() {
    WindowManagerPlus.current.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }

  @override
  void onWindowEvent(String eventName, [int? windowId]) {
    print('[WindowManager] onWindowEvent: $eventName');
  }

  @override
  void onWindowClose([int? windowId]) {
    // do something
  }

  @override
  void onWindowFocus([int? windowId]) {
    // do something
  }

  @override
  void onWindowBlur([int? windowId]) {
    // do something
  }

  @override
  void onWindowMaximize([int? windowId]) {
    // do something
  }

  @override
  void onWindowUnmaximize([int? windowId]) {
    // do something
  }

  @override
  void onWindowMinimize([int? windowId]) {
    // do something
  }

  @override
  void onWindowRestore([int? windowId]) {
    // do something
  }

  @override
  void onWindowResize([int? windowId]) {
    // do something
  }

  @override
  void onWindowMove([int? windowId]) {
    // do something
  }

  @override
  void onWindowEnterFullScreen([int? windowId]) {
    // do something
  }

  @override
  void onWindowLeaveFullScreen([int? windowId]) {
    // do something
  }
}
```

#### Quit on close

If you need to use the hide method, you need to disable `QuitOnClose`.

##### macOS

Change the file `macos/Runner/AppDelegate.swift` as follows:

```diff
import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
-    return true
+    return false
  }
}
```

#### Windows

Change the file `windows/runner/main.cpp` as follows:

```diff
#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include <iostream>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance,
                      _In_opt_ HINSTANCE prev,
                      _In_ wchar_t* command_line,
                      _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments = GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);
  Win32Window::Point origin(10, 10);
  Win32Window::Size size(1280, 720);
  if (!window.CreateAndShow(L"window_manager_example", origin, size)) {
    return EXIT_FAILURE;
  }
-  window.SetQuitOnClose(true);
+  window.SetQuitOnClose(false);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
```

#### Confirm before closing

```dart
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    super.initState();
    WindowManagerPlus.current.addListener(this);
    _init();
  }

  @override
  void dispose() {
    WindowManagerPlus.current.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await WindowManagerPlus.current.setPreventClose(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await WindowManagerPlus.current.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  await WindowManagerPlus.current.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
```

#### Hidden at launch

##### Linux

Change the file `linux/my_application.cc` as follows:

```diff

...

// Implements GApplication::activate.
static void my_application_activate(GApplication* application) {
  
  ...

  gtk_window_set_default_size(window, 1280, 720);
-  gtk_widget_show(GTK_WIDGET(window));
+  gtk_widget_realize(GTK_WIDGET(window));

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(project, self->dart_entrypoint_arguments);

  FlView* view = fl_view_new(project);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  gtk_widget_grab_focus(GTK_WIDGET(view));
}

...

```

##### macOS

Change the file `macos/Runner/MainFlutterWindow.swift` as follows:

```diff
import Cocoa
import FlutterMacOS
+import window_manager

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)

        RegisterGeneratedPlugins(registry: flutterViewController)

        super.awakeFromNib()
    }

+    override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
+        super.order(place, relativeTo: otherWin)
+        hiddenWindowAtLaunch()
+    }
}

```

##### Windows

Change the file `windows/runner/win32_window.cpp` as follows:

```diff
bool Win32Window::CreateAndShow(const std::wstring& title,
                                const Point& origin,
                                const Size& size) {
  ...                              
  HWND window = CreateWindow(
-      window_class, title.c_str(), WS_OVERLAPPEDWINDOW | WS_VISIBLE,
+      window_class, title.c_str(),
+      WS_OVERLAPPEDWINDOW, // do not add WS_VISIBLE since the window will be shown later
      Scale(origin.x, scale_factor), Scale(origin.y, scale_factor),
      Scale(size.width, scale_factor), Scale(size.height, scale_factor),
      nullptr, nullptr, GetModuleHandle(nullptr), this);
```

Since flutter 3.7 new windows project
Change the file `windows/runner/flutter_window.cpp` as follows:

```diff
bool FlutterWindow::OnCreate() {
  ...
  flutter_controller_->engine()->SetNextFrameCallback([&]() {
-   this->Show();
+   //delete this->Show()
  });
```

Make sure to call `setState` once on the `onWindowFocus` event.

```dart
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    super.initState();
    WindowManagerPlus.current.addListener(this);
  }

  @override
  void dispose() {
    WindowManagerPlus.current.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
    // do something
  }
}

```

## Articles

- [Click the dock icon to restore after closing the window](https://leanflutter.dev/tips-and-tricks/002-click-dock-icon-to-restore-after-closing-the-window/)
- [Making the app single-instanced](https://leanflutter.dev/tips-and-tricks/001-making-the-app-single-instanced/)

## API

<!-- README_DOC_GEN -->
### WindowManager

#### Methods

##### [addListener](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/addListener.html)([WindowListener](https://pub.dev/documentation/window_manager_plus/latest/WindowListener-class.html) listener) → void

Add a listener to the window.

##### [blur](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/blur.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Removes focus from the window.

##### [center](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/center.html)({[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) animate = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Moves window to the center of the screen.

##### [close](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/close.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Try to close the window.

##### [destroy](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/destroy.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Force closing the window.

##### [dock](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/dock.html)({required [DockSide](https://pub.dev/documentation/window_manager_plus/latest/DockSide.html) side, required [int](https://api.flutter.dev/flutter/dart-core/int-class.html) width}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Docks the window. only works on Windows

##### [focus](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/focus.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Focuses on the window.

##### [getBounds](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getBounds.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[Rect](https://api.flutter.dev/flutter/dart-ui/Rect-class.html)\>

Returns `Rect` - The bounds of the window as Object.

##### [getDevicePixelRatio](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getDevicePixelRatio.html)() → [double](https://api.flutter.dev/flutter/dart-core/double-class.html)

Get the device pixel ratio.

##### [getOpacity](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getOpacity.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[double](https://api.flutter.dev/flutter/dart-core/double-class.html)\>

Returns `double` - between 0.0 (fully transparent) and 1.0 (fully opaque).

##### [getPosition](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getPosition.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[Offset](https://api.flutter.dev/flutter/dart-ui/Offset-class.html)\>

Returns `Offset` - Contains the window's current position.

##### [getSize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getSize.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html)\>

Returns `Size` - Contains the window's width and height.

##### [getTitle](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getTitle.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[String](https://api.flutter.dev/flutter/dart-core/String-class.html)\>

Returns `String` - The title of the native window.

##### [getTitleBarHeight](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getTitleBarHeight.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[int](https://api.flutter.dev/flutter/dart-core/int-class.html)\>

Returns `int` - The title bar height of the native window.

##### [hasShadow](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/hasShadow.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window has a shadow. On Windows, always returns true unless window is frameless.

##### [hide](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/hide.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Hides the window.

##### [invokeMethodToWindow](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/invokeMethodToWindow.html)([int](https://api.flutter.dev/flutter/dart-core/int-class.html) targetWindowId, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) method, \[dynamic args\]) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)

Invokes a method on the window with id `targetWindowId`. It could return a Future that resolves to the return value of the invoked method, otherwise `null`. Use [WindowListener.onEventFromWindow](https://pub.##### dev/documentation/window_manager_plus/latest/WindowListener/onEventFromWindow.html) to listen for the event.

##### [isAlwaysOnBottom](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isAlwaysOnBottom.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is always below other windows.

##### [isAlwaysOnTop](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isAlwaysOnTop.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is always on top of other windows.

##### [isClosable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isClosable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window can be manually closed by user.

##### [isDockable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isDockable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is dockable or not.

##### [isDocked](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isDocked.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[DockSide](https://pub.dev/documentation/window_manager_plus/latest/DockSide.html)?\>

Returns `bool` - Whether the window is docked.

##### [isFocused](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isFocused.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether window is focused.

##### [isFullScreen](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isFullScreen.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is in fullscreen mode.

##### [isMaximizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isMaximizable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window can be manually maximized by the user.

##### [isMaximized](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isMaximized.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is maximized.

##### [isMinimizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isMinimizable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window can be manually minimized by the user.

##### [isMinimized](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isMinimized.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is minimized.

##### [isMovable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isMovable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window can be moved by user.

##### [isPreventClose](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isPreventClose.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Check if is intercepting the native close signal.

##### [isResizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isResizable.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window can be manually resized by the user.

##### [isSkipTaskbar](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isSkipTaskbar.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether skipping taskbar is enabled.

##### [isVisible](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isVisible.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is visible to the user.

##### [isVisibleOnAllWorkspaces](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/isVisibleOnAllWorkspaces.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Returns `bool` - Whether the window is visible on all workspaces.

##### [maximize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/maximize.html)({[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) vertically = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Maximizes the window. `vertically` simulates aero snap, only works on Windows

##### [minimize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/minimize.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Minimizes the window. On some platforms the minimized window will be shown in the Dock.

##### [popUpWindowMenu](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/popUpWindowMenu.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

##### [removeListener](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/removeListener.html)([WindowListener](https://pub.dev/documentation/window_manager_plus/latest/WindowListener-class.html) listener) → void

Remove a listener from the window.

##### [restore](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/restore.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Restores the window from minimized state to its previous state.

##### [setAlignment](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setAlignment.html)([Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) alignment, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) animate = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Move the window to a position aligned with the screen.

##### [setAlwaysOnBottom](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setAlwaysOnBottom.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isAlwaysOnBottom) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window should show always below other windows.

##### [setAlwaysOnTop](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setAlwaysOnTop.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isAlwaysOnTop) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window should show always on top of other windows.

##### [setAsFrameless](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setAsFrameless.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

You can call this to remove the window frame (title bar, outline border, etc), which is basically everything except the Flutter view, also can call setTitleBarStyle(TitleBarStyle.normal) or setTitleBarStyle(TitleBarStyle.hidden) to restore it.

##### [setAspectRatio](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setAspectRatio.html)([double](https://api.flutter.dev/flutter/dart-core/double-class.html) aspectRatio) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

This will make a window maintain an aspect ratio.

##### [setBackgroundColor](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setBackgroundColor.html)([Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backgroundColor) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets the background color of the window.

##### [setBadgeLabel](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setBadgeLabel.html)(\[[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? label\]) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Set/unset label on taskbar(dock) app icon

##### [setBounds](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setBounds.html)([Rect](https://api.flutter.dev/flutter/dart-ui/Rect-class.html)? bounds, {[Offset](https://api.flutter.dev/flutter/dart-ui/Offset-class.html)? position, [Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html)? size, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) animate = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Resizes and moves the window to the supplied bounds.

##### [setBrightness](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setBrightness.html)([Brightness](https://api.flutter.dev/flutter/dart-ui/Brightness.html) brightness) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets the brightness of the window.

##### [setClosable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setClosable.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isClosable) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window can be manually closed by user.

##### [setFullScreen](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setFullScreen.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isFullScreen) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window should be in fullscreen mode.

##### [setHasShadow](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setHasShadow.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) hasShadow) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window should have a shadow. On Windows, doesn't do anything unless window is frameless.

##### [setIcon](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setIcon.html)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) iconPath) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets window/taskbar icon.

##### [setIgnoreMouseEvents](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setIgnoreMouseEvents.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) ignore, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) forward = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Makes the window ignore all mouse events.

##### [setMaximizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setMaximizable.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isMaximizable) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window can be manually maximized by the user.

##### [setMaximumSize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setMaximumSize.html)([Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html) size) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets the maximum size of window to `width` and `height`.

##### [setMinimizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setMinimizable.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isMinimizable) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window can be manually minimized by user.

##### [setMinimumSize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setMinimumSize.html)([Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html) size) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets the minimum size of window to `width` and `height`.

##### [setMovable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setMovable.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isMovable) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window can be moved by user.

##### [setOpacity](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setOpacity.html)([double](https://api.flutter.dev/flutter/dart-core/double-class.html) opacity) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets the opacity of the window.

##### [setPosition](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setPosition.html)([Offset](https://api.flutter.dev/flutter/dart-ui/Offset-class.html) position, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) animate = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Moves window to position.

##### [setPreventClose](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setPreventClose.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isPreventClose) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Set if intercept the native close signal. May useful when combine with the onclose event listener. This will also prevent the manually triggered close event.

##### [setProgressBar](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setProgressBar.html)([double](https://api.flutter.dev/flutter/dart-core/double-class.html) progress) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets progress value in progress bar. Valid range is `0, 1.0`.

##### [setResizable](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setResizable.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isResizable) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window can be manually resized by the user.

##### [setSize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setSize.html)([Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html) size, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) animate = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Resizes the window to `width` and `height`.

##### [setSkipTaskbar](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setSkipTaskbar.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isSkipTaskbar) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Makes the window not show in the taskbar / dock.

##### [setTitle](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setTitle.html)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) title) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Changes the title of native window to title.

##### [setTitleBarStyle](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setTitleBarStyle.html)([TitleBarStyle](https://pub.dev/documentation/window_manager_plus/latest/TitleBarStyle.html) titleBarStyle, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) windowButtonVisibility = true}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Changes the title bar style of native window.

##### [setVisibleOnAllWorkspaces](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/setVisibleOnAllWorkspaces.html)([bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) visible, {[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? visibleOnFullScreen}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Sets whether the window should be visible on all workspaces.

##### [show](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/show.html)({[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) inactive = false}) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Shows and gives focus to the window.

##### [startDragging](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/startDragging.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Starts a window drag based on the specified mouse-down event. On Windows, this is disabled during full screen mode.

##### [startResizing](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/startResizing.html)([ResizeEdge](https://pub.dev/documentation/window_manager_plus/latest/ResizeEdge.html) resizeEdge) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Starts a window resize based on the specified mouse-down & mouse-move event. On Windows, this is disabled during full screen mode.

##### [toString](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/toString.html)() → [String](https://api.flutter.dev/flutter/dart-core/String-class.html)

A string representation of this object.

##### [undock](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/undock.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)\>

Undocks the window. only works on Windows

##### [unmaximize](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/unmaximize.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Unmaximizes the window.

##### [waitUntilReadyToShow](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/waitUntilReadyToShow.html)(\[[WindowOptions](https://pub.dev/documentation/window_manager_plus/latest/WindowOptions-class.html)? options, [VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html)? callback\]) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Wait until ready to show.

#### Static Methods

##### [addGlobalListener](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/addGlobalListener.html)([WindowListener](https://pub.dev/documentation/window_manager_plus/latest/WindowListener-class.html) listener) → void

Add a global listener to the window.

##### [createWindow](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/createWindow.html)(\[[List](https://api.flutter.dev/flutter/dart-core/List-class.html)<[String](https://api.flutter.dev/flutter/dart-core/String-class.html)\>? args\]) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[WindowManagerPlus](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus-class.html)?\>

Create a new window.

##### [ensureInitialized](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/ensureInitialized.html)([int](https://api.flutter.dev/flutter/dart-core/int-class.html) windowId) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<void\>

Ensure the window manager for this `windowId` is initialized. Must be called before accessing the [WindowManagerPlus.current](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/current.html).

##### [fromWindowId](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/fromWindowId.html)([int](https://api.flutter.dev/flutter/dart-core/int-class.html) windowId) → [WindowManagerPlus](https://pub.##### dev/documentation/window_manager_plus/latest/WindowManagerPlus-class.html)

Get the window manager from the window id.

##### [getAllWindowManagerIds](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/getAllWindowManagerIds.html)() → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)<[List](https://api.flutter.dev/flutter/dart-core/List-class.html)<[int](https://api.flutter.dev/flutter/dart-core/int-class.html)\>\>

Get all window manager ids.

##### [removeGlobalListener](https://pub.dev/documentation/window_manager_plus/latest/WindowManagerPlus/removeGlobalListener.html)([WindowListener](https://pub.dev/documentation/window_manager_plus/latest/WindowListener-class.html) listener) → void

Remove a global listener from the window.

### WindowListener

#### Methods

##### [onEventFromWindow](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onEventFromWindow.html)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) eventName, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) fromWindowId, dynamic arguments) → [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)

Event from other windows.

##### [onWindowBlur](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowBlur.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window loses focus.

##### [onWindowClose](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowClose.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window is going to be closed.

##### [onWindowDocked](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowDocked.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window entered a docked state.

##### [onWindowEnterFullScreen](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowEnterFullScreen.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window enters a full-screen state.

##### [onWindowEvent](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowEvent.html)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) eventName, \[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted all events.

##### [onWindowFocus](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowFocus.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window gains focus.

##### [onWindowLeaveFullScreen](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowLeaveFullScreen.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window leaves a full-screen state.

##### [onWindowMaximize](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowMaximize.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when window is maximized.

##### [onWindowMinimize](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowMinimize.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window is minimized.

##### [onWindowMove](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowMove.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window is being moved to a new position.

##### [onWindowMoved](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowMoved.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted once when the window is moved to a new position.

##### [onWindowResize](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowResize.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted after the window has been resized.

##### [onWindowResized](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowResized.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted once when the window has finished being resized.

##### [onWindowRestore](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowRestore.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window is restored from a minimized state.

##### [onWindowUndocked](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowUndocked.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window leaves a docked state.

##### [onWindowUnmaximize](https://pub.dev/documentation/window_manager_plus/latest/WindowListener/onWindowUnmaximize.html)(\[[int](https://api.flutter.dev/flutter/dart-core/int-class.html)? windowId\]) → void

Emitted when the window exits from a maximized state.

[toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() → [String](https://api.flutter.dev/flutter/dart-core/String-class.html)

A string representation of this object.

inherited

<!-- README_DOC_GEN -->

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

## License

[MIT](./LICENSE)
