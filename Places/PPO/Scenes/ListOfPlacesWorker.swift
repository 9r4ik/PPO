class ListOfPlacesWorker
{
    func filterArray(original_array: [ListOfPlaces.PLaceModel], search_text: String) -> [ListOfPlaces.PLaceModel] {
        return search_text.isEmpty ? original_array : original_array.filter {
            $0.name.lowercased().contains(search_text.lowercased())
        }
    }
}
