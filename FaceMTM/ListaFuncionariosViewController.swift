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
    
    let storage = FIRStorage.storage()
    
    var cache: NSCache <AnyObject, AnyObject>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = telaEscolhida
        
        self.cache = NSCache()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let noFuncionarios = firebase.child(telaEscolhida)
        carregarDadosFirebase(noFuncionarios)
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
        
        if funcionario.imagemUrl != "" {
            
            //Verifica se exite imagem em cache
            if let imagem = cache.object(forKey: indexPath.row as AnyObject) {
                celula.imgFuncionarioCell.image = (imagem as! UIImage)
                funcionario.imagem = (imagem as! UIImage)
            } else {
                
                let imageRef = storage.reference(forURL: funcionario.imagemUrl!)
                
                imageRef.downloadURL { (url, error) in
                    if (error != nil){
                        print(error!)
                        return
                    }
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if (error != nil){
                            print(error!)
                            return
                        }
                        
                        DispatchQueue.main.async(execute: {() -> Void in
                            funcionario.imagem = UIImage(data: data!)
                            celula.imgFuncionarioCell.image = funcionario.imagem
                            self.cache.setObject(funcionario.imagem, forKey: indexPath.row as AnyObject)
                        })
                    }).resume()
                }
            }// Else teste cache
        }// Fim caso exista imagemURL no obejto funcionario
        
        return celula
        
    }
    
    func carregarDadosFirebase(_ nofuncionarios: FIRDatabaseReference) {
        
        
        nofuncionarios.observe(FIRDataEventType.value, with: { (dados) in
            
            var listaFuncionarios: [Funcionario] = []
            
            for node in dados.children {
                
                let funcionario = Funcionario(snapshot: node as! FIRDataSnapshot)
                listaFuncionarios.append(funcionario)
            }
            
            self.funcionariosLista = listaFuncionarios
            self.tableView.reloadData()
        })
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
