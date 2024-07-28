import Foundation
import SwiftUI

class PickerViewModel: ObservableObject {
    enum PickerState {
        case locating
        case scaning
        case failed(SearchWrapper.SearchError)
        case done
    }
    
    @Published var state = PickerState.locating
    @Published var isResulting = false
    @Published var isRandom = false
    
    private(set) var pois = [POI]()
    
    var pickedOne: POI {
        return pois.first!
    }
    
    func scan(coordinate: Coordinate2D) {
        self.state = .scaning
        
        let start = CFAbsoluteTimeGetCurrent()
        SearchWrapper.request(coordinate: coordinate) { [weak self] result in
            let span = CFAbsoluteTimeGetCurrent() - start
            let needDeplay = span < 3
            
            let work = {
                guard let self = self else { return }
                
                withAnimation(.spring()) {
                    switch result {
                    case .success(let pois):
                        self.pois = pois
                        self.state = .done
                    case .failure(let error):
                        self.pois = []
                        self.state = .failed(error)
                    }
                }
            }
            
            if needDeplay {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: work)
            }
            else {
                work()
            }
        }
    }
}
