import Foundation
import AVFoundation
import UIKit
import SwiftUI

class VideoPlayerUIView: UIView{
    let player: AVQueuePlayer
    let playerLayer: AVPlayerLayer = AVPlayerLayer()
    let looper: AVPlayerLooper
    let closeBtn: UIButton
    
    @Binding var isPresented: Bool
    
    init(frame: CGRect, isPresented: Binding<Bool>){
        let url = Bundle.main.url(forResource: "beauty", withExtension: "mp4")
        let asset = AVAsset(url: url!)
        let item = AVPlayerItem(asset: asset)
        
        self.player = AVQueuePlayer(playerItem: item)
        self.looper = AVPlayerLooper(player: player, templateItem: item)
        self.closeBtn = UIButton(frame: CGRect(x: 20,y: 64, width: 30, height: 30))
        self.closeBtn.setBackgroundImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        self._isPresented = isPresented
        super.init(frame: frame)
        
        layer.addSublayer(playerLayer)
        self.playerLayer.player = self.player
        self.playerLayer.backgroundColor = UIColor.black.cgColor
        
        self.player.play()
        self.player.isMuted = true
        
        addSubview(closeBtn)
        self.closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    @objc func closeBtnClick(){
        self.removeFromSuperview()
        
    
    }
 
    
}

struct VideoPlayerView: UIViewRepresentable{
    @Binding var isPresented: Bool
    
    func makeUIView(context: Context) -> VideoPlayerUIView {

        let uiView = VideoPlayerUIView(frame: .zero,
                                       isPresented: $isPresented)

        return uiView
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) {
        
    }
    

    
    
}
