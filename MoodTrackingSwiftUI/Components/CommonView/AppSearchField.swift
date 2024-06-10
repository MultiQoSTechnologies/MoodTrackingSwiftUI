//
//  AppSearchField.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct AppSearchField: View {
    
    @Binding var searchText: String
    @State var placeholder: String = "Search"
    
    var body: some View {
        HStack {
            Image(.search)
                .resizable()
                .frame(width: 20.aspectRatio, height: 20.aspectRatio)
            TextField(placeholder, text: $searchText)
                .font(.subheadline)
                .bold()
        }
        .padding(10.aspectRatio)
        .background(.white)
        .clipShape(.rect(cornerRadius: 12.aspectRatio))
        .padding(.top, 30.aspectRatio)
    }
}

#Preview {
    AppSearchField(searchText: .constant("Search"))
}
