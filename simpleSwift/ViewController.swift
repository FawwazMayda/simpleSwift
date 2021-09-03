//
//  ViewController.swift
//  simpleSwift
//
//  Created by Muhammad Fawwaz Mayda on 03/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    var contentView = SimpleSwiftView()
    var viewModel: SimpleSwiftViewModel = SimpleSwiftViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.frame = self.view.frame
        self.view = contentView
        setup()
    }
    
    func setup() {
        viewModel.delegate = self
        contentView.delegate = self
        contentView.tableView.dataSource = viewModel.tableDataSource
        contentView.collectionView.dataSource = viewModel.collectionDataSource
    }

}

extension ViewController: SimpleSwiftViewDelegate {
    func didTappedTableView(at position: IndexPath) {
        viewModel.updateTableEntry(at: position.row)
    }
    
    func didTappedCollectionView(at position: IndexPath) {
        viewModel.updateCollectionColor(at: position.row)
    }
}

extension ViewController: SimpleViewViewModelDelegate {
    func needUpdateTableViewElement(at position: Int) {
        DispatchQueue.main.async {
            self.contentView.tableView.reloadRows(at: [IndexPath(row: position, section: 0)], with: .automatic)
        }
    }
    
    func needCollectionViewElement(at position: Int) {
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadItems(at: [IndexPath(item: position, section: 0)])
        }
    }
}

