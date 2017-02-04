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
        
        funcionario = Funcionario(nome: "Eduardo Lacerda", cargo: "Desenvolvedor Jr.", imagem: #imageLiteral(resourceName: "Apple_logo_black.svg"), telefone: "71999625707", nascimento: "29.05.1986", email: "dudu.lacerda@gmail.com", descricao: "Apaixonado por tecnologia, ciclista nas horas livres, curioso com as surpresas e maravilhas da ciência. Objetivo seguir a carreira de desenvolvimento de software mobile e Internet das Coisas, criando e desenvolvendo sistemas e dispositivos para ajudar pessoas.")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheFuncionario" {
            let viewDestino = segue.destination as! DetalheFuncionarioViewController
            
            if let funcionarioSelecionado = self.tableView.indexPathForSelectedRow {
                viewDestino.funcionario = funcionariosLista[funcionarioSelecionado.row]
            }
        }
    }
    
    
}
