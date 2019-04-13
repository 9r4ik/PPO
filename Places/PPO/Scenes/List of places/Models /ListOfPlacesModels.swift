enum ListOfPlaces
{
    struct PLaceModel {
        var name: String
        var billing: String
        var url_string: String
        
        var displayed_name: String {
            return billing + ", " + name
        }
    }
    
    enum VariantsOfUIActions {
        case Scrolling
        case CancelButtonClicked
        case TextBeginEditing
    }
    
    enum UIActoins {
        struct Request {
            let action: VariantsOfUIActions
        }
        
        struct Response {
            let state: State
        }
    }
    
    enum State {
        case Search
        case Scrolling_and_search
        case FirstResponder
        
        mutating func newState(UIAction: VariantsOfUIActions) {
            switch UIAction {
            case .Scrolling:
                switch self {
                    case .Search: self = .Scrolling_and_search
                    case .Scrolling_and_search: break
                    case .FirstResponder: break
                }
                
            case .CancelButtonClicked:
                self = .FirstResponder
                
            case .TextBeginEditing:
                switch self {
                case .Search: break
                case .Scrolling_and_search: self = .Search
                case .FirstResponder: self = .Search
                }
            }
        }
    }
  
    enum Search {
        struct Request {
            let search_text: String
        }
    }
    
    enum DataUpdated {
        struct Responce {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    enum RecieveData {
        struct Request {
        }
        
        struct Response {
            let error: DataManagerError
        }
        
        struct ViewModel {
            let error_string: String
        }
    }
}
