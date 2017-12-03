//
//  EmailManage.swift
//  BaseSwift
//
//  Created by Quynh Nguyen on 6/18/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import Foundation
import MessageUI

class EmailManage: NSObject {
    private let email_feedback = "support@5skay.net"
    
    //MARK: Shared Instance
    static let sharedInstance : EmailManage = {
        let instance = EmailManage()
        return instance
    }()
    
    override init() {
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
            
            let title = "[\(appName)] Feedback"
            var messeageBody = String()
            messeageBody.append("\n\n\n------------------------------------\n")
            messeageBody.append("System version: \(UIDevice.current.systemVersion)\n")
            messeageBody.append("System name: \(UIDevice.current.systemName)\n")
            messeageBody.append("App version: \(appVersion)\n")
            messeageBody.append("App build: \(appBuild)\n")
            
            composeVC.setToRecipients([email_feedback])
            composeVC.setSubject(title)
            composeVC.setMessageBody(messeageBody, isHTML: false)
            
            AppDelegate.shared.topMost.present(composeVC, animated: true, completion: nil)
        }
        else {
            //UtilManage.showAlertOK(title: "Notify", message: "You have not installed email.")
        }
    }
    
}

extension EmailManage: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
}
