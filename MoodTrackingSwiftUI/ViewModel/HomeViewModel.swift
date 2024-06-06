//
//  HomeViewModel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import Combine
import FirebaseFirestore

@MainActor
class HomeViewModel: ObservableObject {
    private var firestore = Firestore.firestore()
    
    @Published var dates: [Date] = []
    
    @Published var arrEmotionDetails: [MDLEmotionDetail] = []
    
    @Published var selectedDate: Date?
    
    @Published var isLoading = false
    @Published var toast: Toast?
    
    var cancellable = Set<AnyCancellable>()
      
    init() {
        generateDates()
    }
    
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        
        for i in -5..<1 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                self.dates.append(date)
            }
        }
    }
    
    func getEmotionDetailsData() async {
        isLoading = true
        do {
            try await firestore
                .collection(FICollectionName.emotionData.rawValue)
                .document(Constant.user.uid!)
                .collection(FICollectionName.emotionDetails.rawValue)
                .getDocuments()
                .documents
                .compactMap({ doc in
                    do {
                        return try doc.data(as: MDLEmotionDetail.self)
                    } catch let e {
                        isLoading = false
                        toast = Toast(message: e.localizedDescription)
                        return nil
                    }
                })
                .publisher
                .receive(on: RunLoop.main)
                .sink { [weak self] data in
                    guard let `self` = self else {
                        return
                    }
                    arrEmotionDetails.append(data)
                }
                .store(in: &cancellable)
                 
            isLoading = false
        } catch let e {
            isLoading = false
            toast = Toast(message: "Error in getting data: \(e.localizedDescription)")
        }
    }
}
