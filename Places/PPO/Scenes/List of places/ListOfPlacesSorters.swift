//
//  ListOfPlacesSorter.swift
//  PPO
//
//  Created by  9r4ik on 22/04/2019.
//  Copyright © 2019 9r4. All rights reserved.
//


class SorterCamerasList {
    static func AlphabetSortArray(this: ListOfPlaces.PLaceModel, that: ListOfPlaces.PLaceModel) -> Bool {
        let value = this.displayed_name < that.displayed_name
        return value
    }
    
    static func PopularSortArray(this: ListOfPlaces.PLaceModel, that: ListOfPlaces.PLaceModel) -> Bool {
        let value = this.popular < that.popular
        return value
    }
}
