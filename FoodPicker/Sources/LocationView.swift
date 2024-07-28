import SwiftUI

struct LocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    struct LocationButton: View {
        let systemImageName: String
        let title: String
        let action: () -> Void
        
        var body: some View {
            HStack {
                Spacer()
                
                Button(action: action) {
                    HStack {
                        Image(systemName: systemImageName)
                        Text(title)
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                }
                .background(Color.accentColor)
                .cornerRadius(6)
                
                Spacer()
            }
        }
    }
    
    var body: some View {
        if locationViewModel.status == .notDetermined {
            LocationButton(systemImageName: "location",
                           title: "精确位置授权申请\n\n点击按钮获取当前的位置") {
                locationViewModel.requestAuthorization()
            }
        }
        else if locationViewModel.status == .restricted || locationViewModel.status == .denied {
            LocationButton(systemImageName: "location.slash",
                           title: "您的授权未开启，暂时无法使用。\n\n点击前往设置 app") {
                locationViewModel.goSetting()
            }
        }
        else {
            // authorized
            EmptyView()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
