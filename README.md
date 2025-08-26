# system_info_agent

A Flutter plugin to retrieve system user agent information for both Android and iOS platforms.

## Description

The `system_info_agent` plugin allows you to fetch the device's user agent string (Dalvik format for Android and a simulated format for iOS) and the WebView user agent. This is useful for applications that need to identify the browser or system context in which they are running. Developed and first published on August 22, 2025, at 02:22 PM +07.

## Features

- Retrieve the Dalvik-style user agent string.
- Fetch the WebView user agent string.
- Cross-platform support for Android and iOS.
- Simple and easy-to-use API.

## Installation

Add `system_info_agent` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  system_info_agent: ^1.0.0
```
Then, run the following command to fetch the package:
``` bash
flutter pub get
```

## IOS SETUP 
``` bash
pod install
```

## Usage
Import the package and use the SystemInfoAgent class to access user agent information:

```dart
import 'package:system_info_agent/system_info_agent.dart';

void main() async {
  // Initialize the agent
  await SystemInfoAgent.init();

  // Get user agent
  String? userAgent = SystemInfoAgent.userAgent;
  print('User Agent: $userAgent');

  // Get WebView user agent
  String? webViewUserAgent = SystemInfoAgent.webViewUserAgent;
  print('Web View User Agent: $webViewUserAgent');


}
```

## License
This package is licensed under the [MIT License](LICENSE). See the `LICENSE` file for details.

## Support 🎗️
For issues or questions, please open an issue on the [GitHub repository](https://github.com/thurain11/system_info_agent/tree/master) or contact the maintainer at [thurainhein097@gmail.com].
