//
//  AddCouponOCR.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/01.
//

import UIKit
import SwiftUI
import Vision
import VisionKit
import CropViewController

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                // parent.onImagePicked(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

struct ImageCropper: UIViewControllerRepresentable{
    
    @Binding var image: UIImage?
    @Binding var visible: Bool
    
    var done: (UIImage) -> Void
    var onImagePicked: (UIImage) -> Void
    
    class Coordinator: NSObject, CropViewControllerDelegate{
        let parent : ImageCropper
        
        
        
        init(_ parent: ImageCropper){
            self.parent = parent
        }
        
        
        //編集完了時(done）
        func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
            
            print("didcroped")
            parent.done(image)
            parent.onImagePicked(image)
            self.parent.visible = false
        }
        
        //cancel時
        func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation{
                    self.parent.visible = false
                }
            }
        }
    }//class
    
    func makeCoordinator() -> Coordinator {
         return Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let img = self.image ?? UIImage()
        let cropViewController = CropViewController(image:img)
        cropViewController.delegate = context.coordinator
        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.aspectRatioPickerButtonHidden = false
        cropViewController.aspectRatioLockEnabled = false
        cropViewController.resetAspectRatioEnabled = true
        return cropViewController
    }
    
}

func recognizeText(from image: UIImage, recognizedText: Binding<String>, largestText: Binding<String?>) {
    guard let cgImage = image.cgImage else { return }
    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("error:\(error)")
            return
        }
        
        // OCR結果を observation として取得
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        var allStrings: [String] = []
        var mayLargestText: String?
        var largestArea: CGFloat = 0
        
        for observation in observations {
            if let candidate = observation.topCandidates(1).first {
                let text = candidate.string
                allStrings.append(text)
                
                let box = observation.boundingBox
                let area = box.height
                
                if area > largestArea {
                    largestArea = area
                    mayLargestText = text
                    print("大きいサイズのテキスト更新：\(mayLargestText),\(largestArea)")
                }
            }
        }

        // 認識された文字列を配列に変換
        let recognizedStrings: [String] = observations.compactMap { observation in
            // 候補の中で一番精度が高い文字列を取得
            return observation.topCandidates(1).first?.string
        }
        if let LargestText = mayLargestText {
            largestText.wrappedValue = LargestText
        }
        // 1つの文字列として結合
        let resultText = recognizedStrings.joined(separator: "\n")
        print("resultText:\(resultText)")
        recognizedText.wrappedValue = resultText
        
    }

    request.recognitionLanguages = ["ja", "en"]
    request.recognitionLevel = .accurate

    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])
    
}


