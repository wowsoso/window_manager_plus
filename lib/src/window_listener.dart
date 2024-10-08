abstract mixin class WindowListener {
  /// Emitted when the window is going to be closed.
  void onWindowClose([int? windowId]) {}

  /// Emitted when the window gains focus.
  void onWindowFocus([int? windowId]) {}

  /// Emitted when the window loses focus.
  void onWindowBlur([int? windowId]) {}

  /// Emitted when window is maximized.
  void onWindowMaximize([int? windowId]) {}

  /// Emitted when the window exits from a maximized state.
  void onWindowUnmaximize([int? windowId]) {}

  /// Emitted when the window is minimized.
  void onWindowMinimize([int? windowId]) {}

  /// Emitted when the window is restored from a minimized state.
  void onWindowRestore([int? windowId]) {}

  /// Emitted after the window has been resized.
  void onWindowResize([int? windowId]) {}

  /// Emitted once when the window has finished being resized.
  ///
  /// @platforms macos,windows
  void onWindowResized([int? windowId]) {}

  /// Emitted when the window is being moved to a new position.
  void onWindowMove([int? windowId]) {}

  /// Emitted once when the window is moved to a new position.
  ///
  /// @platforms macos,windows
  void onWindowMoved([int? windowId]) {}

  /// Emitted when the window enters a full-screen state.
  void onWindowEnterFullScreen([int? windowId]) {}

  /// Emitted when the window leaves a full-screen state.
  void onWindowLeaveFullScreen([int? windowId]) {}

  /// Emitted when the window entered a docked state.
  ///
  /// @platforms windows
  void onWindowDocked([int? windowId]) {}

  /// Emitted when the window leaves a docked state.
  ///
  /// @platforms windows
  void onWindowUndocked([int? windowId]) {}

  /// Emitted all events.
  void onWindowEvent(String eventName, [int? windowId]) {}

  Future<dynamic> onEventFromWindow(String eventName, int fromWindowId, dynamic arguments) async {
    throw UnimplementedError();
  }
}
