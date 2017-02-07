//
//  Usuario.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 07/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import Foundation

class Usuario {
    let email: String!
    let senha: String!
    let telefone: String!
    let cpf: String!
    
    init(email: String, senha: String, telefone: String, cpf: String) {
        self.email = email
        self.senha = senha
        self.telefone = telefone
        self.cpf = cpf
    }
}
