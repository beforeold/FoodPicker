import Foundation
import CoreLocation
import UIKit

class LocationViewModel: NSObject, ObservableObject {
    private let callback: (Coordinate2D) -> Void
    
    init(callback: @escaping (Coordinate2D) -> Void = {_ in }) {
        self.callback = callback
        
        super.init()
        self.manager.delegate = self
        
        self.status = self.manager.authorizationStatus
        
        self.startLocatingIfPossible()
    }
    
    let manager: CLLocationManager = {
        let ins = CLLocationManager()
        return ins
    }()
    
    @Published var status: CLAuthorizationStatus = .notDetermined
    @Published var coordinate: Coordinate2D?
    @Published var address: String?
    
    private var isLocating = false
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func goSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func startLocatingIfPossible() {
        if isLocating {
            return
        }
        
        if isAuthorized {
            manager.startUpdatingLocation()
            isLocating = true
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
        print("callbacked", status.rawValue)
        
        startLocatingIfPossible()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        isLocating = false
        
        if let _ = coordinate {
            return
        }
        
        if let first = locations.first {
            let ret = SearchWrapper.convert(first.coordinate)
            let coor = Coordinate2D(cl_coordinate: ret)
            coordinate = coor
            self.callback(coor)
        }
    }
}

extension LocationViewModel {
    var isAuthorized: Bool {
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    var blurRadius: Double {
        return isAuthorized ? 0 : 3
    }
}
