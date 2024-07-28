import Foundation
import SwiftUI

struct ShareView: UIViewControllerRepresentable{
    
    var items: [Any]
    {
        
        let appid = "1631977980"
        
        return [appid]
    }

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return activityVC
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
//    func makeItems(_ message: String? = nil) -> [Any]{
//
//        let appid = "1631977980"
//        let url = URL(string: "https://apps.apple.com/cn/app/%E4%BB%8A%E5%A4%A9%E5%90%83%E7%A5%9E%E9%A9%AC/id\(appid)")
////       var  itemsArr = mutablearray
//
//        if let msg = message{
//            itemsArr.append(msg)
//        }
//        return itemsArr
//    }
    
    
}
