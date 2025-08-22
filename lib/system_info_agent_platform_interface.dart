import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'system_info_agent_method_channel.dart';

abstract class SystemInfoAgentPlatform extends PlatformInterface {
  /// Constructs a SystemInfoAgentPlatform.
  SystemInfoAgentPlatform() : super(token: _token);

  static final Object _token = Object();

  static SystemInfoAgentPlatform _instance = MethodChannelSystemInfoAgent();

  /// The default instance of [SystemInfoAgentPlatform] to use.
  ///
  /// Defaults to [MethodChannelSystemInfoAgent].
  static SystemInfoAgentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SystemInfoAgentPlatform] when
  /// they register themselves.
  static set instance(SystemInfoAgentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
