//
//  Data storage.swift
//  PPO
//
//  Created by  9r4ik on 25/03/2019.
//  Copyright © 2019 9r4. All rights reserved.
//


protocol  ListOfPlacesDataStorageHandlerProtocol {
    func dataDidUpdate()
    
}

protocol ListOfPlacesDataStorageProtocol {
    var handler: ListOfPlacesDataStorageHandlerProtocol? {get set}
    var places_array: [ListOfPlaces.PLaceModel] {get set}
    var displayed_places_array: [ListOfPlaces.PLaceModel] {get set}
}

class ListOfPlacesDataStorage: ListOfPlacesDataStorageProtocol {
    var handler: ListOfPlacesDataStorageHandlerProtocol?
    var places_array = [ListOfPlaces.PLaceModel]() { didSet { displayed_places_array = places_array } }
    var displayed_places_array = [ListOfPlaces.PLaceModel]() { didSet { handler?.dataDidUpdate() } }
}
