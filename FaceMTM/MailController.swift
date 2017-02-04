//
//  MailController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 03/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import Foundation
import MessageUI

class MailController: NSObject {
    
    var emailFuncionario: String = ""
    
    var viewChamadora: UIViewController = UIViewController()
    
    init(view: UIViewController) {
        viewChamadora = view
    }
    
    func sendMail(email: String) {
        
        emailFuncionario = email
        
        let mailComposeViewController = configureMailComposeViewController(email)
        if MFMailComposeViewController.canSendMail(){
            viewChamadora.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
            
        }
    }
    
    func configureMailComposeViewController(_ email: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = viewChamadora as? MFMailComposeViewControllerDelegate
        
        mailComposerVC.setToRecipients([email])
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Erro ao envir e-mail.", message: "Seu dispositivo não permite envio de e-mail", preferredStyle: .alert)
        
        let alertaConfirma = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        sendMailErrorAlert.addAction(alertaConfirma)
        
        viewChamadora.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    

    
    
}
