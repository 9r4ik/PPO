protocol ListOfPlacesBusinessLogic {
    func reciveData(request: ListOfPlaces.RecieveData.Request)
    func filterData(request: ListOfPlaces.Search.Request)
    func detectUIAction(request: ListOfPlaces.UIActoins.Request )
    func sortData(request: ListOfPlaces.Sort.Request)
}

protocol ListOfPlacesDataStore {
    var type_of_places: String { get }
    var displayed_places: [ListOfPlaces.PLaceModel] { get }
}

class ListOfPlacesInteractor
{
    var _presenter: ListOfPlacesPresentationLogic?
    var _worker: FilterCamerasArray = ListOfPlacesWorker()
    
    var _state = ListOfPlaces.State.FirstResponder { didSet {
        if oldValue != _state { _presenter?.presentUpdatedState(response: _state) }
        }
    }
    
    var _data_manager: DataManagerProtocol?
    var _all_places: [ListOfPlaces.PLaceModel] = [] { didSet { _displayed_places = _worker.sortArray(original_array: _all_places, SortersType: _sorted_type) } }
    
    var _displayed_places: [ListOfPlaces.PLaceModel] = [] {
        didSet {
            let responce = ListOfPlaces.DataUpdated.Responce()
            _presenter?.presentUpdatedData(response: responce)
        }
    }
    
    var _type_of_places = "Музей"
    var _sorted_type: ListOfPlaces.SortersType = .Alphabet {
        didSet {
            _displayed_places = _worker.sortArray(original_array: _displayed_places, SortersType: _sorted_type)
        }
    }
}

extension ListOfPlacesInteractor: ListOfPlacesBusinessLogic {
    func sortData(request: ListOfPlaces.Sort.Request) {
        _sorted_type = request.sort_type
    }
    
    func detectUIAction(request: ListOfPlaces.UIActoins.Request) {
        _state.newState(UIAction: request.action)
    }
    
    func filterData(request: ListOfPlaces.Search.Request) {
        let filtred_places = _worker.filterArray(original_array: _all_places, search_text: request.search_text)
        _displayed_places = _worker.sortArray(original_array: filtred_places, SortersType: _sorted_type)
    }
    
    func reciveData(request: ListOfPlaces.RecieveData.Request) {
        _data_manager?.receivePlaces(delegate: self)
    }
}

extension ListOfPlacesInteractor: DataManagerHandler {
    func didReceiveData(data: Any) {
        _all_places = data as! [ListOfPlaces.PLaceModel]
    }
    
    func didReciveError(error: DataManagerError) {
        let responce = ListOfPlaces.RecieveData.Response(error: error)
        _presenter?.presentError(response: responce)
    }
}

extension ListOfPlacesInteractor: ListOfPlacesDataStore {
    var type_of_places: String { get { return _type_of_places} }
    var displayed_places: [ListOfPlaces.PLaceModel] { get { return _displayed_places } }
}
