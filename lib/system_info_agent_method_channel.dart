import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'system_info_agent_platform_interface.dart';

/// An implementation of [SystemInfoAgentPlatform] that uses method channels.
class MethodChannelSystemInfoAgent extends SystemInfoAgentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('system_info_agent');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
