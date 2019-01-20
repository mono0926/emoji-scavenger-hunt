import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window.rootViewController as! FlutterViewController
    let cameraChannel = FlutterMethodChannel(name: "mono0926.com/camera",
                                             binaryMessenger: controller)
    cameraChannel.setMethodCallHandler { (call, result) in
        if (call.method == "saveAsImageFile") {
            let plane = call.arguments as! [String: Any]
            let data = plane["bytes"] as! FlutterStandardTypedData
            let width = plane["width"] as! Int
            let height = plane["height"] as! Int
            let bytesPerRow = plane["bytesPerRow"] as! Int
            var bytes = data.data //as NSData

//            CGBitmapContextCreate.(<#T##data: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>, <#T##width: Int##Int#>, <#T##height: Int##Int#>, <#T##bitsPerComponent: Int##Int#>, <#T##bytesPerRow: Int##Int#>, <#T##space: CGColorSpace##CGColorSpace#>, <#T##bitmapInfo: UInt32##UInt32#>)

//            let context =  CGContext(data: &bytes,
//                                     width: width,
//                                     height: height,
//                                     bitsPerComponent: 8,
//                                     bytesPerRow: bytesPerRow,
//                                     space: CGColorSpaceCreateDeviceRGB(),
//                                     bitmapInfo: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue))!

//            bytes.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) in
//                let context =  CGContext(data: UnsafeMutableRawPointer(pointer),
//                                         width: 0,
//                                         height: 0,
//                                         bitsPerComponent: 8,
//                                         bytesPerRow: 480,
//                                         space: CGColorSpaceCreateDeviceRGB(),
//                                         bitmapInfo: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue))
//            }

//            bytes.withUnsafeMutableBytes { (rawData: UnsafeMutablePointer<UInt8>) in
//                let context = CGBitmapContextCreate(data: rawData,
//                                        width: width,
//                                        height: height,
//                                        bitsPerComponent: 8,
//                                        bytesPerRow: bytesPerRow,
//                                        space: CGColorSpaceCreateDeviceRGB(),
//                                        bitmapInfo: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue))!
////                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//                result("(　´･‿･｀)")
//            }


//            let coreImage = CIImage(bitmapData: bytes, bytesPerRow: bytesPerRow, size: CGSize(width: width, height: height), format: kCIFormatRGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())

//            var pixelAttributes = NSDictionary(dictionary: [kCVPixelBufferIOSurfacePropertiesKey: NSDictionary()])
//            var pixelBuffer: CVPixelBuffer? = nil
//            let r = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, pixelAttributes, &pixelBuffer)
//
//            let coreImage = CIImage(cvImageBuffer: pixelBuffer!)
//            let context = CIContext(options: nil)
//            let cgImage = context.createCGImage(coreImage, from: CGRect(x: 0, y: 0, width: width, height: height))

            result("(　´･‿･｀)")
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
