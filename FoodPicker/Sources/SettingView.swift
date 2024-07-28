import SwiftUI

struct SettingView: View {
    
    @State var isModal = false
    
    var body: some View {
        
        NavigationView{
            List{
                Section{
                    
                    NavigationLink("历史记录") {
                        HistoryView()
                    }
                    
                }
                
                Section{
                    
                    Button("分享 App") {
                        isModal = true
                    }.sheet(isPresented: $isModal) {
                       
                        HistoryView()
                    }.foregroundColor(.primary)

                    
                    
                    NavigationLink("评价与反馈") {
                        FeedbackView()
                    }
                    
                    NavigationLink("服务条款"){
                        PrivacyView()
                        
                    }
                }
            }
        }.navigationTitle("设置")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
