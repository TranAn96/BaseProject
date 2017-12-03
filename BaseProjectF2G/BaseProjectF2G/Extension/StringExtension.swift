//
//  StringExtension.swift
//  Electrician
//
//  Created by luckymanbk on 8/30/16.
//  Copyright © 2016 Paditech. All rights reserved.
//

import UIKit
extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    func language() -> String? {
        let tagger = NSLinguisticTagger(tagSchemes: [NSLinguisticTagScheme.language], options: 0)
        tagger.string = self
        return tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language, tokenRange: nil, sentenceRange: nil).map { $0.rawValue }
    }
    
}
extension NSDate {
    func getDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let string = format.string(from: Date())
        
        return string
    }
}
extension String {
    
    var length : Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        
        return String(self[start..<end])
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    public func indexOfCharacter(_ char: Character) -> Int? {
        if let idx = self.characters.index(of: char) {
            return self.characters.distance(from: self.startIndex, to: idx)
        }
        
        return nil
    }

    
    func intValue() -> Int {
        if let value = Int(self) {
            return value
        }
        
        return 0
    }
    
    func floatValue() -> Float {
        if let value = Float(self) {
            return value
        }
        
        return 0.0
    }
    
    func doubleValue() -> Double {
        if let value = Double(self) {
            return value
        }
        
        return 0.0
    }
    
    func trimSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isValidUsername() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "([一-龯]+|[ぁ-んァ-ン]+|[a-zA-Z0-9]+|[ａ-ｚＡ-Ｚ０-９]+)$", options: .caseInsensitive)
            
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    func isValidPassword() -> Bool {
        //"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,12}"
        let stricterFilterString = "^.{6,12}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        
        return passwordTest.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, characters.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
    
    func toUnderlineMutableString(_ color: UIColor) -> NSMutableAttributedString {
        let mutableAtributeString = NSMutableAttributedString(attributedString: NSAttributedString(string: self))
        mutableAtributeString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleDouble.rawValue, range: NSMakeRange(0, self.characters.count))
        mutableAtributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(0, self.characters.count))
        
        return mutableAtributeString
    }
    
    func timeUTCtoDateString(format: String = "YYYY-MM-dd") -> String {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat =  format
        if let timeInterval = Double(self), timeInterval > 0 {
            
            return dateFormater.string(from: Date(timeIntervalSince1970: timeInterval))
        } else {
            
            return ""
        }
    }
    
    
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
