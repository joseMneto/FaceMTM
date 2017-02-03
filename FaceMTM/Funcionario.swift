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
    
    init(nome: String, cargo: String, imagem: UIImage) {
        self.nome = nome
        self.cargo = cargo
        self.imagem = imagem
    }
}
