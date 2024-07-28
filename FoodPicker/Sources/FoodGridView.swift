import SwiftUI

struct FoodGridView: View {
    @EnvironmentObject var pickerViewModel: PickerViewModel
    
    let showsButton: Bool
    
    var body: some View {
        GeometryReader { ins in
            Text("")
        }
    }
}

struct FoodGridView_Previews: PreviewProvider {
    static var previews: some View {
        FoodGridView(showsButton: true)
    }
}
