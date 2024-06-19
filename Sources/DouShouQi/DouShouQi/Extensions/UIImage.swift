//
//  UIImage.swift
//  DouShouQi
//
//  Created by Arthur Valin on 19/06/2024.
//

import Foundation
import Vision
import UIKit

extension UIImage {
    func faceCrop(margin: CGFloat = 200) -> UIImage {
        var resultImage = self
        if let cgimage = self.cgImage {
            let request = VNDetectFaceRectanglesRequest { request, error in
                if error != nil { return }
                guard let results = request.results, !results.isEmpty else { return }
                
                var faces = [VNFaceObservation]()
                for result in results {
                    if let face = result as? VNFaceObservation {
                        faces.append(face)
                    }
                }
                                
                let croppingRect = self.getCroppingRect(for: faces, margin: margin)
                let faceImage = cgimage.cropping(to: croppingRect)
                guard let result = faceImage else { return }
                
                resultImage = UIImage(cgImage: result)
            }

            #if targetEnvironment(simulator)
                if #available(iOS 17.0, *) {
                  let allDevices = MLComputeDevice.allComputeDevices

                  for device in allDevices {
                    if(device.description.contains("MLCPUComputeDevice")){
                        request.setComputeDevice(.some(device), for: .main)
                      break
                    }
                  }

                } else {

                  request.usesCPUOnly = true
                }
            #endif
            
            do {
                try VNImageRequestHandler(cgImage: cgimage, options: [:]).perform([request])
            } catch let error {
                print(error)
            }
        }
        
        return resultImage
    }
    
    
    private func getCroppingRect(for faces: [VNFaceObservation], margin: CGFloat) -> CGRect {
            
            var totalX = CGFloat(0)
            var totalY = CGFloat(0)
            var totalW = CGFloat(0)
            var totalH = CGFloat(0)
                        
            var minX = CGFloat.greatestFiniteMagnitude
            var minY = CGFloat.greatestFiniteMagnitude
            let numFaces = CGFloat(faces.count)
                        
            for face in faces {
                        
                let w = face.boundingBox.width * self.size.width
                let h = face.boundingBox.height * self.size.height
                let x = face.boundingBox.origin.x * self.size.width
                let y = (1 - face.boundingBox.origin.y) * self.size.height - h
                
                totalX += x
                totalY += y
                totalW += w
                totalH += h
                minX = .minimum(minX, x)
                minY = .minimum(minY, y)
            }
                        
            let avgX = totalX / numFaces
            let avgY = totalY / numFaces
            let avgW = totalW / numFaces
            let avgH = totalH / numFaces
                        
            let offset = margin + avgX - minX
                        
            return CGRect(x: avgX - offset, y: avgY - offset, width: avgW + (offset * 2), height: avgH + (offset * 2))
        }
    
}
