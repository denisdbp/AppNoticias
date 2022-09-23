//
//  NoticiasTableViewCell.swift
//  AppNoticias
//
//  Created by Admin on 20/09/22.
//

import UIKit

protocol NoticiasTableViewCellProtocol:AnyObject {
    func lerMaisNoticia(model:NoticiasModel)
}

class NoticiasTableViewCell: UITableViewCell {
    
    private var delegate:NoticiasTableViewCellProtocol?
    
    public func delegate(delegate:NoticiasTableViewCellProtocol) {
        self.delegate = delegate
    }

    static let identifier:String = "NoticiasTableViewCell"
    private var viewModel:ViewModelCell?
    
    lazy var noticiasViewTableViewCell:NoticiasViewTableViewCell = {
        let view = NoticiasViewTableViewCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubViews()
        self.configConstraintNoticiasViewTableViewCell()
        self.noticiasViewTableViewCell.delegate(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Inicia a ViewModel com a noticia atual a cada Scroll que faz na tabela de noticias
    public func configCell(model:NoticiasModel){
        self.viewModel = ViewModelCell(model: model)
    }
    
    private func addSubViews(){
        self.contentView.addSubview(self.noticiasViewTableViewCell)
    }
    
    private func configConstraintNoticiasViewTableViewCell(){
        NSLayoutConstraint.activate([
            self.noticiasViewTableViewCell.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.noticiasViewTableViewCell.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.noticiasViewTableViewCell.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.noticiasViewTableViewCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension NoticiasTableViewCell:NoticiasViewTableViewCellProtocol {
    func lerMaisNoticia() {
        guard let model = self.viewModel?.model else {return}
        self.delegate?.lerMaisNoticia(model: model)
    }
}
