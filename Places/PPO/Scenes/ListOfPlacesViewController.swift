import UIKit

protocol ListOfPlacesDisplayLogic: class {
    var cancelButtonIsHidden: Bool { get set }
    var keyboardIsHidden: Bool { get set }
    
    func displayPrimaryStateBeforeSerching()
    func displayError(view_model: ListOfPlaces.RecieveData.ViewModel)
    func displayUpdatedData(view_model: ListOfPlaces.DataUpdated.ViewModel)
}

class ListOfPlacesViewController: UIViewController
{
    @IBOutlet weak var _type_of_places_label: UILabel!
    @IBOutlet weak var _places_search_bar: UISearchBar!
    @IBOutlet weak var _places_coll_view: UICollectionView!
    
    var _interactor: ListOfPlacesBusinessLogic!
    var _data_store: ListOfPlacesDataStore!
    
    struct _constants {
        static let items_in_row: CGFloat = 1
        static let items_in_column: CGFloat = 5
        static let section_insets = UIEdgeInsets(top: 0.0,
                                                 left: 0.0,
                                                 bottom: 0.0,
                                                 right: 0.0)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        build()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlacesLabel()
        setupSearchBar()
        setupCollView()
        reciveData()
    }
}


extension ListOfPlacesViewController {
    func build() {
        let view_controller = self
        let interactor = ListOfPlacesInteractor()
        let presenter = ListOfPlacesPresenter()
        let data_manager = DataManager()
        
        view_controller._interactor = interactor
        view_controller._data_store = interactor
        
        interactor._presenter = presenter
        interactor._data_manager = data_manager
        presenter._view_controller = view_controller
    }
    
    func setupPlacesLabel() {
        _type_of_places_label.text = _data_store?.type_of_places
    }
    
    func setupCollView() {
        _places_coll_view.register(PlaceCollViewCell.nib, forCellWithReuseIdentifier: "Cell")
        _places_coll_view.delegate = self
        _places_coll_view.dataSource = self
    }
    
    func setupSearchBar() {
        _places_search_bar.delegate = self
        _places_search_bar.showsCancelButton = false
    }
    
    
    func reciveData() {
        let request = ListOfPlaces.RecieveData.Request()
        _interactor.reciveData(request: request)
    }
}


extension ListOfPlacesViewController: ListOfPlacesDisplayLogic {
    var keyboardIsHidden: Bool {
        get { return false }
        set { if newValue  { _places_search_bar.resignFirstResponder() } }
    }
    
    var cancelButtonIsHidden: Bool {
        get { return false }
        set { _places_search_bar.showsCancelButton = !newValue }
    }
    
    func displayPrimaryStateBeforeSerching() {
        _places_search_bar.text = nil
        _places_search_bar.showsCancelButton = false
        _places_search_bar.delegate!.searchBar!(_places_search_bar, textDidChange: "")
        _places_search_bar.endEditing(true)
    }
    
    func displayUpdatedData(view_model: ListOfPlaces.DataUpdated.ViewModel) {
        _places_coll_view.reloadData()
    }
    
    func displayError(view_model: ListOfPlaces.RecieveData.ViewModel) {
        print(view_model.error_string)
    }
}


extension ListOfPlacesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _data_store.displayed_places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = _places_coll_view.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PlaceCollViewCell else {
            return UICollectionViewCell()
        }
        
        cell.set(place: _data_store.displayed_places[indexPath.row])
        return cell
        
    }
}


extension ListOfPlacesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width_per_item = collectionView.bounds.width / _constants.items_in_row
        let height_per_item = collectionView.bounds.height / _constants.items_in_column
        
        return CGSize(width: width_per_item, height: height_per_item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return _constants.section_insets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ListOfPlacesViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let request = ListOfPlaces.UIActoins.Request(action: ListOfPlaces.VariantsOfUIActions.Scrolling)
        _interactor?.detectUIAction(request: request)
    }
}


extension ListOfPlacesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request = ListOfPlaces.Search.Request(search_text: searchText)
        _interactor?.filterData(request: request)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let request = ListOfPlaces.UIActoins.Request(action: ListOfPlaces.VariantsOfUIActions.TextBeginEditing)
        _interactor?.detectUIAction(request: request)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let request = ListOfPlaces.UIActoins.Request(action: ListOfPlaces.VariantsOfUIActions.CancelButtonClicked)
        _interactor?.detectUIAction(request: request)
    }
}
