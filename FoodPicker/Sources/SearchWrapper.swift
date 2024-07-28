import Foundation
import AMapSearchKit

struct SearchConstants {
    static let radius = 1000
    static let maxPageNo = 5
}

class SearchWrapper: NSObject {
    typealias Completion = (Result<[POI], SearchError>) -> Void
    
    class Box<T> {
        var base: T?
    }
    
    enum SearchError: Error {
        case failed
        case noData
    }
    
    static func request(coordinate: Coordinate2D,
                        maxPageNo: Int = SearchConstants.maxPageNo,
                        radius: Int = SearchConstants.radius,
                        completion: @escaping Completion) {
        let range = 0..<maxPageNo
        let ret: [Box<Result<[POI], SearchError>>] = range.map { _ in Box() }
        
        let group = DispatchGroup()
        range.forEach { index in
            group.enter()
            let wrapper = SearchWrapper(coordinate: coordinate,
                                        radius: radius,
                                        pageNo: index + 1)
            wrapper.start { result in
                ret[index].base = result
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            let pois: [POI] = ret.reduce([]) { partialResult, box in
                let value = try? box.base?.get()
                return partialResult + (value ?? [])
            }
            
            if pois.count > 0 {
                completion(.success(pois))
                return
            }
            
            let allFailed = ret.allSatisfy { box in
                guard let result = box.base else { return false }
                guard case .failure(let error) = result else { return false }
                return error == .failed
            }
            
            if allFailed {
                completion(.failure(.failed))
            }
            else {
                completion(.failure(.noData))
            }
        }
    }
    
    let coordinate: Coordinate2D
    let pageNo: Int
    let radius: Int
    var completion: Completion = { _ in }
    let search = AMapSearchAPI()
    
    init(coordinate: Coordinate2D,
         radius: Int,
         pageNo: Int) {
        self.coordinate = coordinate
        self.pageNo = pageNo
        self.radius = radius
        
        super.init()
        
        self.search?.delegate = self
    }
    
    func start(completion: @escaping Completion) {
        self.completion = { result in
            completion(result)
            
            // retain self, clear self after completion called
            self.completion = { _ in }
        }
        
        let request = AMapPOIAroundSearchRequest()
        request.location = {
            let point = AMapGeoPoint()
            point.latitude = coordinate.latitude
            point.longitude = coordinate.longitude
            return point
        }()
        request.types = "快餐厅|中餐厅";
        request.radius = radius;
        request.offset = 25;
        request.page = pageNo;
        
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = true;
        
        self.search?.aMapPOIAroundSearch(request)
    }
    
    deinit {
        print("SearchWrapper deinit")
    }
    
}

extension SearchWrapper: AMapSearchDelegate {
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        self.completion(.failure(.failed))
    }
    
    
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if let pois = response?.pois.filter({ $0.isNiceRating }),
           pois.count > 0 {
            self.completion(.success(pois))
        }
        else {
            self.completion(.failure(.noData))
        }
    }
}
import AMapFoundationKit
import AMapSearchKit

#warning ("❌ input your apiKey here")

private let APIKey = "";

extension SearchWrapper {
    static func setup() {
        AMapServices.shared().apiKey = APIKey
        
        AMapSearchAPI.updatePrivacyShow(.didShow, privacyInfo: .didContain)
        AMapSearchAPI.updatePrivacyAgree(.didAgree)
    }
}

extension SearchWrapper {
    static func convert(_ gps: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return AMapCoordinateConvert(gps, AMapCoordinateType.GPS)
    }
}
