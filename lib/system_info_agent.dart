import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemInfoAgent {
  static const MethodChannel _channel = MethodChannel('system_info_agent');
  static Map<String, dynamic>? _properties;

  /// Initializes the module by fetching properties from the native platform.
  /// Set [force] to true to refetch properties even if already cached.
  static Future<void> init({bool force = false}) async {
    if (_properties == null || force) {
      try {
        _properties = Map<String, dynamic>.from(
          await _channel.invokeMethod('getProperties'),
        );
      } catch (e) {
        debugPrint('Error initializing FkUserAgent: $e');
        _properties = {};
      }
    }
  }

  /// Releases cached properties.
  static void release() {
    _properties = null;
  }

  /// Returns the device's user agent.
  static String? get userAgent => _properties?['userAgent'];

  /// Returns the device's WebView user agent.
  static String? get webViewUserAgent => _properties?['webViewUserAgent'];

  /// Fetches a specific property synchronously.
  static dynamic getProperty(String property) => _properties?[property];

  /// Fetches a specific property asynchronously.
  static Future<dynamic> getPropertyAsync(String property) async {
    await init();
    return _properties?[property];
  }

  /// Returns all properties as a map.
  static Map<String, dynamic>? get properties => _properties;
}
