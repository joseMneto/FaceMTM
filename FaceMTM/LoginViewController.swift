//
//  LoginViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 05/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginViewController: UIViewController , FBSDKLoginButtonDelegate{
    
    
    @IBOutlet weak var senhaTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
        
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
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("FaceBook logout")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("Erro Login Facebook")
            return
        }
        
        if result.isCancelled != true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: true, completion: nil)
        }
    
    }
    
    //Toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //esconde o teclado
        view.endEditing(true)
    }

}
