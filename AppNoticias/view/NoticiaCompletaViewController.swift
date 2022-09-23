//
//  NoticiaCompletaViewController.swift
//  AppNoticias
//
//  Created by Admin on 21/09/22.
//

import UIKit

class NoticiaCompletaViewController: UIViewController {
    
    private let noticiaCompletaView:NoticiaCompletaView = NoticiaCompletaView()
    public var urlNoticia:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticiaCompletaView.delegate(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.noticiaCompletaView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.carregaNoticia(url: self.urlNoticia ?? "")
    }
    
    private func carregaNoticia(url:String){
        guard let url = URL(string: url) else {return}
        self.noticiaCompletaView.noticiaWebView.load(URLRequest(url: url))
    }
}

extension NoticiaCompletaViewController:NoticiaCompletaViewProtocol {
    func voltarTela() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
