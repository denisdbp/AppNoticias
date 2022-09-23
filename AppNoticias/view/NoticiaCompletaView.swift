//
//  NoticiaCompletaView.swift
//  AppNoticias
//
//  Created by Admin on 21/09/22.
//

import UIKit
import WebKit

protocol NoticiaCompletaViewProtocol:AnyObject {
    func voltarTela()
}

class NoticiaCompletaView: UIView {
    
    private var delegate:NoticiaCompletaViewProtocol?
    
    public func delegate(delegate:NoticiaCompletaViewProtocol){
        self.delegate = delegate
    }
    
    lazy var buttonVoltar:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "seta-esquerda"), for: .normal)
        button.addTarget(self, action: #selector(self.voltarTela), for: .touchUpInside)
        return button
    }()
    
    lazy var noticiaWebView:WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubViews()
        self.configConstraintButtonVoltar()
        self.configConstraintNoticiaWebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func voltarTela(){
        self.delegate?.voltarTela()
    }
    
    private func addSubViews(){
        self.addSubview(self.buttonVoltar)
        self.addSubview(self.noticiaWebView)
    }
    
    private func configConstraintButtonVoltar(){
        NSLayoutConstraint.activate([
            self.buttonVoltar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.buttonVoltar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.buttonVoltar.widthAnchor.constraint(equalToConstant: 30),
            self.buttonVoltar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configConstraintNoticiaWebView(){
        NSLayoutConstraint.activate([
            self.noticiaWebView.topAnchor.constraint(equalTo: self.buttonVoltar.bottomAnchor, constant: 10),
            self.noticiaWebView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.noticiaWebView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.noticiaWebView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
