import SwiftUI

@main
struct FoodPickerApp: App {
    let pickerViewModel = PickerViewModel()
    let locationViewModel: LocationViewModel
    
    init() {
        locationViewModel = LocationViewModel { [weak pickerViewModel] coordinate in
            pickerViewModel?.scan(coordinate: coordinate)
        }
        
        Launcher.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FoodPickerView()
            }
                .environmentObject(pickerViewModel)
                .environmentObject(locationViewModel)
        }
    }
}
