//
//  DetalheFuncionarioViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 03/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class DetalheFuncionarioViewController: UIViewController, MFMailComposeViewControllerDelegate  {
    
    
    @IBOutlet weak var imagemFuncionario: UIImageView!
    @IBOutlet weak var nomeFuncionario: UILabel!
    @IBOutlet weak var cargoFuncionario: UILabel!
    @IBOutlet weak var nascimentoFuncionario: UILabel!
    @IBOutlet weak var telefoneFuncionario: UILabel!
    @IBOutlet weak var emailFuncionario: UILabel!
    @IBOutlet weak var descricaoFuncionario: UITextView!
    
    var funcionario: Funcionario! = nil
    
    override func viewDidLoad() {
        
        self.imagemFuncionario.image = UIImage(data: funcionario.imageData)
        self.nomeFuncionario.text = funcionario.nome
        self.cargoFuncionario.text = funcionario.cargo
        self.nascimentoFuncionario.text = funcionario.nascimento
        self.telefoneFuncionario.text = funcionario.telefone
        self.emailFuncionario.text = funcionario.email
        self.descricaoFuncionario.text = funcionario.descricao
        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.clickTelefone))
        self.telefoneFuncionario.isUserInteractionEnabled = true
        self.telefoneFuncionario.addGestureRecognizer(tapGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.clickEmail))
        self.emailFuncionario.isUserInteractionEnabled = true
        self.emailFuncionario.addGestureRecognizer(tapGesture)
    }
    
    func clickTelefone(){
        
        guard let number = URL(string: "telprompt://"+funcionario.telefone) else {return}
        
        if UIApplication.shared.canOpenURL(number) {
            UIApplication.shared.openURL(number)
        } else {
            let alertaController = UIAlertController(title: "Alerta", message: "Numero Inválido", preferredStyle: .alert)
            
            let alertaConfirma = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertaController.addAction(alertaConfirma)
            
            present(alertaController, animated: true, completion: nil)
            
        }
    }
    
    func clickEmail() {
        
        let gerenciadorMail = MailController(view: self)
        
        gerenciadorMail.sendMail(email: funcionario.email)
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
