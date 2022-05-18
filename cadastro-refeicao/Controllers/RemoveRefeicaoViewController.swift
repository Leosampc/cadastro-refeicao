//
//  RemoveRefeicaoViewController.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 16/05/22.
//

import UIKit

class RemoveRefeicaoViewController {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let botaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alerta.addAction(botaoCancelar)
        
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true)
    }
}
