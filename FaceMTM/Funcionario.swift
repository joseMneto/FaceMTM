//
//  Funcionario.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 02/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit

class Funcionario {
    var nome: String!
    var cargo: String!
    var imagem: UIImage!
    
    var telefone: String!
    var nascimento: String!
    var email: String!
    var descricao: String!
    
    init(nome: String, cargo: String, imagem: UIImage, telefone: String, nascimento: String, email: String, descricao: String) {
        self.nome = nome
        self.cargo = cargo
        self.imagem = imagem
        self.telefone = telefone
        self.nascimento = nascimento
        self.email = email
        self.descricao = descricao
    }
}
