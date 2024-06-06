//
//  GeminiHelper.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import Foundation
import GoogleGenerativeAI
 

class GeminiHelper {
    static let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: Constant.geminiAPIKey, systemInstruction: "You are good at giving tip in 2 lines don't question.")
    
    static func generate(prompt: String) async -> GenerateContentResponse? {
        do {
            let response = try await model.generateContent(prompt)
            return response
        } catch let e {
            AppPrint.print(e.localizedDescription)
            return nil
        }
    }
}
