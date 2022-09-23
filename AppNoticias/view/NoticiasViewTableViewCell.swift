//
//  NoticiasViewTableViewCell.swift
//  AppNoticias
//
//  Created by Admin on 22/09/22.
//

import UIKit

protocol NoticiasViewTableViewCellProtocol:AnyObject {
    func lerMaisNoticia()
}

class NoticiasViewTableViewCell: UIView {
    
    private var delegate:NoticiasViewTableViewCellProtocol?
    
    public func delegate(delegate:NoticiasViewTableViewCellProtocol) {
        self.delegate = delegate
    }
    
    lazy var imageNoticias:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var labelDataNoticias:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelTituloNoticias:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var labelDescricaoNoticias:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    lazy var buttonLerMais:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ler mais...", for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.lerMaisNoticia), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.configConstraintImageNoticias()
        self.configConstraintLabelDataNoticias()
        self.configConstraintLabelTituloNoticias()
        self.configConstraintLabelDescricaoNoticias()
        self.configConstraintButtonLerMais()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func lerMaisNoticia(){
        self.delegate?.lerMaisNoticia()
    }
    
    private func addSubViews(){
        self.addSubview(self.imageNoticias)
        self.addSubview(self.labelDataNoticias)
        self.addSubview(self.labelTituloNoticias)
        self.addSubview(self.labelDescricaoNoticias)
        self.addSubview(self.buttonLerMais)
    }
    
    private func configConstraintImageNoticias(){
        NSLayoutConstraint.activate([
            self.imageNoticias.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageNoticias.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageNoticias.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageNoticias.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func configConstraintLabelDataNoticias(){
        NSLayoutConstraint.activate([
            self.labelDataNoticias.topAnchor.constraint(equalTo: self.imageNoticias.bottomAnchor, constant: 10),
            self.labelDataNoticias.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func configConstraintLabelTituloNoticias(){
        NSLayoutConstraint.activate([
            self.labelTituloNoticias.topAnchor.constraint(equalTo: self.labelDataNoticias.bottomAnchor, constant: 10),
            self.labelTituloNoticias.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.labelTituloNoticias.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func configConstraintLabelDescricaoNoticias(){
        NSLayoutConstraint.activate([
            self.labelDescricaoNoticias.topAnchor.constraint(equalTo: self.labelTituloNoticias.bottomAnchor, constant: 10),
            self.labelDescricaoNoticias.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.labelDescricaoNoticias.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ])
    }
    
    private func configConstraintButtonLerMais(){
        NSLayoutConstraint.activate([
            self.buttonLerMais.topAnchor.constraint(equalTo: self.labelDescricaoNoticias.bottomAnchor, constant: 5),
            self.buttonLerMais.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.buttonLerMais.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
