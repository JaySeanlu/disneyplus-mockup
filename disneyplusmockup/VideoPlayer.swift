//
//  SuccessfulPlayViewController.swift
//  disneyplusmockup
//
//  Created by Jason Lu on 9/21/20.
//

import UIKit
import AVKit

class VideoPlayer: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1.0)
        return view
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "icon-pause")
        //button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        //button.isHidden = true
        return button
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        if isPlaying {
            //notice how this is a instance variable of the Parent ViewController
            player?.pause()
            flashButton(button: pausePlayButton, imageName: "icon-pause")
            //pausePlayButton.setImage(UIImage(named: "icon-play"), for: .normal)
        }
        
        else {
            player?.play()
            flashButton(button: pausePlayButton, imageName: "icon-play")
            //pausePlayButton.setImage(UIImage(named: "icon-pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    func flashButton(button: UIButton, imageName: String) {

        UIView.animate(withDuration: 1.0, animations: {
            button.alpha = 0
            button.setImage(UIImage(named: imageName), for: .normal)
            }, completion: {finished in
                UIButton.animate(withDuration: 1.0, animations: {
                    button.alpha = 1
                    })
                button.setImage(nil, for: .normal)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        activityIndicatorView.frame = frame
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    var player: AVPlayer?
    
    private func setupPlayerView() {
        if let path = Bundle.main.path(forResource: "video", ofType: "mp4") {

            player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            playerLayer.videoGravity = .resizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            player?.play()
            
            //observes when the video is playing or not
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)

        }
        else {
            print("Got a nil unwrap")
        }
    }
    
    //dictates the state of the AVVideoPlayer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //Video is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            //pausePlayButton.tintColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoPlayerScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.addLogoToNavigationBarItem()
        view.backgroundColor = .black
        let screenSize: CGRect = UIScreen.main.bounds
        
        if UIApplication.shared.windows.filter({$0.isKeyWindow}).first != nil {
            let height = screenSize.width * 9/16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: screenSize.width, height: height)
            let videoPlayerView = VideoPlayer(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.intrinsicContentSize.height)! + 50).isActive = true
            videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            videoPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        }
    }
}

