import SwiftUI

struct FoodListView: View {
    var isEditable: Bool = false
    
    @Binding var pois: [POI]
    
    @State
    private var isDisplaying = false
    
    @State
    private var displayingPOI: POI?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(pois, id: \.uid) { poi in
                POIRowView(poi: poi)
                    .onTapGesture {
                        displayingPOI = poi
                        isDisplaying = true
                    }
            }
            
            randomButton()
                .padding(.bottom, 20)
        }
        .navigationTitle("周边餐厅")
        .sheet(isPresented: $isDisplaying) {
            if let displayingPOI = displayingPOI {
                DisplayView(poi: displayingPOI)
            }
            else {
                Text("请先选择一个餐厅")
            }
        }
    }
    
    func randomButton() -> some View {
        return RandomButton {
            displayingPOI = pois.randomElement()
            isDisplaying = true
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(pois: .constant([]))
    }
}
