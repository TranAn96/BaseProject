//
//  SettingManage.swift
//  sTranslator
//
//  Created by Quynh Nguyen on 10/2/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import Foundation



class SettingManage: NSObject {
    private let K_TRANSLATE_MODE = "K_TRANSLATE_MODE"
    private let K_VOICE_GENDER = "K_VOICE_GENDER"
    private let K_VOICE_SPEED = "K_VOICE_SPEED"
    private let K_AUTO_SPEAK = "K_AUTO_SPEAK"
    private let K_AUTO_TRANSLATE = "K_AUTO_TRANSLATE"
    private let K_AUTO_TRANSLATE_SPEECH = "K_AUTO_TRANSLATE_SPEECH"
    private let K_AUTO_TRANSLATE_IMAGE = "K_AUTO_TRANSLATE_IMAGE"
    private let K_AUTO_DETECT_END_OF_SPEED = "K_AUTO_DETECT_END_OF_SPEED"
    private let K_AUTO_SAVE_ICLOUD = "K_AUTO_SAVE_ICLOUD"
    private let K_LANGUAGE_INPUT = "K_LANGUAGE_INPUT"
    private let K_LANGUAGE_OUTPUT = "K_LANGUAGE_OUTPUT"
    private let K_DETECT_END_OF_SPEECH_INTERVAL = "K_DETECT_END_OF_SPEECH_INTERVAL"
    private let K_ALLOW_REQUEST = "K_ALLOW_REQUEST"
    private let K_ALLOW_IMAGE = "K_ALLOW_IMAGE"
    
    private let K_NUMBER_TRANSLATE = "K_NUMBER_TRANSLATE"
    private let K_NUMBER_TRANSLATE_IMAGE = "K_NUMBER_TRANSLATE_IMAGE"

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

  
    
    var translateMode: TranslateMode {
        set {
            UserDefaults.standard.set(translateMode, forKey: K_TRANSLATE_MODE)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_TRANSLATE_MODE) {
                return obj as! TranslateMode
            }
            return .textToText
        }
    }
    
    var voiceGender: Bool {
        set {
            UserDefaults.standard.set(voiceGender, forKey: K_VOICE_GENDER)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_VOICE_GENDER) {
                return obj as! Bool
            }
            return false
        }
    }
    
    var voiceSpeed: Float {
        set {
            UserDefaults.standard.set(newValue, forKey: K_VOICE_SPEED)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_VOICE_SPEED) {
                return obj as! Float
            }
            return 0.5  // default
        }
    }
    
    var autoSpeak: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: K_AUTO_SPEAK)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_SPEAK) {
                return obj as! Bool
            }
            return true
        }
    }
    var autoTranslate: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: K_AUTO_TRANSLATE)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_TRANSLATE) {
                return obj as! Bool
            }
            return true
        }
    }
    var autoTranslateSpeech: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: K_AUTO_TRANSLATE_SPEECH)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_TRANSLATE_SPEECH) {
                return obj as! Bool
            }
            return true
        }
    }
    var autoTranslateImage: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: K_AUTO_TRANSLATE_IMAGE)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_TRANSLATE_IMAGE) {
                return obj as! Bool
            }
            return true
        }
    }
    var detectEndOfSpeechInterval: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: K_DETECT_END_OF_SPEECH_INTERVAL)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_DETECT_END_OF_SPEECH_INTERVAL) {
                return obj as! Int
            }
            return 0
        }
    }
    var autoDetectEndOfSpeed: Bool {
        set {
            UserDefaults.standard.set(autoDetectEndOfSpeed, forKey: K_AUTO_DETECT_END_OF_SPEED)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_DETECT_END_OF_SPEED) {
                return obj as! Bool
            }
            return false
        }
    }
    
    var numberTranslate : Int {
        set{
            let date = NSDate()
            let key =  K_NUMBER_TRANSLATE + date.getDate()
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
        get {
            let date = NSDate()
            let key =  K_NUMBER_TRANSLATE + date.getDate()
            if let obj = UserDefaults.standard.object(forKey: key) {
                return obj as! Int
            }
            return 0
        }
    }
    
    var numberTranslateImage : Int {
        set{
            let date = NSDate()
            let key =  K_NUMBER_TRANSLATE_IMAGE + date.getDate()
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
        get {
            let date = NSDate()
            let key =  K_NUMBER_TRANSLATE_IMAGE + date.getDate()
            if let obj = UserDefaults.standard.object(forKey: key) {
                return obj as! Int
            }
            return 0
        }
    }
    
    var saveICloud: Bool {
        set {
            UserDefaults.standard.set(saveICloud, forKey: K_AUTO_SAVE_ICLOUD)
            UserDefaults.standard.synchronize()
        }
        get {
            if let obj = UserDefaults.standard.object(forKey: K_AUTO_SAVE_ICLOUD) {
                return obj as! Bool
            }
            return false
        }
    }
    
    let K_MAX_REQUEST_TRANSLATE = 100
    let K_MAX_REQUEST_IMAGE  = 10
    
 
    //MARK: Shared Instance
    static let shared : SettingManage = {
        let instance = SettingManage()
        return instance
    }()
    
    override init() {
        
    }
    
    
    
}
