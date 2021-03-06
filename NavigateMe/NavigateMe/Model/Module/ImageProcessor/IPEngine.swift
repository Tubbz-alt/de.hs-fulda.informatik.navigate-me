//
//  IPEngine.swift
//  Image Processor Engine
//
//  Created by mahbub on 2/16/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation
import CoreImage
import TesseractOCR

class IPEngine {
    
    static var imageViewFrame: CGRect? = nil
    static var parentViewFrames: [CGRect]? = nil
    
    // [<button-tag> : (<image-frame>, [<button-title> : <button-frame>])]
    // [<geb + floor + raum>  : (floor-image-frame, [<raum-title> : <raum-title-frame>])]
    static var floorPlans = [Int : (image: CIImage, buttonFrames: [Int : CGRect])]()
    
    static func processImage() {
        
        guard imageViewFrame != nil else {
            
            print("\nImage Processor Error: Image view frame is not defined.\n")
            return
        }
        
        let geb = "46(E)"
        
        // geb int value = sum of ascii values of geb nummer charectars
        let gebTag = geb.sumOfAsciiValues()
        
        [0, 1, 3].forEach { floor in
            
            // tag = geb tag + floor number + raum number (added in ViewController during button creation)
            let buttonTag = gebTag + floor
            let floorPlan = processImage(of: floor)
            
            floorPlans[buttonTag] = floorPlan
        }
    }

    static private func processImage(of floor: Int) -> (image: CIImage, buttonFrames: [Int : CGRect]) {
        
        var floorPlanCIImage = CIImage(contentsOf: Bundle.main.url(forResource: "E\(floor)", withExtension: "png")!)!
        
        let orginalFloorPlanWidth = floorPlanCIImage.extent.width
        let orginalFloorPlanHeight = floorPlanCIImage.extent.height
        
        let imageContext = CIContext()
        let textDetectorInFloorPlan = CIDetector(ofType: CIDetectorTypeText, context: imageContext, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
        let textFeatures = textDetectorInFloorPlan.features(in: floorPlanCIImage)
        
        // doing image transformation in device coordinate system
        let scaleX = imageViewFrame!.width / orginalFloorPlanWidth
        let scaleY = imageViewFrame!.height / orginalFloorPlanHeight
        let affineScaleTransform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
        var i = 0, buttonFrames = [Int : CGRect]()
        
        for textIndex in textFeatures.indices {
            
            let textFeature = textFeatures[textIndex] as! CITextFeature
            
            i += 1
            
            let textRect = textFeature.bounds.insetBy(dx: CGFloat(-5), dy: CGFloat(-5))
            
            if let tesseract = G8Tesseract(language: "eng") {
                
                let textCGImage = imageContext.createCGImage(floorPlanCIImage, from: textRect)!
                let image = UIImage(cgImage: textCGImage).scaleImage(640)!
                
                tesseract.engineMode = .tesseractCubeCombined
                tesseract.pageSegmentationMode = .auto
                tesseract.image = image.g8_blackAndWhite()
                tesseract.recognize()
                let ocrText = tesseract.recognizedText.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard let raum = Int(ocrText) else {
                
                    continue
                }
                
                let buttonOrigin = CGPoint(x: textRect.origin.x, y: textRect.maxY)
                let translationX = CGFloat(0)
                let translationY = orginalFloorPlanHeight - (CGFloat(2) * buttonOrigin.y)
                let affineTranslationTransform = CGAffineTransform(translationX: translationX, y: translationY)
                
                var buttonFrame = CGRect(origin: buttonOrigin, size: textRect.size)
                
                // doing button transformation in device coordinate system
                buttonFrame = buttonFrame
                                        .applying(affineTranslationTransform)
                                        .applying(affineScaleTransform)
                
                buttonFrame.origin.x += imageViewFrame!.origin.x
                buttonFrame.origin.y += imageViewFrame!.origin.y
                
                if parentViewFrames != nil {
                    
                    buttonFrame.origin.x += parentViewFrames!.reduce(CGFloat(0), { (result, frame) in result + frame.origin.x })
                    buttonFrame.origin.y += parentViewFrames!.reduce(CGFloat(0), { (result, frame) in result + frame.origin.y })
                }
                
                buttonFrames[raum] = buttonFrame
            }
        }
        
        floorPlanCIImage = floorPlanCIImage.transformed(by: affineScaleTransform)
        
        return (floorPlanCIImage, buttonFrames)
    }

}
