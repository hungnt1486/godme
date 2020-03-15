
import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class MapPickerViewController: BaseViewController, GMSMapViewDelegate, LocateOnTheMap, UISearchBarDelegate, GMSAutocompleteFetcherDelegate {

    //MARK: - Properties
    public var onDismissCallback: ((CLLocation?) -> ())?
    var location: CLLocation?
    
//    var placesClient = GMSPlacesClient()
    
    // For SearchViewController
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    
    lazy var mapView : GMSMapView = { [unowned self] in
        let locationCoordinate = CLLocationCoordinate2D(latitude: BaseViewController.Current_Lat, longitude: BaseViewController.Current_Lng)
        let camera = GMSCameraPosition.camera(withTarget: locationCoordinate, zoom: 15)
        let v = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                do {
                    // Set the map style by passing the URL of the local file.
                    if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                        v.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                    } else {
                        NSLog("Unable to find style.json")
                    }
                } catch {
                    NSLog("One or more of the map styles failed to load. \(error)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        v.settings.compassButton = true
        v.settings.myLocationButton = true
        v.isMyLocationEnabled = true
        v.delegate = self
        v.autoresizingMask = UIView.AutoresizingMask.flexibleWidth.union(.flexibleHeight)
        return v
        }()
    
    lazy var pinView: UIImageView = { [unowned self] in
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        v.image = UIImage.init(named: "map_pin")
//        v.iMapViewControllermage = UIImage(named: "map_pin", in: Bundle(for: MapViewController.self), compatibleWith: nil)
        v.image = v.image?.withRenderingMode(.alwaysTemplate)
//        v.tintColor = self.view.tintColor
        v.tintColor = UIColor.red
        v.backgroundColor = .clear
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = false
        return v
        }()
    
    let width: CGFloat = 10.0
    let height: CGFloat = 5.0
    
    lazy var ellipse: UIBezierPath = { [unowned self] in
        let ellipse = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        return ellipse
        }()
    
    
    lazy var ellipsisLayer: CAShapeLayer = { [unowned self] in
        let layer = CAShapeLayer()
        layer.bounds = CGRect(x: 0, y: -10, width: self.width, height: self.height)
        layer.path = self.ellipse.cgPath
        layer.fillColor = UIColor.gray.cgColor
        layer.fillRule = CAShapeLayerFillRule.nonZero
        layer.lineCap = CAShapeLayerLineCap.butt
        layer.lineDashPattern = nil
        layer.lineDashPhase = 0.0
        layer.lineJoin = CAShapeLayerLineJoin.miter
        layer.lineWidth = 1.0
        layer.miterLimit = 10.0
        layer.strokeColor = UIColor.gray.cgColor
        return layer
        }()
    
    
    //MARK: - Methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience public init(_ callback: ((CLLocation?) -> ())?){
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.addSubview(pinView)
        mapView.layer.insertSublayer(ellipsisLayer, below: pinView.layer)
        
        // Add left bar button
//        let leftButton = UIButton.init(type: .custom)
//        leftButton.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        leftButton.addTarget(self, action:#selector(backToPreviousController), for: UIControl.Event.touchUpInside)
//        leftButton.frame = CGRect.init(x: 0, y: 0, width: 10, height: 20)
//        leftButton.tintColor = .white
//        leftButton.backgroundColor = .clear
//        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
//        self.navigationItem.leftBarButtonItem = leftBarButton
        
//        let button = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .done, target: self, action: #selector(tappedDone(_:)))
//        navigationItem.rightBarButtonItem = button
        let doneBtn = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height >= 812 ? (UIScreen.main.bounds.height - 120 - 50) : (UIScreen.main.bounds.height - 140), width: 50, height: 50))
//        doneBtn.setImage(UIImage(named: "ic_done"), for: .normal)
        doneBtn.setBackgroundImage(UIImage(named: "ic_done"), for: .normal)
        doneBtn.addTarget(self, action: #selector(tappedDone(_:)), for: .touchUpInside)
//        self.view.addSubview(doneBtn)
        mapView.addSubview(doneBtn)
//        doneBtn.snp
//        doneBtn.sn
//        doneBtn.snp.makeConstraints { (make) in
//            make.height.equalTo(60)
//            make.width.equalTo(60)
//            make.bottom.equalTo(view.snp.bottom).offset(-80)
//            make.right.equalTo(view.snp.right).offset(-10)
//        }
//        doneBtn.backgroundColor = Authenticator.shareInstance.getPostType()?.color()
//        doneBtn.layer.cornerRadius = 30
        doneBtn.clipsToBounds = true
        
//        let v = UIView()
//        v.backgroundColor = UIColor.white
//        self.view.addSubview(v)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        let a = NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
//        let b = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 5.0)
//        let c = NSLayoutConstraint(item: v, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
//        let d = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 40.0)
//        self.view.addConstraints([a,b,c,d])
//
//        let tfSearch = UITextField()
//        tfSearch.placeholder = "Nhập địa chỉ"
//        tfSearch.backgroundColor = UIColor.white
//        tfSearch.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
//        v.addSubview(tfSearch)
//        tfSearch.translatesAutoresizingMaskIntoConstraints = false
//
//        let a1 = NSLayoutConstraint(item: tfSearch, attribute: .leading, relatedBy: .equal, toItem: v, attribute: .leading, multiplier: 1.0, constant: 10.0)
//        let b1 = NSLayoutConstraint(item: tfSearch, attribute: .top, relatedBy: .equal, toItem: v, attribute: .top, multiplier: 1.0, constant: 5.0)
//        let c1 = NSLayoutConstraint(item: tfSearch, attribute: .trailing, relatedBy: .equal, toItem: v, attribute: .trailing, multiplier: 1.0, constant: 10.0)
//        let d1 = NSLayoutConstraint(item: tfSearch, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30.0)
//        v.addConstraints([a1,b1,c1,d1])
//
//        let tableViewAddress = UITableView()
////        tableViewAddress.delegate = self
////        tableViewAddress.dataSource = self
//        self.view.addSubview(tableViewAddress)
//        tableViewAddress.translatesAutoresizingMaskIntoConstraints = false
//        let a2 = NSLayoutConstraint(item: tableViewAddress, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 10.0)
//        let b2 = NSLayoutConstraint(item: tableViewAddress, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 10.0)
//        let c2 = NSLayoutConstraint(item: tableViewAddress, attribute: .top, relatedBy: .equal, toItem: v, attribute: .bottom, multiplier: 1.0, constant: 10.0)
//        let d2 = NSLayoutConstraint(item: tableViewAddress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0)
//        self.view.addConstraints([a2,b2,c2,d2])
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tappedSearch(_:)))
        searchButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = searchButton

        var coordinate: CLLocationCoordinate2D
        if let location = location {
            coordinate = location.coordinate
        } else{
            coordinate = mapView.myLocation != nil ? (mapView.myLocation?.coordinate)! : CLLocationCoordinate2D(latitude: 10.8010, longitude: 106.6823)
        }
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        mapView.camera = camera
        updateTitle()
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var center = mapView.convert(mapView.center, to: pinView)
        center.y = center.y - (pinView.bounds.height)
        pinView.center = CGPoint(x: center.x, y: center.y - (pinView.bounds.height/2))
        ellipsisLayer.position = center
    }
    
    @objc func tappedDone(_ sender: UIBarButtonItem){
//        let target = mapView.projection.coordinate(for: ellipsisLayer.position)
        let target = mapView.camera.target
        onDismissCallback?(CLLocation(latitude: target.latitude, longitude: target.longitude))
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedSearch(_ sender: UIBarButtonItem){
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        self.present(searchController, animated:true, completion: nil)
    }
    
    @objc func backToPreviousController () {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func updateTitle(){
//        let fmt = NumberFormatter()
//        fmt.maximumFractionDigits = 4
//        fmt.minimumFractionDigits = 4
//        let latitude = fmt.string(from: NSNumber(value: mapView.camera.target.latitude))!
//        let longitude = fmt.string(from: NSNumber(value: mapView.camera.target.longitude))!
//        title = "\(latitude), \(longitude)"
    }
    
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        ellipsisLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y - 10)
        })
    }
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        ellipsisLayer.transform = CATransform3DIdentity
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y + 10)
        })
        updateTitle()
    }
    

    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        DispatchQueue.main.async { () -> Void in
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
            self.mapView.camera = camera
//            self.title = title
        }
    }
    
    // it's call when textField change text
//    @objc func textFieldDidChange(textField: UITextField) -> Void {
//        //        var trackingTimer =
////        print("text field = ", textField.text)
////
//        let strAddress = textField.text
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        placesClient.autocompleteQuery(strAddress!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
//            if let error = error {
//                print("Autocomplete error \(error)")
//                return
//            }
//            if let results = results {
//                print("results = ", results)
////                self.arraySuggestion.removeAll()
////                self.arrayPlaceID.removeAll()
////                for result in results {
////                    self.arraySuggestion.append(result.attributedFullText.string)
////                    self.arrayPlaceID.append(result.placeID!)
////                }
////                self.sortTemp()
//            }
//        })
////        self.filterFromArray(text: textField.text!)
////        if let callback = setTextChangeCallback {
////            callback(textField.text!, textField)
////        }
//    }
    
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

                let placeClient = GMSPlacesClient()


                placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
                   // NSError myerr = Error;
                    print("Error @%",Error.self)

                    self.resultsArray.removeAll()
                    if results == nil {
                        return
                    }

                    for result in results! {
                        if let result = result as? GMSAutocompletePrediction {
                            self.resultsArray.append(result.attributedFullText.string)
                        }
                    }

                    self.searchResultController.reloadDataWithArray(self.resultsArray)

                }


        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)

    }
    
    //MARK: - GMSAutocompleteFetcherDelegate
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction?{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
//        resultText?.text = error.localizedDescription
    }
}

//extension MapPickerViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//}

