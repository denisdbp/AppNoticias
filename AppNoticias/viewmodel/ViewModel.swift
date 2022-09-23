//
//  ViewModel.swift
//  AppNoticias
//
//  Created by Admin on 20/09/22.
//

import Foundation

class ViewModel {
    
    public var model:[NoticiasModel] = []
    public var xmlStrings:String?
    public var noticiaAtual:NoticiasModel?
    public let escolhaNoticia:[String] = ["Todas as notícias", "Brasil", "Carros(Autoesporte.com)", "Ciência e Saúde", "Concursos e Emprego", "Economia", "Educação", "Loterias", "Mundo", "Música", "Natureza", "Planeta Bizarro", "Política", "Pop & Arte", "Tecnologia e Games", "Turismo e Viagem"]
    
    //MARK: Buscar o indice da tabela de noticias
    public func getIndexPath(indexPath:IndexPath)->NoticiasModel{
        self.model[indexPath.row]
    }
    
    //MARK: Verificar noticia atual
    public func verificaNoticiaAtual(){
        self.noticiaAtual = NoticiasModel()
    }
    
    //MARK: Adicionar noticia atual
    public func adicionaNoticiaAtual(){
        if let noticiaAtual = noticiaAtual {
            self.model.append(noticiaAtual)
        }
    }

    //MARK: Buscar imagem na internet
    public func getImagemNoticia(indexPath:IndexPath)->Data?{
        guard let url = URL(string: self.getIndexPath(indexPath: indexPath).imagemNoticia) else {return nil}
        do{
        let data = try Data(contentsOf: url)
            return data
        }catch{
            
        }
        return nil
    }
}
