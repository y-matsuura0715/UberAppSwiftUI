//
//  UberMapViewRepresentable.swift
//  UberSwiftUI
//
//  Created by Y M on 2022/10/09.
//

import SwiftUI
import MapKit

//UIViewRepresentable -> SwiftUIの中でUIViewを使用するためのプロトコル
struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationmanager = LocationManager()
    
    //makeUIView -> UIViewRepresentable のライフサイクルの中で一度だけ最初に呼ばれる
    //初期化に使用
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        //isRotateEnabled -> falseにするとMapの向きが固定される(画面上が北で固定)
        mapView.isRotateEnabled = false
        //showsUserLocation -> 現在位置表示の有効化
        mapView.showsUserLocation = true
        //userTrackingMode -> 位置情報の追跡設定
        //(.follow -> 現在位置のみ更新す,.followWithHeading -> 現在位置と方向を更新, .none -> 更新しない)
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    //updateUIView -> View の状態が更新されるたびに呼ばれる
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
//    UIKitのViewをSwiftUIとして使うには、UIViewRepresentableを使います。
//    そしてUIKitのViewのdelegateやtarget actionをハンドリングしたい場合structではハンドリングできないので、Coordinatorという仕組みが用意されています。
//    makeCoordinator()がmakeUIViewより先に呼ばれるのでそこでCoordinatorを作成し、その後はmakeUIView()やupdateUIView
//    ()などで渡されるcontextにcoordinatorが含まれているので、それを用いればcoordinatorとやり取りができます。
//    SwiftUIのビューのState変数とバインディングし、UIKitのイベントに対して、バインディングした変数を更新するのがCoordinatorです。
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
    }
}

