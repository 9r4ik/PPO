//
//  Data Manager.swift
//  PPO
//
//  Created by  9r4ik on 25/03/2019.
//  Copyright © 2019 9r4. All rights reserved.
//

enum DataManagerError: CustomStringConvertible {
    case internet
    
    var description: String {
        switch self {
        
        case .internet:
            return "Проблемы с интернетом"
        }
    }
}

protocol DataManagerHandler {
    func didReceiveData(data: Any)
    func didReciveError(error: DataManagerError)
}

protocol DataManagerProtocol {
    func receivePlaces(delegate: DataManagerHandler)
}

class DataManager: DataManagerProtocol {
    func receivePlaces(delegate: DataManagerHandler) {
        delegate.didReceiveData(data: [ListOfPlaces.PLaceModel(name: "театр", address: "Свобода", url_string: "name_1", popular: 1),
                                       ListOfPlaces.PLaceModel(name: "планетарий", address: "Бауманская", url_string: "name_2", popular: 2),
                                       ListOfPlaces.PLaceModel(name: "кафе", address: "Кольцевая", url_string: "name_3", popular: 3),
                                       ListOfPlaces.PLaceModel(name: "кафе", address: "Арбат", url_string: "name_4", popular: 4),
                                       ListOfPlaces.PLaceModel(name: "театр", address: "Углическая", url_string: "name_5", popular: 5),
                                       ListOfPlaces.PLaceModel(name: "университет", address: "Буракова", url_string: "name_6", popular: 6),
                                       ListOfPlaces.PLaceModel(name: "планетарий", address: "Золотая", url_string: "name_7", popular: 7),
                                       ListOfPlaces.PLaceModel(name: "акропль", address: "Буденого", url_string: "name_8", popular: 8),
                                       ListOfPlaces.PLaceModel(name: "гум", address: "Парковая", url_string: "name_9", popular: 9),
                                       ListOfPlaces.PLaceModel(name: "цдм", address: "Арбат", url_string: "name_10", popular: 10),
                                       ListOfPlaces.PLaceModel(name: "памятник", address: "Бауманская", url_string: "name_11", popular: 11),
                                       ListOfPlaces.PLaceModel(name: "скульптура", address: "Свобода", url_string: "name_12", popular: 12),])
//        delegate.didReciveError(error: .internet)
    }
}
