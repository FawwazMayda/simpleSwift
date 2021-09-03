//
//  SimpleSwiftView.swift
//  simpleSwift
//
//  Created by Muhammad Fawwaz Mayda on 03/09/21.
//

import UIKit

protocol SimpleSwiftViewDelegate {
    func didTappedTableView(at position: IndexPath)
    func didTappedCollectionView(at position: IndexPath)
}

class SimpleSwiftView: UIView {
    
    let interSpace: CGFloat = 30.0
    let collectionHeight: CGFloat = 180.0
    let tableHeight: CGFloat = 280.0
    
    var delegate: SimpleSwiftViewDelegate?
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    
        setupUI()
        setupConstraint()
    }
    
    func setupUI() {
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: interSpace),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: interSpace),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -interSpace),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: interSpace),
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: interSpace),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -interSpace),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -interSpace)
        
        ])
    }
}

extension SimpleSwiftView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTappedTableView(at: indexPath)
    }
}

extension SimpleSwiftView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedCollectionView(at: indexPath)
    }
}
