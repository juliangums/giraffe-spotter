import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "ax.synt.giraffe_spotter/coordinates", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "getCoordsFilePath" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self?.getCoordsFilePath(result: result, call: call)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getCoordsFilePath(result: FlutterResult, call: FlutterMethodCall) {
        var latPoints: [Any] = Array()
        var longPoints: [Any] = Array()
        if let args = call.arguments as? Dictionary<String, Any> {
            if let path = args["path"] as? String {
                let cfUrl = URL(fileURLWithPath: path) as CFURL
                if let imageSource = CGImageSourceCreateWithURL(cfUrl, nil) {
                    let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
                    if let dict = imageProperties as? [NSString: AnyObject] {

                        if let gps = dict[kCGImagePropertyGPSDictionary] as? [NSString: AnyObject] {
                            var lat: Float = 0.0
                            if let latitude = gps[kCGImagePropertyGPSLatitude] as? NSNumber {
                                lat = Float(CLLocationDegrees(latitude.floatValue))
                            }

                            var long: Float = 0.0
                            if let longitude = gps[kCGImagePropertyGPSLongitude] as? NSNumber {
                                long = Float(CLLocationDegrees(longitude.floatValue))
                            }
                            
                            var latRef: String = ""
                            if let latitudeRef = gps[kCGImagePropertyGPSLatitudeRef] as? NSString {
                                latRef = latitudeRef as String
                            }
                            
                            var longRef: String = ""
                            if let longitudeRef = gps[kCGImagePropertyGPSLongitudeRef] as? NSString {
                                longRef = longitudeRef  as String
                            }
                            latPoints = [lat, latRef]
                            longPoints = [long, longRef]
                            
                        }
                    }
                }
            }
        }
        result([latPoints, longPoints])
  }
}
