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


class LoginViewController: UIViewController , FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate{
    
    
    @IBOutlet weak var senhaTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook Login
        let loginButtonFB = FBSDKLoginButton()
        view.addSubview(loginButtonFB)
        loginButtonFB.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButtonFB.delegate = self
        
        
        //Google Login
        
        let loginButtonGG = GIDSignInButton()
        view.addSubview(loginButtonGG)
        loginButtonGG.frame = CGRect(x: 16, y: 100, width: view.frame.width - 32, height: 50)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    // MARK: Email Login

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
            
            self.goToHomeView()
            
        })
        
    }
    
    // MARK: Facebook Login
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("FaceBook logout")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("Erro Login Facebook")
            return
        }
        
        if result.isCancelled != true {
            goToHomeView()
        }
        
    }
    
    // MARK: Google Login
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print("Error Login Google")
            return
        }
        
        goToHomeView()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Log off Google")
    }
    
    func goToHomeView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.present(vc!, animated: true, completion: nil)
    }
    
    //Toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //esconde o teclado
        view.endEditing(true)
    }

}
