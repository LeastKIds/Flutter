import UIKit
import Flutter
import Alamofire


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    let batteryChannel = FlutterMethodChannel(
            name: "abcd",
            binaryMessenger: controller.binaryMessenger)

    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          switch call.method {
          case "getBatteryLevel" :
              guard let args = call.arguments as? [String: String] else {return}
              let name = args["name"]!
              result(self.receiveBatteryLevel())

          case "test" :
              let url = "https://jsonplaceholder.typicode.com/posts"
              AF.request(url, method: .get).responseJSON{ response in
                  switch response.result {
                  case .success(let jsonData):
                      result(jsonData)
                  default :
                      result("failed")
                  }
                  
              }
              
          default :
              result(FlutterMethodNotImplemented)
          }
//      result(123)
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel() -> Int {
    let deivce = UIDevice.current
    deivce.isBatteryMonitoringEnabled = true

    if deivce.batteryState == UIDevice.BatteryState.unknown {
      return -1
    } else {
      return Int(deivce.batteryLevel * 100)
    }
  }

}
