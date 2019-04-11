//
//  ViewController.swift
//  PPO
//
//  Created by  9r4ik on 24/03/2019.
//  Copyright © 2019 9r4. All rights reserved.
//

import UIKit

class ListOfPlacesVC: UIViewController {
    @IBOutlet weak var _type_of_places_label: UILabel!
    @IBOutlet weak var _places_search_bar: UISearchBar!
    @IBOutlet weak var _places_coll_view: UICollectionView!
    
    private struct _constants {
        static let items_in_row: CGFloat = 1
        static let items_in_column: CGFloat = 5
        static let section_insets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0.0,
                                         right: 0.0)
    }
    
    fileprivate var _data_manager: DataManagerProtocol = DataManager()
    fileprivate var _data_storage: ListOfPlacesDataStorageProtocol = ListOfPlacesDataStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _places_coll_view.register(PlaceCollViewCell.nib, forCellWithReuseIdentifier: "Cell")
        _places_coll_view.delegate = self
        _places_coll_view.dataSource = self
        
        _data_storage.handler = self
        
        _type_of_places_label.text = "Музей"
        
        _places_search_bar.delegate = self
        _places_search_bar.showsCancelButton = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        _data_manager.receivePlaces(delegate: self)
    }
    
}

extension ListOfPlacesVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _places_search_bar.endEditing(true)
    }
}

extension ListOfPlacesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data_storage.displayed_places_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = _places_coll_view.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlaceCollViewCell else {
            return UICollectionViewCell()
        }
        
        cell.set(place: _data_storage.displayed_places_array[indexPath.row])
        return cell
        
    }
}

extension ListOfPlacesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width_per_item = collectionView.bounds.width / _constants.items_in_row
        let height_per_item = collectionView.bounds.height / _constants.items_in_column
        
        return CGSize(width: width_per_item, height: height_per_item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return _constants.section_insets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ListOfPlacesVC: DataManagerHandler {
    func didReciveError(error: DataManagerError) {
        print(error)
    }
    
    func didReceiveData(data: Any) {
        _data_storage.places_array = data as? [ListOfPlaces.PLaceModel] ?? []
    }
}

extension ListOfPlacesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let places_array = _data_storage.places_array
        let filtered_places_array = searchText.isEmpty ? places_array : places_array.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        _data_storage.displayed_places_array = filtered_places_array
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        _places_search_bar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        _places_search_bar.showsCancelButton = false
        _places_search_bar.text = nil
        _places_search_bar.delegate!.searchBar!(_places_search_bar, textDidChange: "")
        _places_search_bar.endEditing(true)
    }
}

extension ListOfPlacesVC: ListOfPlacesDataStorageHandlerProtocol {
    func dataDidUpdate() {
        _places_coll_view.reloadData()
    }
}

