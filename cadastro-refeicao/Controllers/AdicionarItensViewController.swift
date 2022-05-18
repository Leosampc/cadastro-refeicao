//
//  AdicionarItensViewController.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 15/05/22.
//

import UIKit

protocol AdicionarItensDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    // MARK: - Atributos
    
    var delegate: AdicionarItensDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(delegate: AdicionarItensDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text else { return }
        if let numeroDeCalorias = Double(calorias) {
            let item = Item(nome: nome, calorias: numeroDeCalorias)
            delegate?.add(item)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
