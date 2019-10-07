//
//  TESTGSDViewController.swift
//  AnderserRequest
//
//  Created by admin on 04.10.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class TESTGSDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //doLongAsyncTaskInSerialQueue()
        doLongSyncTaskInSerialQueue()
    }
    
    func doLongSyncTaskInSerialQueue() {
        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        for i in 1...5 {
            serialQueue.sync {
                if Thread.isMainThread{
                    print("task running in main thread")
                }else{
                    print("task running in background thread")
                }
                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                let _ = try! Data(contentsOf: imgURL)
                print("\(i) completed downloading")
            }
        }
    }
    
//    func doLongAsyncTaskInSerialQueue() {
//
//       let serialQueue = DispatchQueue(label: "com.queue.Serial")
//          for i in 1...5 {
//            serialQueue.async {
//
//                if Thread.isMainThread{
//                    print("task running in main thread")
//                }else{
//                    print("task running in background thread")
//                }
//                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
//                let _ = try! Data(contentsOf: imgURL)
//                print("\(i) completed downloading")
//            }
//        }
//    }
}
