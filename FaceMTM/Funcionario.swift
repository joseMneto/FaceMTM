//
//  Funcionario.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 02/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit
import Firebase

class Funcionario {
    var nome: String!
    var cargo: String!
    var imagem: UIImage!
    
    var telefone: String!
    var nascimento: String!
    var email: String!
    var descricao: String!
    
    init(snapshot: FIRDataSnapshot) {
        
        let key = snapshot.key
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.nome = key
        self.cargo = snapshotValue["Cargo"] as! String
        self.imagem = #imageLiteral(resourceName: "Apple_logo_black.svg")
        self.telefone = "71 999625707"
        self.nascimento = snapshotValue["Nascimento"] as! String
        self.email = "teste@email"
        self.descricao = "The best of the best"
    }
}
