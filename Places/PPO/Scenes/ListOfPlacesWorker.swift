protocol FilterCamerasArray {
    func filterArray(original_array: [ListOfPlaces.PLaceModel], search_text: String) -> [ListOfPlaces.PLaceModel]
     func sortArray(original_array: [ListOfPlaces.PLaceModel], SortersType: ListOfPlaces.SortersType) -> [ListOfPlaces.PLaceModel]
}

class ListOfPlacesWorker: FilterCamerasArray
{
    
    func filterArray(original_array: [ListOfPlaces.PLaceModel], search_text: String) -> [ListOfPlaces.PLaceModel] {
        return search_text.isEmpty ? original_array : original_array.filter {
            $0.displayed_name.lowercased().contains(search_text.lowercased())
        }
    }
    
    func alphavitSorter(this: ListOfPlaces.PLaceModel, that: ListOfPlaces.PLaceModel) -> Bool {
        return this.displayed_name > that.displayed_name
    }
    
    func sortArray(original_array: [ListOfPlaces.PLaceModel], SortersType: ListOfPlaces.SortersType) -> [ListOfPlaces.PLaceModel] {
        return original_array.sorted(by: SortersType.sorter)
    }
}
