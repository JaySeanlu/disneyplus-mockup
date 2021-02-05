////
////  RemoteViewController.swift
////  disneyplusmockup
////
////  Created by Jason Lu on 9/21/20.
////
//
//import UIKit
//
//class topSection: UIImageView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class RemoteViewController: UIViewController {
//
//    lazy var btn: UIButton = {
//        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        btn.center.x = view.center.x
//        btn.center.y = view.center.y*1.55
//        btn.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
//        return btn
//    }()
//
//    lazy var topView: topSection = {
//        let frame = CGRect(x: 15, y: self.navigationController!.navigationBar.frame.size.height+30, width: view.frame.width-30, height: view.frame.width)
//        let topView = topSection(frame: frame)
//        topView.contentMode = .scaleToFill
//        topView.layer.cornerRadius = 8.0
//        topView.clipsToBounds = true
//        return topView
//    }()
//
//    lazy var titleLabel: UILabel = {
//        let frame = CGRect(x: 0, y: 0, width: 200, height: 21)
//        let label = UILabel(frame: frame)
//        label.center.x = view.center.x
//        label.center.y = view.center.y + 120
//        label.font = label.font.withSize(20)
//        label.textAlignment = NSTextAlignment.center
//        label.text = ""
//        label.textColor = .white
//        return label
//    }()
//
//    lazy var durationLabel: UILabel = {
//        let frame = CGRect(x: 0, y: 0, width: 200, height: 21)
//        let label = UILabel(frame: frame)
//        label.font = label.font.withSize(16)
//        label.center.x = view.center.x
//        label.center.y = view.center.y + 150
//        label.textAlignment = NSTextAlignment.center
//        label.text = ""
//        label.textColor = .white
//        return label
//    }()
//
//    var playing: Bool = Bool()
//    //var currModel: receivedMetaDataModel = receivedMetaDataModel()
//    var intervalSensor: Timer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
//
//        self.addLogoToNavigationBarItem()
//
//        view.backgroundColor = .black //UIColor(red: 101/256, green: 115/256, blue: 126/256, alpha: 1.0)
//        view.addSubview(topView)
//        view.addSubview(titleLabel)
//        view.addSubview(durationLabel)
//
//        //Our default photo will be the D+ logo
//        topView.load(stringURL: "https://i.ytimg.com/vi/vcr-u5ot0Xg/maxresdefault.jpg")
//        view.addSubview(btn)
//
//
//
//
//        btn.setImage(setInitialButton(), for: .normal)
//        intervalSensor = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getSingleRequest), userInfo: nil, repeats: true)
//    }
//
//    @objc func getSingleRequest() {
//        makeGetRequest { results, error in
//            guard let results = results, error == nil else {
//                print("Failed to load the data")
//                return
//            }
//            //Use results here in the case of a successful load
//            //self.currModel = results
//            let readInStatus = results.status
//
//            self.checkAndUpdatePlayButton(status: readInStatus)
//            self.checkAndUpdateContent(readInObject: results)
//
//
//            //update if any our class variables!= read in message JSON
//        }
//
//        //print(self.currModel)
//    }
//
//    func checkAndUpdateContent(readInObject: receivedMetaDataModel) {
//        let currentObject: receivedMetaDataModel = self.currModel
//        let readInTitle = readInObject.metadata.title
//
//        if(readInTitle != currentObject.metadata.title) {
//            self.currModel = readInObject
//            let updateImageURL:String = readInObject.metadata.imageUrl
//            self.topView.load(stringURL: updateImageURL)
//            self.titleLabel.text = readInObject.metadata.title
//            self.durationLabel.text = readInObject.metadata.duration
//        }
//
//    }
//
//    //readInStatus -> ("pause", "play"
//    func checkAndUpdatePlayButton(status: String) {
//        let currentStatus: Bool = self.playing
//
//        let readInPlayingBool: Bool = status == "play" ? true : false
//
//        if currentStatus != readInPlayingBool {
//            self.playing = readInPlayingBool
//
//            if playing == true {
//                btn.setImage(UIImage(named: "icon-pause"), for: .normal)
//            }
//
//            else {
//                btn.setImage(UIImage(named: "icon-play"), for: .normal)
//            }
//        }
//
//    }
//
//    func setInitialButton() -> UIImage {
//        if playing == false {
//            return UIImage(named: "icon-play")!
//        }
//
//        return UIImage(named: "icon-pause")!
//    }
//
//    @objc func pauseButtonPressed() {
//        if playing == true {
//            print("Pressed the pause Button")
//            postRequest(status: "pause")
//
//            //
////            playing = false
////            btn.setImage(UIImage(named: "icon-play"), for: .normal)
//        }
//
//        else if playing == false {
//            print("Pressed the play Button")
//            postRequest(status: "play")
//
////            playing = true
////            btn.setImage(UIImage(named: "icon-pause"), for: .normal)
//        }
//    }
//
//
//    //status is either "pause" or "play"
//    func postRequest(status: String) {
//        let baseURL = URL(string: "http://ec2-3-90-84-173.compute-1.amazonaws.com/playback/1")!
//
//        var request = URLRequest(url: baseURL)
//        request.httpMethod = "PUT"
//        request.allHTTPHeaderFields = [
//            "Content-Type": "application/json",
//            "Accept": "application/json",
//        ]
//        //request.allHTTPHeaderFields = ["status" : "pause"]
//
//        let jsonDictionary: [String: String] = [
//            "status" : status,
//        ]
//
//        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
//
//        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
//            if let error = error {
//                print("Error making PUT request: \(error.localizedDescription)")
//                return
//            }
//
//            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
//                guard responseCode == 200 else {
//                    print("Invalid response code: \(responseCode)")
//                    return
//                }
//
//                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
//                    print("Response JSON data = \(responseJSONData)")
//
//                    //update your UI for the button here
//                    if status == "pause" {
//                        self.playing = false
//                        DispatchQueue.main.async { // Make sure you're on the main thread here
//                            self.btn.setImage(UIImage(named: "icon-play"), for: .normal)
//                        }
//
//                    }
//
//                    else if status == "play" {
//                        self.playing = true
//                        DispatchQueue.main.async { // Make sure you're on the main thread here
//                            self.btn.setImage(UIImage(named: "icon-pause"), for: .normal)
//                        }
//                    }
//                }
//            }
//        }.resume()
//    }
//
//    func makeGetRequest(completion: @escaping (receivedMetaDataModel?, Error?) -> Void) {
//        let url = URL(string: "http://ec2-3-90-84-173.compute-1.amazonaws.com/playback/1")!
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completion(nil, error)
//                }
//                print("API Response Failed")
//                print(error!)
//                return
//            }
//
//            do {
//                let returnValue = try JSONDecoder().decode(receivedMetaDataModel.self, from: data)
//                let results = returnValue
//                DispatchQueue.main.async {
//                    completion(results, error)
//                }
//            } catch {
//                print("Error took place\(error.localizedDescription).")
//                DispatchQueue.main.async {
//                    self.topView.load(stringURL: "https://i.ytimg.com/vi/vcr-u5ot0Xg/maxresdefault.jpg")
//                    self.btn.setImage(UIImage(named: "icon-play"), for: .normal)
//                    self.titleLabel.text = ""
//                    self.durationLabel.text = ""
//                }
//
//            }
//        }.resume()
//    }
//}
//
//
