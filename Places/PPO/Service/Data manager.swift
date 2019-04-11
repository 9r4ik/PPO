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
        delegate.didReceiveData(data: [ListOfPlaces.PLaceModel(name: "name_1", url_string: "name_1"),
                                       ListOfPlaces.PLaceModel(name: "name_2", url_string: "name_2"),
                                       ListOfPlaces.PLaceModel(name: "name_3", url_string: "name_3"),
                                       ListOfPlaces.PLaceModel(name: "name_4", url_string: "name_4"),
                                       ListOfPlaces.PLaceModel(name: "name_5", url_string: "name_5"),
                                       ListOfPlaces.PLaceModel(name: "name_6", url_string: "name_6"),
                                       ListOfPlaces.PLaceModel(name: "name_7", url_string: "name_7"),
                                       ListOfPlaces.PLaceModel(name: "name_8", url_string: "name_8"),
                                       ListOfPlaces.PLaceModel(name: "name_9", url_string: "name_9"),
                                       ListOfPlaces.PLaceModel(name: "name_10", url_string: "name_10"),
                                       ListOfPlaces.PLaceModel(name: "name_11", url_string: "name_11"),
                                       ListOfPlaces.PLaceModel(name: "name_12", url_string: "name_12"),])
    }
}
