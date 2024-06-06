//
//  HomeViewModel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    private var firestore = Firestore.firestore()
    
    @Published var dates: [Date] = []
    @Published var arrEmotionDetails: [MDLEmotionDetail] = []
    
    @Published var isLoading = false
    @Published var toast: Toast?
      
    init() {
        generateDates()
    }
    
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
    }
    
    func getEmotionDetailsData() async {
        isLoading = true
        do {
            let arrEmotionDetails = try await firestore
                .collection(FICollectionName.emotionData.rawValue)
                .document(Constant.user.uid!)
                .collection(FICollectionName.emotionDetails.rawValue)
                .getDocuments()
                .documents
                .compactMap({ doc in
                    try? doc.data(as: MDLEmotionDetail.self)
                })
            
            self.arrEmotionDetails = arrEmotionDetails
            isLoading = false
                
        } catch let e {
            isLoading = false
            toast = Toast(message: "Error in getting data: \(e.localizedDescription)")
        }
    }
}
