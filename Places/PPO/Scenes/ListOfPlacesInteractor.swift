protocol ListOfPlacesBusinessLogic {
    func reciveData(request: ListOfPlaces.RecieveData.Request)
    func filterData(request: ListOfPlaces.Search.Request)
    func detectUIAction(request: ListOfPlaces.UIActoins.Request )
}

protocol ListOfPlacesDataStore {
    var type_of_places: String { get }
    var displayed_places: [ListOfPlaces.PLaceModel] { get }
}

class ListOfPlacesInteractor
{
    var _presenter: ListOfPlacesPresentationLogic?
    var _worker = ListOfPlacesWorker()
    
    var _state = ListOfPlaces.State.FirstResponder { didSet { _presenter?.presentUpdatedState(response: _state)} }
    
    var _data_manager: DataManagerProtocol?
    var _all_places: [ListOfPlaces.PLaceModel] = [] {didSet {_displayed_places = _all_places}}
    
    var _displayed_places: [ListOfPlaces.PLaceModel] = [] {
        didSet {
            let responce = ListOfPlaces.DataUpdated.Responce()
            _presenter?.presentUpdatedData(response: responce)
        }
    }
    
    var _type_of_places = "Музей"
}

extension ListOfPlacesInteractor: ListOfPlacesBusinessLogic {
    func detectUIAction(request: ListOfPlaces.UIActoins.Request) {
        _state.newState(UIAction: request.action)
    }
    
    func filterData(request: ListOfPlaces.Search.Request) {
        _displayed_places = _worker.filterArray(original_array: _all_places, search_text: request.search_text)
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
