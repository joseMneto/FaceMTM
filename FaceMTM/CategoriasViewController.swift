//
//  ViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 01/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit

class CategoriasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewControllerDestino = segue.destination as! ListaFuncionariosViewController
        
        if let nomeTela = segue.identifier {
            switch nomeTela {
            case "ios":
                viewControllerDestino.telaEscolhida = "iOS Devs"
            case "android":
                viewControllerDestino.telaEscolhida = "Android Devs"
            case "xamarim":
                viewControllerDestino.telaEscolhida = "Xamarim Devs"
            case "cordova":
                viewControllerDestino.telaEscolhida = "Cordova Devs"
            default:
                return
            }
        }
    }

}

