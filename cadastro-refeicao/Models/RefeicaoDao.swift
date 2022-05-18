//
//  RefeicaoDao.swift
//  cadastro-refeicao
//
//  Created by Leonardo Cruz on 17/05/22.
//

import Foundation

class RefeicaoDao {
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return diretorio.appendingPathComponent("refeicao")
    }
    
    func recupera() -> [Refeicao] {
        guard let diretorio = recuperaDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: diretorio)
            let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Refeicao>
            return refeicoesSalvas
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func salva(_ refeicoes: [Refeicao]) {
        guard let diretorio = recuperaDiretorio() else { return }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: diretorio)
        } catch {
            print(error.localizedDescription)
        }
    }
}
