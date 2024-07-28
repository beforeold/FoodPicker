import SwiftUI
import MapKit

class Coordinator: NSObject, CLLocationManagerDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
}

struct MapView: UIViewRepresentable {
    static let radarRadius: CGFloat = 150
    
    class RadarMapView: UIView {
        let radar: RadarView = {
            let radar = RadarView.scanRadarView(withRadius: MapView.radarRadius,
                                                 angle: 60,
                                                 radarLineNum: 5,
                                                 hollowRadius:0)
            radar.isUserInteractionEnabled = false
            
            let isDark = UITraitCollection.current.userInterfaceStyle == .dark
            let value: CGFloat = isDark ? 1 : 0.5
            let color = UIColor(red: value, green: value, blue: value, alpha: 0.5)
            radar.radarLineColor = color
            radar.startColor = color
            radar.endColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
            
            return radar
        }()
        
        let mapView: MKMapView = {
            let ins = MKMapView()
            ins.isScrollEnabled = false
            ins.isRotateEnabled = false
            ins.isPitchEnabled = false
            ins.isZoomEnabled = false
            
            return ins
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(mapView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            mapView.frame = self.bounds
        }
    }
    
    @EnvironmentObject var pickerViewModel: PickerViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    private func createMap() -> RadarMapView {
        RadarMapView()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIView(_ uiView: RadarMapView, context: UIViewRepresentableContext<MapView>) {
        update(map: uiView)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> RadarMapView {
        let map = createMap()
        update(map: map)
        
        return map
    }

    private func update(map: RadarMapView) {
        
        if let coordinate = locationViewModel.coordinate {
            let center = coordinate.cl_coordinate
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            map.mapView.setRegion(region,
                                  animated: true)
        }
        
        let radar = map.radar
        
        if case .scaning = pickerViewModel.state  {
            radar.showTargetView(map)
            radar.translatesAutoresizingMaskIntoConstraints = false
            radar.centerXAnchor.constraint(equalTo: map.centerXAnchor).isActive = true
            radar.centerYAnchor.constraint(equalTo: map.centerYAnchor).isActive = true
            radar.widthAnchor.constraint(equalToConstant: 2 * Self.radarRadius).isActive = true
            radar.heightAnchor.constraint(equalToConstant: 2 * Self.radarRadius).isActive = true
            
            radar.startAnimatian()
        }
        else {
            radar.stopAnimation()
            radar.dismiss()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .blur(radius: 3, opaque: true)
            .environmentObject({ () -> PickerViewModel in
               let picker = PickerViewModel()
                picker.state = .scaning
                
                return picker
            }())
            .environmentObject(LocationViewModel())
    }
}
