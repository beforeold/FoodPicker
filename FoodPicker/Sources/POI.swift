import Foundation
import CoreLocation
import AMapSearchKit

typealias Modelable = Codable

struct Coordinate2D: Modelable {
    var latitude: Double
    var longitude: Double
    
    init(cl_coordinate: CLLocationCoordinate2D) {
        latitude = cl_coordinate.latitude
        longitude = cl_coordinate.longitude
    }
    
    var cl_coordinate: CLLocationCoordinate2D {
        return .init(latitude: latitude,
                     longitude: longitude)
    }
}

typealias POI = AMapPOI

extension POI {
    func avatarURL(width: Int, height: Int) -> URL? {
        guard var firstUrlString = self.images?.first?.url else {
            return nil
        }
        
        if !firstUrlString.contains("?") {
            firstUrlString += "?"
        }
        
        firstUrlString += "operate=merge&w=\(width)&h=\(height)&position=5"
        
        return URL(string: firstUrlString)
    }
    private func buildAvatarURL(width: Int, height: Int) -> URL? {
        guard var firstUrlString = self.images?.first?.url else {
            return nil
        }
        
        if !firstUrlString.contains("?") {
            firstUrlString += "?"
        }
        
        firstUrlString += "operate=merge&w=\(width)&h=\(height)&position=5"
        
        return URL(string: firstUrlString)
    }
    
    var imageURLs: [URL]? {
        return self.images?.compactMap { ins -> URL? in
            guard let urlString = ins.url else { return nil }
            return URL(string: urlString)
        }
    }
    
    var baseInfo: String {
        var components = [String]()
        if let rating = extensionInfo?.rating, rating > 0 {
            components.append("⭐️\(rating)")
        }
        
        if let lastType = type?.components(separatedBy: ";").last {
            components.append(lastType)
        }
        
        if let price = extensionInfo?.cost, price > 0 {
            let fomater = NumberFormatter()
            fomater.allowsFloats = false
            if let string = fomater.string(from: price as NSNumber) {
                components.append("\(string) 元/人")
            }
        }
        
        return components.joined(separator: " · ")
    }
    
    func distranceInfo(includesAddress: Bool) -> String {
        var compoenents = [String]()
        compoenents.append("距你 \(distance)m")
        
        if let area = businessArea, area.count > 0 {
            compoenents.append(area)
        }
        
        if includesAddress, let addr = address, addr.count > 0 {
            compoenents.append(addr)
        }
        
        return compoenents.joined(separator: " · ")
    }
    
    var landingUrl: URL? {
        guard let uid = self.uid else { return nil }
        
        let urlString = "https://m.amap.com/detail/index/poiid=\(uid)"
        return URL(string: urlString)
    }
    
    var telURLs: [(tel: String, url: URL)]? {
        return self.tel?
            .components(separatedBy: ";")
            .filter {
                return $0.count > 0
            }
            .compactMap { tel in
                let urlString = "tel://\(tel)"
                guard let url = URL(string: urlString) else {
                    return nil
                }
                
                return (tel: tel, url: url)
            }
    }
}

extension POI {
    var isNiceRating: Bool {
        guard let rating = extensionInfo?.rating else {
            return false
        }
        
        return rating == 0 || rating > 3.0
    }
}
