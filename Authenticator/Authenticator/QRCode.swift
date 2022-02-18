//
//  QRCode.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import UIKit
import AVFoundation


class QRCamera: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    private let session = AVCaptureSession()
    
    var onRead: ((String) -> Void)?

    init(onRead: @escaping (String) -> Void) {
        self.onRead = onRead
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        // カメラやマイクのデバイスそのものを管理するオブジェクトを生成（ここではワイドアングルカメラ・ビデオ・背面カメラを指定）
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)
        
        // ワイドアングルカメラ・ビデオ・背面カメラに該当するデバイスを取得
        let devices = discoverySession.devices
        
        //　該当するデバイスのうち最初に取得したものを利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)
                
                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)
                    
                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()
                    
                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)
                        
                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]
                        
                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = self.view.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        self.view.layer.addSublayer(previewLayer)
                        
                        //読み取り開始
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            if metadata.type != .qr { continue }
            
            // QRコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }
            
            //let rawReadableObjectTemp = metadata.value(forKeyPath: "_internal.basicDescriptor")! as! [String:Any]
            //let rawReadableObject = rawReadableObjectTemp["BarcodeRawData"] as? Data
            
            let dataString = metadata.stringValue
            
            
            if let string = dataString{
                // print(string)
                
                guard let url = URL(string: string) else { return }
                
                guard url.scheme == "otpauth" else { return }
                
                if let onRead = self.onRead {
                    onRead(string)
                }
                
                self.session.stopRunning()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func navigation() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
        
        let alert = UIAlertController(title:"Something went wrong", message: "Please try again later", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default, handler: {
            (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(action1)

        self.present(alert, animated: true, completion: nil)
    }
    
}
