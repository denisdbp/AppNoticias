//
//  ViewController.swift
//  AppNoticias
//
//  Created by Admin on 20/09/22.
//

import UIKit

class NoticiasViewController: UIViewController {
    
    private let noticiasView:NoticiasView = NoticiasView()
    private let noticiaCompletaViewController:NoticiaCompletaViewController = NoticiaCompletaViewController()
    private let viewModel:ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticiasView.configPickerViewDelegate(delegate: self, dataSource: self)
        self.noticiasView.configTableViewDelegate(delegate: self, dataSource: self)
        self.parseXML(url: "https://g1.globo.com/rss/g1/")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.noticiasView
    }
    
    //MARK: Busca a XML de noticias na internet
    private func parseXML(url:String){
        self.viewModel.model = []
        let indexPath = IndexPath(row: 0, section: 0)
        guard let url = URL(string: url) else {return}
        let xmlParse = XMLParser(contentsOf: url)
        xmlParse?.delegate = self
        xmlParse?.parse()
        self.noticiasView.noticiasTableView.reloadData()
        self.noticiasView.noticiasTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension NoticiasViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticiasTableViewCell.identifier, for: indexPath) as? NoticiasTableViewCell
        if let image = self.viewModel.getImagemNoticia(indexPath: indexPath){
            cell?.noticiasViewTableViewCell.imageNoticias.image = UIImage(data: image)
        }else {
            cell?.noticiasViewTableViewCell.imageNoticias.image = UIImage(named: "sem-imagem")
        }
        cell?.noticiasViewTableViewCell.labelDataNoticias.text = self.viewModel.getIndexPath(indexPath: indexPath).dataNoticia
        cell?.noticiasViewTableViewCell.labelTituloNoticias.text = self.viewModel.getIndexPath(indexPath: indexPath).tituloNoticia
        cell?.noticiasViewTableViewCell.labelDescricaoNoticias.text = "\(self.viewModel.getIndexPath(indexPath: indexPath).descricaoNoticia)"
        cell?.configCell(model: self.viewModel.getIndexPath(indexPath: indexPath))
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
}

extension NoticiasViewController:XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.viewModel.xmlStrings = ""
        switch elementName {
        case "item":
            self.viewModel.verificaNoticiaAtual()
        case "media:content":
            self.viewModel.noticiaAtual?.imagemNoticia = attributeDict["url"] ?? ""
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title":
            self.viewModel.noticiaAtual?.tituloNoticia = self.viewModel.xmlStrings?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case "link":
            self.viewModel.noticiaAtual?.link = self.viewModel.xmlStrings?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case "description":
            let description = self.viewModel.xmlStrings?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            self.viewModel.noticiaAtual?.descricaoNoticia = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        case "pubDate":
            self.viewModel.noticiaAtual?.dataNoticia = self.viewModel.xmlStrings?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        case "item":
            self.viewModel.adicionaNoticiaAtual()
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.viewModel.xmlStrings! += string
    }
}

extension NoticiasViewController:NoticiasTableViewCellProtocol {
    func lerMaisNoticia(model: NoticiasModel) {
        self.navigationController?.pushViewController(self.noticiaCompletaViewController, animated: true)
        self.noticiaCompletaViewController.urlNoticia = model.link
    }
}

extension NoticiasViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.escolhaNoticia.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.escolhaNoticia[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.viewModel.escolhaNoticia[row] {
        case "Todas as notícias" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Brasil" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/brasil/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Carros(Autoesporte.com)" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/carros/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Ciência e Saúde" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/ciencia-e-saude/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Concursos e Emprego" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/concursos-e-emprego/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Economia" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/economia/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Educação" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/educacao/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Loterias" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/loterias/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Mundo" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/mundo/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Música" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/musica/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Natureza" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/natureza/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Planeta Bizarro" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/planeta-bizarro/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Política" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/politica/mensalao/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Pop & Arte" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/pop-arte/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Tecnologia e Games" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/tecnologia/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        case "Turismo e Viagem" :
            self.parseXML(url: "https://g1.globo.com/rss/g1/turismo-e-viagem/")
            self.noticiasView.textFieldEscolhaNoticia.text = self.viewModel.escolhaNoticia[row]
            self.noticiasView.textFieldEscolhaNoticia.endEditing(true)
        default:
            break
        }
    }
}
