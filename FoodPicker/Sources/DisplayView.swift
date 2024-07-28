import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var pickerViewModel: PickerViewModel
    
    let poi: POI
    
    @State
    private var isDetailing = false
    
    private static var imageWidth: CGFloat {
        return UIScreen.main.bounds.width - 2 * 30
    }
    
    private static var imageHeight: CGFloat {
        return imageWidth * 3.0 / 4.0
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(poi.name).font(.title)
                
                topImages()
                
                Divider()
                Text(poi.baseInfo).font(.body)
                Text(poi.distranceInfo(includesAddress: false)).font(.body)
                if let addr = poi.address {
                    Text(addr).font(.body)
                }
                
                if let tels = poi.telURLs, tels.count > 0 {
                    Divider()
                    ForEach(tels, id: \.0) { tel in
                        Link("电话：\(tel.tel)",
                             destination: tel.url)
                    }
                }
                
                Divider()
                HStack {
                    Spacer()
                    Button("详情 >") {
                        isDetailing = true
                    }
                    
                }
            }
            .padding()
            .lineLimit(nil)
        }
        .sheet(isPresented: $isDetailing) {
            if let landingUrl = poi.landingUrl {
                SafariView(url: landingUrl)
            }
        }
    }
    
    @ViewBuilder
    func topImages() -> some View {
        if let images = poi.imageURLs, images.count > 0 {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { url in
                      AsyncImage(url: url)
//                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Self.imageWidth, height: Self.imageHeight)
                            .clipped()
                    }
                }
            }
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView(poi: .init())
    }
}
