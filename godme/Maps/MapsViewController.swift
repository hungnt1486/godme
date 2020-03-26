//
//  MapsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: BaseViewController {

    
//    var arrayMarkerDoctor: [GMSMarker] =  []
//    var map:GMSMapView?//  = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.init())
//    var camera:GMSCameraPosition?//.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
//    var isMapMove = false
//    let marker = GMSMarker()
//    let markerUser = GMSMarker()
    
    @IBOutlet weak var mapView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.setupUI()
//
//        if self.map == nil {
//            self.configMapView(lat: BaseViewController.Lat, lng: BaseViewController.Lng)
//            self.addMarkerUser()
//        }
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "Map")
    }
    
    func setupUI(){
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
    }
    
    @objc func touchLeft(){
        
    }
    
    ////// map
    
//    func configMapView(lat: Double, lng: Double) {
//            camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15.0)
//        map = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: CGFloat(UIScreen.main.bounds.width), height: CGFloat(UIScreen.main.bounds.height)), camera: camera!)
//            map!.delegate = self
//            mapView.addSubview(map!)
//            mapView.frame = map!.bounds
//        }
//
//        func addMarkerUser() -> Void {
////            let userModel = Settings.ShareInstance.getDictUser()
//            //        var bounds = GMSCoordinateBounds()
//            markerUser.position = CLLocationCoordinate2D(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng)
////            markerUser.title = userModel.FullName
//            markerUser.map = map
//    //        markerUser.map!.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.camera(withLatitude: BaseViewController.Lat, longitude: BaseViewController.Lng, zoom: 15.0)))
//        }
        
//        func addMarkerToMap(arr: [HomeModel]) -> Void {
//
//            for data in self.arrayMarkerDoctor {
//                data.map = nil
//            }
//            self.arrayMarkerDoctor.removeAll()
//
//            for homeModel in arr {
//                let marker1 = GMSMarker()
//                marker1.position = CLLocationCoordinate2D(latitude: homeModel.Lat!, longitude: homeModel.Lng!)
//                marker1.title = homeModel.FullName
//                marker1.icon = UIImage.init(named: "ic_marker_doctor")
//                marker1.map = map
//                arrayMarkerDoctor.append(marker1)
//            }
//    //        map.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
//        }

}

//extension MapsViewController: GMSMapViewDelegate {
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
//        if isMapMove {
//            print("thanhc ong = \(position.target.latitude), lng = \(position.target.longitude)")
//            //mapView.clear() let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
//            UIView.animate(withDuration: 0.5) {
//                self.marker.map = self.map
//            }
////            mapView.moveCamera(GMSCameraUpdate.setCamera(position))
//        }
//    }
//
//    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
//        print("marker = \(marker.position.latitude)")
//    }
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        print("gesture = \(gesture)")
//        isMapMove = gesture
//        markerUser.map = nil
//    }
//
//    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        if isMapMove {
//            let locationCurrent = CLLocation.init(latitude: BaseViewController.Lat, longitude: BaseViewController.Lng)
//            let locationNew = CLLocation.init(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
//            let distance = locationCurrent.distance(from: locationNew)
//            BaseViewController.Lat = mapView.camera.target.latitude
//            BaseViewController.Lng = mapView.camera.target.longitude
////            if arrayDoctor.count > 0 {
////                let homeModel = arrayDoctor[0]
////                if distance/1000 > homeModel.Radius! {
////                    print("idleAt")
//////                    mapView.clear()
////                    self.getListDoctorWhenMapMove(majorCode: lbDescription.tag)
////                } else {
////                    self.addMarkerToMap(arr: arrayDoctor)
////                }
////            } else {
////                self.getListDoctorWhenMapMove(majorCode: lbDescription.tag)
////            }
//            isMapMove = false
//        }
//    }
//}
