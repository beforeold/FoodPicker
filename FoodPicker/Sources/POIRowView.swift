import SwiftUI

struct POIRowView: View {
  let poi: POI

  static let imageWidth = 80 as CGFloat
  static let imageHeight = 60 as CGFloat

  var body: some View {
    HStack {
      AsyncImage(
        url: poi.avatarURL(
          width: Int(Self.imageWidth),
          height: Int(Self.imageHeight)
        )
      )
//      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: Self.imageWidth, height: Self.imageHeight)
      .clipped()

      VStack(alignment: .leading, spacing: 6) {
        Text(poi.name).font(.headline)
        Text(poi.baseInfo).font(.callout)
        Text(poi.distranceInfo(includesAddress: true)).font(.caption)
      }
      .lineLimit(nil)
    }
  }
}

struct POIRowView_Previews: PreviewProvider {
  static var previews: some View {
    POIRowView(poi: .init())
  }
}
