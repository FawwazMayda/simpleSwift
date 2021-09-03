//
//  SimpleSwiftViewModel.swift
//  simpleSwift
//
//  Created by Muhammad Fawwaz Mayda on 03/09/21.
//

import UIKit

protocol SimpleViewViewModelDelegate {
    func needUpdateTableViewElement(at position: Int)
    func needCollectionViewElement(at position: Int)
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    internal var colorArray: [UIColor] = []
    
    init(itemCount: Int) {
        for _ in 0...itemCount {
            let hue = CGFloat( Double(arc4random() % 256) / 256.0 );  //  0.0 to 1.0
            let saturation = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
            let brightness = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
            let newColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            colorArray.append(newColor)
        }
    }
    
    func newColor(at: Int) {
        let hue = CGFloat( Double(arc4random() % 256) / 256.0 );  //  0.0 to 1.0
        let saturation = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        let brightness = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        let newColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        colorArray[at] = newColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colorArray[indexPath.row]
        cell.layer.cornerRadius = 8.0
        return cell
    }
}

class TableViewDataSource: NSObject, UITableViewDataSource {
    internal var letterArray: [String] = []
    
    init(itemCount: Int) {
        for _ in 0...itemCount {
            letterArray.append("Country: #\(Int.random(in: 1...500))")
        }
    }
    
    func newEntry(at: Int) {
        letterArray[at] = "Country: #\(Int.random(in: 1...500))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = letterArray[indexPath.row]
        return cell
    }
}

class SimpleSwiftViewModel {
    
    var collectionDataSource = CollectionViewDataSource(itemCount: Int.random(in: 10...30))
    var tableDataSource = TableViewDataSource(itemCount: Int.random(in: 30...50))
    
    var delegate: SimpleViewViewModelDelegate?
    
    func updateTableEntry(at position: Int) {
        tableDataSource.newEntry(at: position)
        delegate?.needUpdateTableViewElement(at: position)
    }
    
    func updateCollectionColor(at position: Int) {
        collectionDataSource.newColor(at: position)
        delegate?.needCollectionViewElement(at: position)
    }
}
