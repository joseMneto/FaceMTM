//
//  ListaFuncionariosViewController.swift
//  FaceMTM
//
//  Created by Eduardo Lacerda on 02/02/17.
//  Copyright © 2017 Eduardo Lacerda. All rights reserved.
//

import UIKit
import Firebase

class ListaFuncionariosViewController: UITableViewController {
    
    var telaEscolhida : String!
    
    var funcionariosLista : [Funcionario] = []
    
    let firebase = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = telaEscolhida
        
        let noFuncionarios = firebase.child("iOS")
        
        noFuncionarios.observe(FIRDataEventType.value, with: { (dados) in
            
            var listaFuncionarios: [Funcionario] = []
            
            for node in dados.children {
                
                let funcionario = Funcionario(snapshot: node as! FIRDataSnapshot)
                listaFuncionarios.append(funcionario)
                print(funcionario.nome)
            }
            
            self.funcionariosLista = listaFuncionarios
            self.tableView.reloadData()
        })
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
