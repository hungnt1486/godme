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

class MapsViewController: BaseViewController {

    
    var arrayMarkerDoctor: [GMSMarker] =  []
    var map:GMSMapView?//  = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.init())
    var camera:GMSCameraPosition?//.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
    var isMapMove = false
    let marker = GMSMarker()
    let markerUser = GMSMarker()
    var circ = GMSCircle()
    
    var listAllService: [MapModel] = []
    
    var isChooseBase = true, isChooseAuction = true, isChooseEvent = true
    
    var slider = UISlider()
    @IBOutlet weak var vSlide: UIView!
    @IBOutlet weak var btBaseService: UIButton!
    @IBOutlet weak var btAuctionService: UIButton!
    @IBOutlet weak var btEventService: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var lbKm: UILabel!
    
    @IBOutlet weak var vSub: UIView!
    var vSearchBar: VSearchBarMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        DispatchQueue.main.async {
            self.setupUI()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.title = Settings.ShareInstance.translate(key: "Map")
        self.tabBarController?.tabBar.isHidden = false
        self.setupSearchBar()
        self.getListAllService()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if vSearchBar != nil {
            vSearchBar.viewWithTag(5)?.removeFromSuperview()
            vSearchBar = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if vSearchBar != nil {
            vSearchBar.viewWithTag(5)?.removeFromSuperview()
            vSearchBar = nil
        }
    }
    
    func setupUI(){
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
        
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
        
        self.vSlide = Settings.ShareInstance.setupView(v: self.vSlide)
        self.btBaseService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        self.btAuctionService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        self.btEventService.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        
//        let w = self.vSlide.frame.size.height
        slider.minimumValue = 1.0
        slider.maximumValue = 10.0
        slider.tintColor = UIColor.FlatColor.Oranges.BGColor
        slider.thumbTintColor = UIColor.FlatColor.Oranges.BGColor
        slider.bounds.size.width = self.vSlide.frame.size.height/3*2
        slider.center = CGPoint(x: self.vSlide.bounds.width/2, y: self.vSub.frame.origin.y + self.vSlide.frame.origin.y - 20)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        slider.addTarget(self, action: #selector(changeSliderValue), for: .valueChanged)

        self.vSlide.addSubview(slider)
        self.vSlide.clipsToBounds = true
        self.lbKm.text = "\(Int(self.slider.value)) km"
    }
    
    func setupSearchBar(){
        if vSearchBar == nil {
            vSearchBar = VSearchBarMap.instanceFromNib()
//            vSearchBar.delegate = self
            vSearchBar.tag = 5
            vSearchBar.configVSearchBar(frameView: CGRect.init(x: (UIScreen.main.bounds.width - 200)/2, y: 0, width: 200, height: 50))
            self.navigationController?.navigationBar.addSubview(vSearchBar)
        }
    }
    
    @objc func touchLeft(){
        self.editProfile()
    }
    
    @objc func touchRight(){
        self.showProgressHub()
        self.getListAllService()
        self.circ.map = nil
        let circleCenter = CLLocationCoordinate2D(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng)
        self.circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(Int(self.slider.value)*1000))
        UIView.animate(withDuration: 0.5) {
            self.marker.icon = UIImage.init(named: "ic_marker_user")
            self.marker.map = self.map
            
            self.circ.fillColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
            self.circ.strokeColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
//                self.circ.strokeWidth = 2.5;
            self.circ.map = self.map;
            
            
        }
    }
    
    @objc func changeSliderValue(){
        self.lbKm.text = "\(Int(self.slider.value)) km"
    }
    
    func getListAllService(){
        self.view.endEditing(true)
        var arr: [String] = []
        if isChooseBase {
            arr.append("BASIC")
        }
        if isChooseAuction {
            arr.append("AUCTION")
        }
        if isChooseEvent {
            arr.append("EVENT")
        }
        var model = AddNewFindMapParams()
        model.centerLat = BaseViewController.Lat
        model.centerLong = BaseViewController.Lng
        model.keySearch = vSearchBar.tfInputText.text ?? ""
        model.radius = Int(self.slider.value) == 0 ? 1 : Int(self.slider.value)
        model.services = arr
        ManageServicesManager.shareManageServicesManager().searchServiceOnMap(model: model) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.map == nil {
                    self.configMapView(lat: BaseViewController.Lat, lng: BaseViewController.Lng)
                    self.addMarkerUser()
                }
                self.addMarkerToMap(arrAllService: data)
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    ////// map
    
    func configMapView(lat: Double, lng: Double) {
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 11.6)
        map = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: CGFloat(UIScreen.main.bounds.width), height: CGFloat(UIScreen.main.bounds.height - (topPadding ?? 0) - (bottomPadding ?? 0))), camera: camera!)
        map!.delegate = self
        mapView.addSubview(map!)
        mapView.frame = map!.bounds
    }
    
    func drawCircle() {

        //var latitude = position.latitude
        //var longitude = position.longitude
        //var circleCenter = CLLocationCoordinate2DMake(latitude, longitude)
        circ.map = nil
        let circleCenter = CLLocationCoordinate2D(latitude: BaseViewController.Current_Lat, longitude: BaseViewController.Current_Lng)
        circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(Int(self.slider.value)*1000))
        self.circ.fillColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
        self.circ.strokeColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
//        circ.strokeWidth = 2.5;
        circ.map = map;
        
        
//        let circle = GMSCircle(position: position, radius: 150)
//        circle.strokeColor = UIColor.blue
//        circle.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.05)
//        circle.map = map

    }

    func addMarkerUser() -> Void {
        let userModel = Settings.ShareInstance.getDictUser()
        markerUser.position = CLLocationCoordinate2D(latitude: BaseViewController.Current_Lat, longitude: BaseViewController.Current_Lng)
        markerUser.title = userModel.fullName
        markerUser.icon = UIImage.init(named: "ic_marker_user")
        markerUser.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        markerUser.appearAnimation = GMSMarkerAnimation.pop
        markerUser.map = map
        self.drawCircle()
    }
    
    func addMarkerToMap(arrAllService: [MapModel]) -> Void {
        self.hideProgressHub()
        for data in self.arrayMarkerDoctor {
            data.map = nil
        }
        self.arrayMarkerDoctor.removeAll()

        for homeModel in arrAllService {
            let marker1 = GMSMarker()
            marker1.position = CLLocationCoordinate2D(latitude: homeModel.latitude!, longitude: homeModel.longitude!)
            marker1.title = homeModel.title
            if homeModel.serviceType == "BASIC" {
                marker1.icon = UIImage.init(named: "ic_marker_base")
            }else if homeModel.serviceType == "AUCTION" {
                marker1.icon = UIImage.init(named: "ic_marker_auction")
            }else{
                marker1.icon = UIImage.init(named: "ic_marker_event")
            }
            marker1.map = map
            arrayMarkerDoctor.append(marker1)
        }
    }
    
    @IBAction func touchBaseService(_ sender: Any) {
        if isChooseBase {
            self.btBaseService.backgroundColor = UIColor.FlatColor.Gray.BGColor
            self.btBaseService.setTitleColor(UIColor.FlatColor.Blue.BGColor, for: .normal)
        }else{
            self.btBaseService.backgroundColor = UIColor.FlatColor.Blue.BGColor
            self.btBaseService.setTitleColor(UIColor.FlatColor.Gray.BGColor, for: .normal)
        }
        isChooseBase = !isChooseBase
        self.showProgressHub()
        self.getListAllService()
    }
    @IBAction func touchAuctionService(_ sender: Any) {
        if isChooseAuction {
            self.btAuctionService.backgroundColor = UIColor.FlatColor.Gray.BGColor
            self.btAuctionService.setTitleColor(UIColor.FlatColor.Blue.BGColor, for: .normal)
        }else{
            self.btAuctionService.backgroundColor = UIColor.FlatColor.Blue.BGColor
            self.btAuctionService.setTitleColor(UIColor.FlatColor.Gray.BGColor, for: .normal)
        }
        isChooseAuction = !isChooseAuction
        self.showProgressHub()
        self.getListAllService()
    }
    @IBAction func touchEventService(_ sender: Any) {
        if isChooseEvent {
            self.btEventService.backgroundColor = UIColor.FlatColor.Gray.BGColor
            self.btEventService.setTitleColor(UIColor.FlatColor.Blue.BGColor, for: .normal)
        }else{
            self.btEventService.backgroundColor = UIColor.FlatColor.Blue.BGColor
            self.btEventService.setTitleColor(UIColor.FlatColor.Gray.BGColor, for: .normal)
        }
        isChooseEvent = !isChooseEvent
        self.showProgressHub()
        self.getListAllService()
    }
}

extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

        if isMapMove {
            print("thanhc ong = \(position.target.latitude), lng = \(position.target.longitude)")
            //mapView.clear() let marker = GMSMarker()
            BaseViewController.Lat = position.target.latitude
            BaseViewController.Lng = position.target.longitude
            marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
            self.circ.map = nil
            let circleCenter = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
            self.circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(Int(self.slider.value)*1000))
            UIView.animate(withDuration: 0.5) {
                self.marker.icon = UIImage.init(named: "ic_marker_user")
                self.marker.map = self.map
                
                self.circ.fillColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
                self.circ.strokeColor = UIColor(red: 0.0/255, green: 52/255, blue: 112/255, alpha: 0.2)
//                self.circ.strokeWidth = 2.5;
                self.circ.map = self.map;
                
                
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
        circ.map = nil
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if isMapMove {
//            let locationCurrent = CLLocation.init(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng)
//            let locationNew = CLLocation.init(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
//            let distance = locationCurrent.distance(from: locationNew)
            BaseViewController.Lat = mapView.camera.target.latitude
            BaseViewController.Lng = mapView.camera.target.longitude
//            self.drawCircle(position: CLLocationCoordinate2D(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng))
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
