//
//  MapsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapsViewController: BaseViewController, UISearchBarDelegate {

    
    var arrayMarkerDoctor: [GMSMarker] =  []
    var map:GMSMapView?//  = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.init())
    var camera:GMSCameraPosition?//.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
    var isMapMove = false
    let marker = GMSMarker()
    let markerUser = GMSMarker()
    
    var listBaseService: [BaseServiceModel] = []
    var listAuction:[AuctionServiceModel] = []
    var listEvents: [EventModel] = []
    
    var isChooseBase = true, isChooseAuction = true, isChooseEvent = true
    
    var slider = UISlider()
    @IBOutlet weak var vSlide: UIView!
    @IBOutlet weak var btBaseService: UIButton!
    @IBOutlet weak var btAuctionService: UIButton!
    @IBOutlet weak var btEventService: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var lbKm: UILabel!
    
    // search bar
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        DispatchQueue.main.async {
            self.setupUI()
        }
        self.getListAllService()
//
//        if self.map == nil {
//            self.configMapView(lat: BaseViewController.Current_Lat, lng: BaseViewController.Current_Lng)
//            self.addMarkerUser()
//        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "Map")
    }
    
    func setupUI(){
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
        
        self.vSlide = Settings.ShareInstance.setupView(v: self.vSlide)
        self.btBaseService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        self.btAuctionService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        self.btEventService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
        
//        let w = self.vSlide.frame.size.height
        slider.minimumValue = 1.0
        slider.maximumValue = 10.0
        slider.tintColor = UIColor.FlatColor.Oranges.BGColor
        slider.thumbTintColor = UIColor.FlatColor.Oranges.BGColor
        slider.bounds.size.width = self.vSlide.frame.size.height/3*2
        slider.center = CGPoint(x: self.vSlide.bounds.width/2, y: self.vSlide.bounds.width/2 + 70)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        slider.addTarget(self, action: #selector(changeSliderValue), for: .valueChanged)

        self.vSlide.addSubview(slider)
        self.vSlide.clipsToBounds = true
        
        searchResultController = SearchResultsController()
//        searchResultController.delegate = self
        
    }
    
    @objc func touchLeft(){
        
    }
    
    @objc func touchRight(){
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        self.present(searchController, animated:true, completion: nil)
    }
    
    @objc func changeSliderValue(){
        self.lbKm.text = "\(Int(self.slider.value)) km"
    }
    
    func getListAllService(){
        let group = DispatchGroup()
        self.listBaseService.removeAll()
        self.listAuction.removeAll()
        self.listEvents.removeAll()
        if isChooseBase {
            group.enter()
            ManageServicesManager.shareManageServicesManager().getListBaseService(page: 1, pageSize: 1000) { [unowned self](response) in
                switch response {
                    
                case .success(let data):
                    self.hideProgressHub()
                    self.listBaseService = data
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    group.leave()
                    break
                }
                group.leave()
            }
        }
        if isChooseAuction {
            group.enter()
            ManageServicesManager.shareManageServicesManager().getListAuctionService { [unowned self](response) in
                switch response {
                    
                case .success(let data):
                    self.hideProgressHub()
                    self.listAuction = data
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    group.leave()
                    break
                }
                group.leave()
            }
        }
        if isChooseEvent {
            group.enter()
            ManageServicesManager.shareManageServicesManager().getListEventService(type: "") { [unowned self](response) in
                switch response {

                case .success(let data):
                    self.hideProgressHub()
                    self.listEvents = data
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    group.leave()
                    break
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            if self.map == nil {
                self.configMapView(lat: BaseViewController.Current_Lat, lng: BaseViewController.Current_Lng)
                self.addMarkerUser()
            }
            self.addMarkerToMap(arrBaseService: self.listBaseService, arrAuctionService: self.listAuction, arrEventService: self.listEvents)
        }
    }
    
    ////// map
    
    func configMapView(lat: Double, lng: Double) {
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15.0)
        map = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: CGFloat(UIScreen.main.bounds.width), height: CGFloat(UIScreen.main.bounds.height - (topPadding ?? 0) - (bottomPadding ?? 0))), camera: camera!)
        map!.delegate = self
        mapView.addSubview(map!)
        mapView.frame = map!.bounds
    }

    func addMarkerUser() -> Void {
        let userModel = Settings.ShareInstance.getDictUser()
        //        var bounds = GMSCoordinateBounds()
        markerUser.position = CLLocationCoordinate2D(latitude: BaseViewController.Current_Lat, longitude: BaseViewController.Current_Lng)
        markerUser.title = userModel.fullName
        markerUser.icon = UIImage.init(named: "ic_marker_user")
        markerUser.map = map
//        markerUser.map!.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: BaseViewController.Lat, longitude: BaseViewController.Lng, zoom: 15.0)))
    }
    
    func addMarkerToMap(arrBaseService: [BaseServiceModel] = [], arrAuctionService: [AuctionServiceModel] = [], arrEventService: [EventModel] = []) -> Void {
        self.hideProgressHub()
        for data in self.arrayMarkerDoctor {
            data.map = nil
        }
        self.arrayMarkerDoctor.removeAll()

        for homeModel in arrBaseService {
            let marker1 = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: homeModel.latitude!, longitude: homeModel.longitude!)
            marker1.title = homeModel.userInfo?.fullName
            marker1.icon = UIImage.init(named: "ic_marker_base")
            marker1.map = map
            arrayMarkerDoctor.append(marker1)
        }
        for homeModel in arrAuctionService {
            let marker1 = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: homeModel.latitude!, longitude: homeModel.longitude!)
            marker1.title = homeModel.userInfo?.fullName
            marker1.icon = UIImage.init(named: "ic_marker_auction")
            marker1.map = map
            arrayMarkerDoctor.append(marker1)
        }
        for homeModel in arrEventService {
            let marker1 = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: homeModel.latitude!, longitude: homeModel.longitude!)
            marker1.title = homeModel.userInfo?.fullName
            marker1.icon = UIImage.init(named: "ic_marker_event")
            marker1.map = map
            arrayMarkerDoctor.append(marker1)
        }
//        map.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
    }
    
    @IBAction func touchBaseService(_ sender: Any) {
        isChooseBase = !isChooseBase
        self.showProgressHub()
        self.getListAllService()
    }
    @IBAction func touchAuctionService(_ sender: Any) {
        isChooseAuction = !isChooseAuction
        self.showProgressHub()
        self.getListAllService()
    }
    @IBAction func touchEventService(_ sender: Any) {
        isChooseEvent = !isChooseEvent
        self.showProgressHub()
        self.getListAllService()
    }
    
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
    

}

extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

        if isMapMove {
            print("thanhc ong = \(position.target.latitude), lng = \(position.target.longitude)")
            //mapView.clear() let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
            UIView.animate(withDuration: 0.5) {
                self.marker.icon = UIImage.init(named: "ic_marker_user")
                self.marker.map = self.map
            }
//            mapView.moveCamera(GMSCameraUpdate.setCamera(position))
        }
    }

    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("marker = \(marker.position.latitude)")
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("gesture = \(gesture)")
        isMapMove = gesture
        markerUser.map = nil
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if isMapMove {
            let locationCurrent = CLLocation.init(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng)
            let locationNew = CLLocation.init(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
            let distance = locationCurrent.distance(from: locationNew)
            BaseViewController.Lat = mapView.camera.target.latitude
            BaseViewController.Lng = mapView.camera.target.longitude
//            if arrayDoctor.count > 0 {
//                let homeModel = arrayDoctor[0]
//                if distance/1000 > homeModel.Radius! {
//                    print("idleAt")
////                    mapView.clear()
//                    self.getListDoctorWhenMapMove(majorCode: lbDescription.tag)
//                } else {
//                    self.addMarkerToMap(arr: arrayDoctor)
//                }
//            } else {
//                self.getListDoctorWhenMapMove(majorCode: lbDescription.tag)
//            }
            isMapMove = false
        }
    }
}
