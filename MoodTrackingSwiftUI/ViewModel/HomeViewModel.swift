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
    @Published var showAlert = false
    
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
        arrEmotionDetails.removeAll()
        isLoading = true
        do {
            try await firestore
                .collection(FICollectionName.emotionData.rawValue)
                .document(Constant.user?.uid ?? "")
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
                    arrEmotionDetails.sort(by: {$0.createdAt! > $1.createdAt!})
                }
                .store(in: &cancellable)
                 
            isLoading = false
        } catch let e {
            isLoading = false
            toast = Toast(message: "Error in getting data: \(e.localizedDescription)")
        }
    }
    
    func deleteEmotionDetail(docId: String) async {
        isLoading = true
        do {
            try await firestore
                .collection(FICollectionName.emotionData.rawValue)
                .document(Constant.user?.uid ?? "")
                .collection(FICollectionName.emotionDetails.rawValue)
                .document(docId)
                .delete()
             
            arrEmotionDetails.removeAll(where: {$0.id == docId})
            isLoading = false
            
        } catch let e {
            isLoading = false
            toast = Toast(message: "Error in getting data: \(e.localizedDescription)")
        }
    }
    
    func toggleExpanded(for item: MDLEmotionDetail) {
        if let index = arrEmotionDetails.firstIndex(where: { $0 == item }) {
            item.expanded.toggle()
            arrEmotionDetails.removeAll(where: {$0 == item})
            arrEmotionDetails.insert(item, at: index)
        }
    }
    
    func toggleExpandedTip(for item: MDLEmotionDetail) {
        if let index = arrEmotionDetails.firstIndex(where: { $0 == item }) {
            item.expandedTip.toggle()
            arrEmotionDetails.removeAll(where: {$0 == item})
            arrEmotionDetails.insert(item, at: index)
        }
    }
    
    func logout() {
        Constant.user = nil
        try? UserDefaults.standard.set(object: Constant.user, forKey: "User")
    }
    
    
}
