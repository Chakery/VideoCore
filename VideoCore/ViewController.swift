//
//  ViewController.swift
//  VideoCore
//
//  Created by 成杰 on 16/6/15.
//  Copyright © 2016年 swiftc.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VCSessionDelegate {

    private var connectBtn: UIButton!
    private var session = VCSimpleSession(videoSize: CGSize(width: 1280, height: 720),
                                          frameRate: 30,
                                          bitrate: 1000000,
                                          useInterfaceOrientation: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(session.previewView)
        session.previewView.frame = view.bounds
        
        let btnW = CGFloat(100)
        let btnH = CGFloat(45)
        let btnX = view.bounds.width/2 - btnW/2
        let btnY = view.bounds.height - btnH
        let btnF = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        connectBtn = UIButton(frame: btnF)
        connectBtn.backgroundColor = UIColor.greenColor()
        connectBtn.addTarget(self,
                             action: #selector(onConnectBtnClicked),
                             forControlEvents: .TouchUpInside)
        connectBtn.setTitle("start", forState: .Normal)
        view.addSubview(connectBtn)
        
    }

    // MAR: - VCSessionDelegate
    
    func connectionStatusChanged(sessionState: VCSessionState) {
        
        switch session.rtmpSessionState {
        case .Starting:
            connectBtn.setTitle("Connecting", forState: .Normal)
            
        case .Started:
            connectBtn.setTitle("Disconnect", forState: .Normal)
            
        default:
            connectBtn.setTitle("Connect", forState: .Normal)
        }
    }
    
    dynamic func onConnectBtnClicked() {
    
        switch session.rtmpSessionState {
        case .None, .PreviewStarted, .Ended, .Error:
            session.startRtmpSessionWithURL("rtmp://192.168.1.107/live",
                                            andStreamKey: "livestream")
        default:
            session.endRtmpSession()
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

