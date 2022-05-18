//
//  ViewController.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 11/04/22.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItensDelegate {
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
    var itens: [Item] = [
        Item(nome: "Molho de Tomate", calorias: 40.0),
        Item(nome: "Queijo", calorias: 40.0),
        Item(nome: "Molho Apimentado", calorias: 40.0),
        Item(nome: "Manjericão", calorias: 40.0)
    ]
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet weak var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: - Métodos
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nome = nomeTextField?.text else {
            return nil
        }
        guard let felicidadeText = felicidadeTextField?.text, let felicidade = Int(felicidadeText) else {
            return nil
        }
        
        return Refeicao(nome: nome, felicidade: felicidade, itens: itensSelecionados)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        let botaoAdicionarItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
        
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTableView?.reloadData()
        ItemDao().salva(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibe(titulo: "Desculpe", mensagem: "Não foi possível atualizar a tabela")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]
        
        celula.textLabel?.text = item.nome
        
        return celula
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        let item = itens[indexPath.row]
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            itensSelecionados.append(item)
        } else {
            celula.accessoryType = .none
            if let posicao = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: posicao)
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar(_ sender: Any) {
        if let refeicao = recuperaRefeicaoDoFormulario() {
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulário")
        }
    }
}

