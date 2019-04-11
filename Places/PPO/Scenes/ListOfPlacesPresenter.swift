protocol ListOfPlacesPresentationLogic {
    func presentError(response: ListOfPlaces.RecieveData.Response)
    func presentUpdatedData(response: ListOfPlaces.DataUpdated.Responce)
    func presentUpdatedState(response: ListOfPlaces.State)
}

class ListOfPlacesPresenter: ListOfPlacesPresentationLogic {
    weak var _view_controller: ListOfPlacesDisplayLogic?

    func presentError(response: ListOfPlaces.RecieveData.Response) {
        let view_model = ListOfPlaces.RecieveData.ViewModel(error_string: response.error.description)
        _view_controller?.displayError(view_model: view_model)
    }
    
    func presentUpdatedData(response: ListOfPlaces.DataUpdated.Responce) {
        let view_model = ListOfPlaces.DataUpdated.ViewModel()
        _view_controller?.displayUpdatedData(view_model: view_model)
    }
    
    func presentUpdatedState(response: ListOfPlaces.State) {
        switch response {
            case .Search: _view_controller?.cancelButtonIsHidden = false
            case .Scrolling_and_search: _view_controller?.keyboardIsHidden = true
            case .FirstResponder: _view_controller?.displayPrimaryStateBeforeSerching()
            
        }
    }
}
