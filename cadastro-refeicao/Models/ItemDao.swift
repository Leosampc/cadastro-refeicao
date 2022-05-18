//
//  ItemDao.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 17/05/22.
//

import Foundation

class ItemDao {
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return diretorio.appendingPathComponent("itens")
    }
    
    func recupera() -> [Item] {
        guard let diretorio = recuperaDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: diretorio)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! [Item]
            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func salva(_ itens: [Item]) {
        guard let diretorio = recuperaDiretorio() else { return }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            try dados.write(to: diretorio)
        } catch {
            print(error.localizedDescription)
        }
    }
}
