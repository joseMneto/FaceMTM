//
//  ListaFuncionariosViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 02/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit

class ListaFuncionariosViewController: UITableViewController {
    
    var telaEscolhida : String!
    
    var funcionariosLista : [Funcionario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = telaEscolhida
        
        var funcionario : Funcionario
        
        funcionario = Funcionario(nome: "Eduardo Lacerda", cargo: "Desenvolvedor Jr.", imagem: #imageLiteral(resourceName: "Apple_logo_black.svg"))
        funcionariosLista.append(funcionario)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcionariosLista.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let funcionario = funcionariosLista[indexPath.row]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "funcionariosCell", for: indexPath) as! FuncionarioCelula
        
        celula.imgFuncionarioCell.image = funcionario.imagem
        celula.nomeFuncionarioCell.text = funcionario.nome
        celula.cargoFuncionarioCell.text = funcionario.cargo
        
        return celula
    }
    
    
}
