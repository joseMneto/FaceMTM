//
//  Alert.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 05/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    let controller : UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        
        controller.present(alert, animated:  true, completion: nil)
    }
}
