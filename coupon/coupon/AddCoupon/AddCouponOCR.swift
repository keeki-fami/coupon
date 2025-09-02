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

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    var onImagePicked: (UIImage) -> Void
    
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
                parent.onImagePicked(uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

func recognizeText(from image: UIImage, recognizedText: Binding<String>) {
    guard let cgImage = image.cgImage else { return }

    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("error:\(error)")
            return
        }
        
        // OCR結果を observation として取得
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

        // 認識された文字列を配列に変換
        let recognizedStrings: [String] = observations.compactMap { observation in
            // 候補の中で一番精度が高い文字列を取得
            return observation.topCandidates(1).first?.string
        }

        // 1つの文字列として結合
        let resultText = recognizedStrings.joined(separator: "\n")
        print("resultText:\(resultText)")
        recognizedText.wrappedValue = resultText
        // OCR結果処理
    }

    request.recognitionLanguages = ["ja", "en"]
    request.recognitionLevel = .accurate

    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    try? handler.perform([request])
}


