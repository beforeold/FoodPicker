import SwiftUI

struct HistoryView: View {
    
   @State var testData: Array = ["龙记米粉","蛇记米粉","虎记米粉","马记米粉"]
    var body: some View {
        List(){
            
            ForEach(testData, id: \.self) {
                name in
                HStack{
                    Image(systemName: "pin.circle")
                    Text(name)
                }
            }
            .onDelete { indexSet in
                testData.remove(at: indexSet.last ?? 0)
            }
            
            .navigationTitle("历史记录")
            

        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HistoryView()
        }
    }
}
