//
//  EmotionQAViewModel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import Combine
import FirebaseFirestore
import SwiftUI

@MainActor
class EmotionQAViewModel: ObservableObject {
    
    private var firestore = Firestore.firestore()
      
    @Published var arrMood = [MDLMood]()
    @Published var originalArrMood = [MDLMood]()

    @Published var arrReason = [MDLReason]()
    @Published var originalArrReason = [MDLReason]()
    
    @Published var onmind = ""
    
    @Published var isLoading = false
    @Published var toast: Toast?
    
    var cancellable = Set<AnyCancellable>()
    
    func reset() {
        arrMood = []
        originalArrMood = []
        arrReason = []
        originalArrReason = []
        onmind = ""
        isLoading = false
        toast = nil
    }
    
    func fetchMoods() async { 
        do {
            isLoading = true
            try await firestore
                .collection(FICollectionName.moods.rawValue)
                .getDocuments()
                .documents
                .map{try! $0.data(as: MDLMood.self)}
                .publisher
                .receive(on: RunLoop.main)
                .sink { [weak self] mood in
                    guard let `self` = self else {
                        return
                    }
                    self.arrMood.append(mood)
                    self.originalArrMood.append(mood)
                    isLoading = false
                }
                .store(in: &cancellable)
            
        } catch let e {
            isLoading = false
            toast = Toast(message: "Fetch moods error: \(e.localizedDescription)")
        }
    }
    
    func fetchReasons() async {
        do {
            isLoading = true
            try await firestore
                .collection(FICollectionName.reasons.rawValue)
                .getDocuments()
                .documents
                .map{try! $0.data(as: MDLReason.self)}
                .publisher
                .receive(on: RunLoop.main)
                .sink { [weak self] reason in
                    guard let `self` = self else {
                        return
                    }
                    self.arrReason.append(reason)
                    self.originalArrReason.append(reason)
                    isLoading = false
                }
                .store(in: &cancellable)
            
        } catch let e {
            isLoading = false
            toast = Toast(message: "Fetch reason error: \(e.localizedDescription)")
        }
    }
    
    func addEmotionData() async -> Bool {
        isLoading = true
        
        let selectedMoods = arrMood.filter{$0.selected == true}
        let selectedReasons = arrReason.filter{$0.selected == true}
        
        let selectedMoodNames = selectedMoods.map{$0.mood ?? ""}.joined(separator: ", ")
        let selectedReasonNames = selectedReasons.map{$0.reason}.joined(separator: ", ")
         
        var tmpOnmind = onmind
        tmpOnmind += "\n I felt \(selectedMoodNames) because of \(selectedReasonNames)."
        
        let tipGenerator = await GeminiHelper.generate(prompt: tmpOnmind)
        
        var tipText: String = tipGenerator?.text ?? ""

        if tipText.hasSuffix("\n") {
            tipText.removeLast()
        }
        
        let p = (tipText) + "What could be 1-3 words sentense for this emotion"
        let p2 = "I felt \(selectedMoodNames) because of \(selectedReasonNames)." + "What could be 1 word for this emotion"
        
        let moodHeaderGenerator = await GeminiHelper.generate(prompt: p2)
        var moodHeaderText = moodHeaderGenerator?.text ?? ""
        if moodHeaderText.hasSuffix("\n") {
            moodHeaderText.removeLast()
        }
        
        let tipHeaderGenerator = await GeminiHelper.generate(prompt: p)
        var tipHeaderText = tipHeaderGenerator?.text ?? ""
        if tipHeaderText.hasSuffix("\n") {
            tipHeaderText.removeLast()
        }
        
        let id = UUID().uuidString
         
        let data: [String: Any] = [
            "moods": selectedMoods.map{$0.dictionary},
            "reasons": selectedReasons.map{$0.dictionary},
            "onmind": onmind,
            "tip": tipText,
            "tipHeader": tipHeaderText,
            "moodHeader": moodHeaderText,
            "createdAt": Date().millisecondsSince1970,
            "id": id
        ]
        
        do {
            try await firestore
                .collection(FICollectionName.emotionData.rawValue)
                .document(Constant.user?.uid ?? "")
                .collection(FICollectionName.emotionDetails.rawValue)
                .document(id)
                .setData(data)
            
            isLoading = false
            return true
        } catch let error {
            toast = Toast(message: "Error in adding data: \(error.localizedDescription)")
            isLoading = false
            return false
        }
        
    }
    
    func toggleEmotionSelection(for item: MDLMood) {
        if let index = arrMood.firstIndex(where: { $0.mood == item.mood }) {
            item.selected.toggle()
            arrMood.removeAll(where: {$0 == item})
            arrMood.insert(item, at: index)
            originalArrMood = arrMood
        }
    }
    
    func toggleReasonSelection(for item: MDLReason) {
        if let index = arrReason.firstIndex(where: { $0.reason == item.reason }) {
            item.selected.toggle()
            arrReason.removeAll(where: {$0 == item})
            arrReason.insert(item, at: index)
            originalArrReason = arrReason
        }
    }
    
    func searchEmotion(searchText: String) {
        arrMood = originalArrMood
        if searchText != "" {
            arrMood = arrMood.filter{$0.mood!.lowercased().contains(searchText.lowercased())}
        }
    } 
    
    func searchReason(searchText: String) {
        arrReason = originalArrReason
        if searchText != "" {
            arrReason = arrReason.filter{$0.reason.lowercased().contains(searchText.lowercased())}
        }
    }
    
    func checkEmotionContinueEnable() -> Bool {
        if arrMood.filter({$0.selected == true}).count > 0 {
            return true
        }
        return false
    } 

    func checkReasonContinueEnable() -> Bool {
        if arrReason.filter({$0.selected == true}).count > 0 {
            return true
        }
        return false
    }  
}
