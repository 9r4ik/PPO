enum ListOfPlaces
{
    struct PLaceModel {
        var name: String
        var address: String
        var url_string: String
        var popular: Int
        
        var displayed_name: String {
            return address + ", " + name
        }
        
        
    }
    
    enum SortersType {
        case Alphabet
        case Popular
        
        var sorter: (_ this: ListOfPlaces.PLaceModel, _ that: ListOfPlaces.PLaceModel) -> Bool {
            switch self {
            case .Alphabet: return SorterCamerasList.AlphabetSortArray
            case .Popular:  return SorterCamerasList.PopularSortArray
            }
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
  
    enum Sort {
        struct Request {
            let sort_type: SortersType
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
