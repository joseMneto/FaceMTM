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
    var imagemUrl: String!
    var imageData: Data!
    
    var telefone: String!
    var nascimento: String!
    var email: String!
    var descricao: String!
    
    init(snapshot: FIRDataSnapshot) {
        
        let key = snapshot.key
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.nome = key
        self.cargo = snapshotValue["Cargo"] as! String
        self.imagemUrl = snapshotValue["Imagem"] as! String
        self.telefone = snapshotValue["Telefone"] as! String
        self.nascimento = snapshotValue["Nascimento"] as! String
        self.email = snapshotValue["Email"] as! String
        self.descricao = snapshotValue["Descricao"] as! String
    }
}
