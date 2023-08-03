//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <agora_rtc_engine/agora_rtc_engine_plugin.h>
#include <agora_rtc_rawdata/agora_rtc_rawdata_plugin.h>
#include <iris_event/iris_event_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AgoraRtcEnginePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AgoraRtcEnginePlugin"));
  AgoraRtcRawdataPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AgoraRtcRawdataPlugin"));
  IrisEventPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("IrisEventPlugin"));
}
