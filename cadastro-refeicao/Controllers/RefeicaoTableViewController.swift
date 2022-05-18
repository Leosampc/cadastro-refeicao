//
//  RefeicaoTableViewController.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 12/04/22.
//

import UIKit

class RefeicaoTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    // MARK: - Atributos
    
    var refeicoes: Array<Refeicao> = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        refeicoes = RefeicaoDao().recupera()
    }
    
    // MARK: - UITableViewController
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao: Refeicao = refeicoes[indexPath.row]
        
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
                RefeicaoDao().salva(self.refeicoes)
            })
        }
    }
    
    // MARK: - AdicionaRefeicaoDelegate
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        
        RefeicaoDao().salva(refeicoes)
    }
    
    // MARK: - NavigationController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
