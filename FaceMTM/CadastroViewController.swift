//
//  CadastroViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 07/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var senhaText: UITextField!
    @IBOutlet weak var telefoneText: UITextField!
    @IBOutlet weak var cpfText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cadastrarUsuario() {
        
        let alerta = Alert.init(controller: self)
        
        if emailText.text == nil {
            alerta.show(message: "Por Favor digitar um Email.")
        }
        
        if senhaText.text == nil {
            alerta.show(message: "Por Favor digitar uma Senha.")
        }
        
        if  telefoneText.text == nil {
            alerta.show(message: "Por Favor digitar um Telefone.")
        }
        
        if cpfText.text == nil {
            alerta.show(message: "Por favor digitar um CPF")
        }
        
        let usuario = Usuario.init(email: emailText.text!, senha: senhaText.text!, telefone: telefoneText.text!, cpf: cpfText.text!)
        
        realizarLogin(usuario: usuario)
        
        
    }
    
    func realizarLogin(usuario: Usuario) {
        
        FIRAuth.auth()?.createUser(withEmail: usuario.email, password: usuario.senha, completion: { (user, error) in
            
            if error != nil {
                let alerta = Alert.init(controller: self)
                alerta.show(message: error!.localizedDescription)
                return
            }
            
            let firebase = FIRDatabase.database().reference().child("usuarios")
            
            firebase.child(usuario.cpf).setValue(["email":usuario.email, "telefone":usuario.telefone])
            
            self.dismiss(animated: false, completion: nil)
            
        })
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)

    }
    
    //Toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //esconde o teclado
        view.endEditing(true)
    }
    
    

}
