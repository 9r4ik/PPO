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
        delegate.didReceiveData(data: [ListOfPlaces.PLaceModel(name: "театр", billing: "Свобода", url_string: "name_1"),
                                       ListOfPlaces.PLaceModel(name: "планетарий", billing: "Бауманская", url_string: "name_2"),
                                       ListOfPlaces.PLaceModel(name: "кафе", billing: "Кольцевая", url_string: "name_3"),
                                       ListOfPlaces.PLaceModel(name: "кафе", billing: "Арбат", url_string: "name_4"),
                                       ListOfPlaces.PLaceModel(name: "театр", billing: "Углическая", url_string: "name_5"),
                                       ListOfPlaces.PLaceModel(name: "университет", billing: "Буракова", url_string: "name_6"),
                                       ListOfPlaces.PLaceModel(name: "планетарий", billing: "Золотая", url_string: "name_7"),
                                       ListOfPlaces.PLaceModel(name: "акропль", billing: "Буденого", url_string: "name_8"),
                                       ListOfPlaces.PLaceModel(name: "гум", billing: "Парковая", url_string: "name_9"),
                                       ListOfPlaces.PLaceModel(name: "цдм", billing: "Арбат", url_string: "name_10"),
                                       ListOfPlaces.PLaceModel(name: "памятник", billing: "Бауманская", url_string: "name_11"),
                                       ListOfPlaces.PLaceModel(name: "скульптура", billing: "Свобода", url_string: "name_12"),])
    }
}
