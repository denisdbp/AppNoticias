//
//  NoticiasView.swift
//  AppNoticias
//
//  Created by Admin on 20/09/22.
//

import UIKit

class NoticiasView: UIView, UITextFieldDelegate {
    
    lazy var textFieldEscolhaNoticia:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .boldSystemFont(ofSize: 20)
        textField.backgroundColor = .systemRed
        textField.textColor = .white
        textField.textAlignment = .center
        textField.placeholder = "Qual tipo de noticia deseja ?"
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.escolherNoticia), for: .editingDidBegin)
        return textField
    }()
    
    lazy var pickerViewEscolhaNoticia:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    lazy var noticiasTableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NoticiasTableViewCell.self, forCellReuseIdentifier: NoticiasTableViewCell.identifier)
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubViews()
        self.configConstraintTextFieldEscolhaNoticia()
        self.configConstraintTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func escolherNoticia(){
        self.textFieldEscolhaNoticia.inputView = self.pickerViewEscolhaNoticia
    }
    
    public func configPickerViewDelegate(delegate:UIPickerViewDelegate, dataSource:UIPickerViewDataSource){
        self.pickerViewEscolhaNoticia.delegate = delegate
        self.pickerViewEscolhaNoticia.dataSource = dataSource
    }
    
    public func configTableViewDelegate(delegate:UITableViewDelegate, dataSource:UITableViewDataSource){
        self.noticiasTableView.delegate = delegate
        self.noticiasTableView.dataSource = dataSource
    }
    
    private func addSubViews(){
        self.addSubview(self.textFieldEscolhaNoticia)
        self.addSubview(self.noticiasTableView)
    }
    
    private func configConstraintTextFieldEscolhaNoticia(){
        NSLayoutConstraint.activate([
            self.textFieldEscolhaNoticia.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.textFieldEscolhaNoticia.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textFieldEscolhaNoticia.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textFieldEscolhaNoticia.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configConstraintTableView(){
        NSLayoutConstraint.activate([
            self.noticiasTableView.topAnchor.constraint(equalTo: self.textFieldEscolhaNoticia.bottomAnchor, constant: 5),
            self.noticiasTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.noticiasTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.noticiasTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
