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
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configura Facebook Login
        let loginButtonFB = FBSDKLoginButton()
        view.addSubview(loginButtonFB)
        loginButtonFB.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButtonFB.delegate = self
        
        
        //Configura Google Login
        let loginButtonGG = GIDSignInButton()
        view.addSubview(loginButtonGG)
        loginButtonGG.frame = CGRect(x: 16, y: 100, width: view.frame.width - 32, height: 50)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        // Verifica se o usuario estar logado.
        if FIRAuth.auth()?.currentUser != nil {
            goToHomeView()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    // MARK: Email Login

    @IBAction func realizarLogin() {
        
        if self.senhaTextField.text == "" {
            let alert = Alert(controller: self)
            alert.show(message: "Favor digitar uma senha!")
            return
        }
        
        if self.emailTextField.text == "" {
            let alert = Alert(controller: self)
            alert.show(message: "Favor digitar um email!")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.senhaTextField.text!, completion: { (user, error) in
            
            if error != nil {
                let alert = Alert.init(controller: self)
                alert.show(message: error!.localizedDescription)
                self.senhaTextField.text = ""
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
            let alert = Alert(controller: self)
            alert.show(message: error.localizedDescription)
            return
        }
        
        if result.isCancelled != true {
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
                if error != nil {
                    let alert = Alert.init(controller: self)
                    alert.show(message: error!.localizedDescription)
                    self.senhaTextField.text = ""
                    return
                }
                
                self.goToHomeView()
            })
        }
        
    }
    
    // MARK: Google Login
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print("Error Login Google")
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                let alert = Alert.init(controller: self)
                alert.show(message: error!.localizedDescription)
                self.senhaTextField.text = ""
                return
            }
            
            self.goToHomeView()
        })
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
