//
//  LoginViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 05/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var senhaTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }

    @IBAction func realizarLogin() {
        
        if self.senhaTextField.text == "" {
            print("Erro Login")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: "dudu@gmail.com", password: self.senhaTextField.text!, completion: { (user, error) in
            
            if error != nil {
                print("Login Invalido")
                return
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: true, completion: nil)
            
            
            
        })
        
    }
    
    //Toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //esconde o teclado
        view.endEditing(true)
    }

}
