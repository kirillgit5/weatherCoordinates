//
//  WeatherTableViewCell.swift
//  weatherCoordinates
//
//  Created by Кирилл Крамар on 21.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }
    
    //MARK : - IB Outlets
    @IBOutlet var weatherCollectionView: UICollectionView!
    
    //MARK : - Private Property
    private var weathers = [WeatherModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherCollectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifire)
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
    }
    
    //MARK : - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //   print("\(weathers.count)--")
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifire,
                                                      for: indexPath) as! WeatherCollectionViewCell
        //print("item --\(indexPath.item)")
        cell.configure(with: weathers[indexPath.item])
        return cell
        
    }
    
    //MARK : - CollectionViewFlowDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 114, height: 150)
    }
    
    //MARK : - Public Methods
    func configure(with weathers: [WeatherModel]) {
        self.weathers = weathers
        weatherCollectionView.reloadData()
    }
    
}


