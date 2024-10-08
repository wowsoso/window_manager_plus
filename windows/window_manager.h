#ifndef WINDOW_MANAGER_WINDOW_MANAGER_H_
#define WINDOW_MANAGER_WINDOW_MANAGER_H_

#include "include/window_manager/window_manager_plugin.h"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <codecvt>
#include <dwmapi.h>
#include <map>
#include <memory>
#include <sstream>

#define STATE_NORMAL 0
#define STATE_MAXIMIZED 1
#define STATE_MINIMIZED 2
#define STATE_FULLSCREEN_ENTERED 3
#define STATE_DOCKED 4

namespace {

class WindowManager {
 public:
  WindowManager();

  virtual ~WindowManager();

  inline static int64_t id_ = 0;
  inline static std::map<int64_t, std::shared_ptr<FlutterWindow>> windows_ = {};
  inline static std::map<int64_t, WindowManager*> windowManagers_ = {};

  std::unique_ptr<
      flutter::MethodChannel<flutter::EncodableValue>,
      std::default_delete<flutter::MethodChannel<flutter::EncodableValue>>>
      static_channel = nullptr;

  std::unique_ptr<
      flutter::MethodChannel<flutter::EncodableValue>,
      std::default_delete<flutter::MethodChannel<flutter::EncodableValue>>>
      channel = nullptr;

  HWND native_window;

  int last_state = STATE_NORMAL;

  bool has_shadow_ = false;
  bool is_always_on_bottom_ = false;
  bool is_frameless_ = false;
  bool is_prevent_close_ = false;
  double aspect_ratio_ = 0;
  POINT minimum_size_ = {0, 0};
  POINT maximum_size_ = {-1, -1};
  double pixel_ratio_ = 1;
  bool is_resizable_ = true;
  int is_docked_ = 0;
  bool is_registered_for_docking_ = false;
  bool is_skip_taskbar_ = true;
  std::string title_bar_style_ = "normal";
  double opacity_ = 1;

  bool is_resizing_ = false;
  bool is_moving_ = false;

  HWND GetMainWindow();
  void WindowManager::ForceRefresh();
  void WindowManager::ForceChildRefresh();
  void WindowManager::SetAsFrameless();
  void WindowManager::WaitUntilReadyToShow();
  void WindowManager::Destroy();
  void WindowManager::Close();
  bool WindowManager::IsPreventClose();
  void WindowManager::SetPreventClose(const flutter::EncodableMap& args);
  void WindowManager::Focus();
  void WindowManager::Blur();
  bool WindowManager::IsFocused();
  void WindowManager::Show();
  void WindowManager::Hide();
  bool WindowManager::IsVisible();
  bool WindowManager::IsMaximized();
  void WindowManager::Maximize(const flutter::EncodableMap& args);
  void WindowManager::Unmaximize();
  bool WindowManager::IsMinimized();
  void WindowManager::Minimize();
  void WindowManager::Restore();
  bool WindowManager::IsDockable();
  int WindowManager::IsDocked();
  void WindowManager::Dock(const flutter::EncodableMap& args);
  bool WindowManager::Undock();
  bool WindowManager::IsFullScreen();
  void WindowManager::SetFullScreen(const flutter::EncodableMap& args);
  void WindowManager::SetAspectRatio(const flutter::EncodableMap& args);
  void WindowManager::SetBackgroundColor(const flutter::EncodableMap& args);
  flutter::EncodableMap WindowManager::GetBounds(
      const flutter::EncodableMap& args);
  void WindowManager::SetBounds(const flutter::EncodableMap& args);
  void WindowManager::SetMinimumSize(const flutter::EncodableMap& args);
  void WindowManager::SetMaximumSize(const flutter::EncodableMap& args);
  bool WindowManager::IsResizable();
  void WindowManager::SetResizable(const flutter::EncodableMap& args);
  bool WindowManager::IsMinimizable();
  void WindowManager::SetMinimizable(const flutter::EncodableMap& args);
  bool WindowManager::IsMaximizable();
  void WindowManager::SetMaximizable(const flutter::EncodableMap& args);
  bool WindowManager::IsClosable();
  void WindowManager::SetClosable(const flutter::EncodableMap& args);
  bool WindowManager::IsAlwaysOnTop();
  void WindowManager::SetAlwaysOnTop(const flutter::EncodableMap& args);
  bool WindowManager::IsAlwaysOnBottom();
  void WindowManager::SetAlwaysOnBottom(const flutter::EncodableMap& args);
  std::string WindowManager::GetTitle();
  void WindowManager::SetTitle(const flutter::EncodableMap& args);
  void WindowManager::SetTitleBarStyle(const flutter::EncodableMap& args);
  int WindowManager::GetTitleBarHeight();
  bool WindowManager::IsSkipTaskbar();
  void WindowManager::SetSkipTaskbar(const flutter::EncodableMap& args);
  void WindowManager::SetProgressBar(const flutter::EncodableMap& args);
  void WindowManager::SetIcon(const flutter::EncodableMap& args);
  bool WindowManager::HasShadow();
  void WindowManager::SetHasShadow(const flutter::EncodableMap& args);
  double WindowManager::GetOpacity();
  void WindowManager::SetOpacity(const flutter::EncodableMap& args);
  void WindowManager::SetBrightness(const flutter::EncodableMap& args);
  void WindowManager::SetIgnoreMouseEvents(const flutter::EncodableMap& args);
  void WindowManager::PopUpWindowMenu(const flutter::EncodableMap& args);
  void WindowManager::StartDragging();
  void WindowManager::StartResizing(const flutter::EncodableMap& args);

  static int64_t WindowManager::createWindow(
      const std::vector<std::string>& args);

 private:
  static constexpr auto kFlutterViewWindowClassName = L"FLUTTERVIEW";
  bool g_is_window_fullscreen = false;
  std::string g_title_bar_style_before_fullscreen;
  RECT g_frame_before_fullscreen;
  bool g_maximized_before_fullscreen;
  LONG g_style_before_fullscreen;
  ITaskbarList3* taskbar_ = nullptr;
  double GetDpiForHwnd(HWND hWnd);
  BOOL WindowManager::RegisterAccessBar(HWND hwnd, BOOL fRegister);
  void PASCAL WindowManager::AppBarQuerySetPos(HWND hwnd,
                                               UINT uEdge,
                                               LPRECT lprc,
                                               PAPPBARDATA pabd);
  void WindowManager::DockAccessBar(HWND hwnd, UINT edge, UINT windowWidth);
};
}  // namespace
#endif  // WINDOW_MANAGER_WINDOW_MANAGER_H_