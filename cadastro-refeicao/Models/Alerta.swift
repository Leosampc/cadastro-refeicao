//
//  Alerta.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 16/05/22.
//

import UIKit

class Alerta {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(titulo: String = "Atenção", mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botaoOk = UIAlertAction(title: "Ok", style: .cancel)
        alerta.addAction(botaoOk)
        controller.present(alerta, animated: true)
    }
}
