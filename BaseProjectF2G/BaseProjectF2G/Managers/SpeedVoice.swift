//
//  SpeedVoice.swift
//  sTranslator
//
//  Created by Quynh Nguyen on 10/2/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import Foundation
import AVFoundation

public let MinimumSpeechRate: Float = 0.1
public let MaximumSpeechRate: Float = 0.6

class SpeedVoice: NSObject {
    static let SPEECH_CAN_TRANSLATE = "speech can translate"
    static let SPEECH_CANT_TRANSLATE = "speech can't translate"
    let synthesizer = AVSpeechSynthesizer()

    var voiceSpeed: Float = AVSpeechUtteranceDefaultSpeechRate {
        didSet {
            if self.isSupport(language: self.voiceLang) {
                let _ = self.textToSpeed(text: SpeedVoice.SPEECH_CAN_TRANSLATE, voice_code: self.voiceLang, completion: nil)
            }
            else {
                let _ = self.textToSpeed(text: SpeedVoice.SPEECH_CANT_TRANSLATE, voice_code: self.voiceLang, completion: nil)
            }
        }
    }
    
    var voiceLang: String = "en-US"
    var completionHandler: Completion?
    
    //MARK: Shared Instance
    static let shared : SpeedVoice = {
        let instance = SpeedVoice()
        return instance
    }()
    
    override init() {
        
    }
    func stopSpeech() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    func prepareAudioSession() {
        let audioSpeech = AVAudioSession.sharedInstance()
        do {
            try audioSpeech.setCategory(AVAudioSessionCategoryAmbient)
            try audioSpeech.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            BLogError("\(error)")
        }
    }
    
    func textToSpeed(text: String, voice_code: String, completion: Completion?) -> Bool {
        if !self.isSupport(language: voice_code) {
            return false
        }
        
        prepareAudioSession()
        
        self.voiceLang = voice_code
        self.completionHandler = completion
        
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: self.voiceLang)
        utterance.rate = voiceSpeed
        stopSpeak()

        synthesizer.delegate = self
        synthesizer.speak(utterance)
        
        return true
    }
    func stopSpeak() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    func isRunning() -> Bool  {
        return synthesizer.isSpeaking
    }
    func isSupport(language: String) -> Bool {
        for item in AVSpeechSynthesisVoice.speechVoices() {
            //print("\(item.name) - \(item.language)")
            if language == item.language {
                return true
            }
        }
        return false
    }
    
}

extension SpeedVoice: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        BLogInfo("Speaker class started")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        BLogInfo("Speaker class finished")
        if let com = completionHandler {
            com(true, nil)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        if let com = completionHandler {
            com(false, nil)
        }
    }
}
