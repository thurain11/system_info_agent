//
// Created by Thurain Hein on 22/08/2025.
//

import Foundation
import Flutter
import UIKit
import WebKit

@objc(SystemInfoAgentPlugin)
public class SystemInfoAgentPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "system_info_agent", binaryMessenger: registrar.messenger())
        let instance = SystemInfoAgentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getProperties":
            let userAgent = getDalvikUserAgent()
            getWebViewUserAgent { webViewUserAgent in
                       let properties: [String: String] = [
                           "userAgent": userAgent,
                           "webViewUserAgent": webViewUserAgent
                       ]
                       result(properties)
                   }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    

    // Dalvik style userAgent (fake format for iOS)
    private func getDalvikUserAgent() -> String {
        let osVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        let id = ProcessInfo.processInfo.operatingSystemVersionString
        return "Dalvik/2.1.0 (Linux; U; iOS \(osVersion); \(model) Build/\(id))"
    }

    // WebView user agent (sync fetch using DispatchSemaphore)
    private func getWebViewUserAgent(completion: @escaping (String) -> Void) {
        let webView = WKWebView(frame: .zero)

        if let ua = webView.value(forKey: "userAgent") as? String {
            print("WebView UA via value(forKey:) ------ \(ua)")
            completion(ua)
        } else if let ua = webView.customUserAgent {
            print("WebView UA via customUserAgent ----- \(ua)")
            completion(ua)
        } else {
            webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
                if let ua = result as? String {
                    print("WebView UA via evaluateJavaScript: \(ua)")
                    completion(ua)
                } else {
                    print("WebView UA fetch failed, error: \(String(describing: error))")
                    completion("Unknown")
                }
            }
        }
    }
}
