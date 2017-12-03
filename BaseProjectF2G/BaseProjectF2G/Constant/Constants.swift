///  Created by Admin on 9/12/17.
//  Copyright © 2017 ListenEnglish. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift


typealias Completion = (_ succes: Bool, _ data: Any?) -> ()

// MARK: Appdelegate
let appdelegate = (UIApplication.shared.delegate as! AppDelegate)

// MARK: CompletionHandler
typealias CompletionHandler = (Bool, Int, Any?) -> ()

// MARK: - Public constant

// Standard UserDefault
public let SETTINGs = UserDefaults.standard

// define font
public let kRegularFont = UIFont(name: "Hiragino Sans", size: 13)
public let kBarButtonItemFont = UIFont.systemFont(ofSize: 15)
public let kTitleControllerFont = UIFont.boldSystemFont(ofSize: 17)

enum FlagAnimationType: Int {
    case none = -1
    case right2Left = 1
    case left2Right = 2
}

enum TranslateAction: Int {
    case speak
    case copie
    case share
    case delete
    case expand
}
public let ID_APPSTORE = "1297846438"
enum TranslateMode: Int {
    case speechToSpeech = 1
    case textToText = 2
    
    func info() -> String {
        switch self {
        case .speechToSpeech:
            return "Speech to speech"
        case .textToText:
            return "Text to text"
        }
    }
}



// Button color
public let kButtonFavoriteColor = Constants.Rgb2UIColor(red: 234, green: 83, blue: 72)
public let kButtonUnFavoriteColor = Constants.Rgb2UIColor(red: 67, green: 67, blue: 67)
public let kButtonBackgroundColor = Constants.Rgb2UIColor(red: 245, green: 242, blue: 230)
public let kTextColor = UIColor.colorFromHexString(hex: "#383838")
public let kMainColor = UIColor.colorFromHexString(hex: "#2597DC")
public let kRedColor = UIColor.colorFromHexString(hex: "#E34D3F")
public let kHeaderColor = UIColor.colorFromHexString(hex: "#2597dc")
public let kAvatarBorderColor = UIColor.colorFromHexString(hex: "#bbe8ff")
public let kLineColor = UIColor.colorFromHexString(hex: "#CECED2")

// App Url
public let kAppStoreID  = 1152372911 // Change this one to my app ID
public let kAppStoreURLFormat = "itms-apps://itunes.apple.com/app/id"

// Some Constant
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let OS_VERSION = UIDevice.current.systemVersion

class Constants {
    //MARK: - Contants will use in all class
    static var deviceToken : String? {
        
        get {
            
            if let value = SETTINGs.value(forKey: "DEVICE_TOKEN") {
                
                return value as? String
            } else {
                return ""
            }
        }
        
        set(newValue) {
            
            if newValue?.isEmpty == false {
                SETTINGs.set(newValue, forKey: "DEVICE_TOKEN")
                SETTINGs.synchronize()
            }
        }
    }
    
    // Convinient function
    internal class func RGBA2UIColor(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    internal class func Rgb2UIColor(red: Int, green: Int, blue: Int) -> UIColor{
        
        return Constants.RGBA2UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    internal class func colorFromImage(named: String) -> UIColor {
        return UIColor(patternImage: UIImage(named:named)!)
    }
    
    internal class func radians(degrees: CGFloat)-> CGFloat{
        
        return (degrees * CGFloat(Double.pi)/180)
    }
    
    internal class func degrees(radians: CGFloat)-> CGFloat{
        
        return (radians * 180/CGFloat(Double.pi))
    }
    
}

// MARK: - UserDefault
public let kDeviceToken = "kDeviceToken"
public let kAccessToken = "kAccessToken"
public let kLocationLat = "kLocationLat"
public let kLocationLong = "kLocationLong"
public let kDeviceUUID = "kDeviceUUID"
public let kVendorDeviceUUID = "kVendorDeviceUUID"

// MARK: - Standard UserDefault
public let standardUserDefaults = UserDefaults.standard
public let kUserInfoKey             = "userInfo"

// MARK: - Public Constants and Function
public let kTimeoutIntervalForRequest = TimeInterval(15)
public let kScreenSize = UIScreen.main.bounds
public let kDQErrorDomain = "kDQErrorDomain"
public let kAccessTokenErrorCode = 401
public let timeToDissmissHUD = 60.0
public let kImageQualityUpload = CGFloat(0.7)
public let kImageSizeUpload = CGFloat(640)
public let kMinBusinessTime = 8    // hour unit
public let kMaxBusinessTime = 15   // hour unit
public let expandToken = "Đọc tiếp"

// MARK: - Notification
public let kDidLoginNotification = "kDidLoginNotification"
public let kDidLogoutNotification = "kDidLogoutNotification"
public let kUpdateProfileNotification = "kUpdateProfileNotification"
public let kCreateIssueSuccessNotification = "kCreateIssueSuccessNotification"
public let kUpdateUser = "kUpdateUser"
public let kSelectEngineerSuccessNotification = "kSelectEngineerSuccessNotification"
public let kAppErrorDomain = "kAppErrorDomain"

public var kCommonTime: Int64 = 0

// MAP KEY

// MARK: - Network
public var isInternetConnected = true

// MARK: Compare version string
func isMathedVersion(currentVersion: String, newVersion: String) -> Bool {
    //        return true
    switch currentVersion.compare(newVersion, options: NSString.CompareOptions.numeric) {
    case .orderedSame, .orderedDescending:
        
        return true
    case .orderedAscending:
        
        return false
    }
}

// MARK: Local string function
func LANGTEXT(key: String)-> String {
    return key.localized()
}

func getCurrentLangtext() -> String {
    return Localize.currentLanguage()
}

func setLanguage(language: String) {
    
    let local = Localize.availableLanguages()
    
    if local.contains(language) {
        Localize.setCurrentLanguage(language)
    }
}

// MARK: - Loading func








