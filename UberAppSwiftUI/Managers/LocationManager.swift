//
//  LocationManager.swift
//  UberSwiftUI
//
//  Created by Y M on 2022/10/09.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        //desiredAccuracy -> 精度, kCLLocationAccuracyBest -> 最高精度
        //requestAlwaysAuthorization() -> 位置情報の取得許可をユーザに促す
        //startUpdatingLocation() -> 位置情報の追跡を終了
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    //locationManager -> 位置情報を取得した場合に呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //locationsが空出ない場合、追跡を止める
        //stopUpdatingLocation() -> 位置情報の追跡を終了
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
    }
}
