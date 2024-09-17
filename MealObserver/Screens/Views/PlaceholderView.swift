//
//  PlaceholderView.swift
//  MealObserver
//
//  Created by divan on 9/17/24.
//

import SwiftUI

struct PlaceholderView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    init(
        imageName: String,
        title: String,
        tintColor: Color = .gray
    ) {
        self.imageName = imageName
        self.title = title
        self.tintColor = tintColor
    }
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable(resizingMode: .tile)
                .frame(width: 20, height: 20)
                .foregroundColor(tintColor)
                .padding(6)
            Text(title)
                .font(.footnote)
                .foregroundColor(tintColor)
        }
    }
}

#Preview {
    PlaceholderView(
        imageName: "exclamationmark.triangle.fill",
        title: "Hello",
        tintColor: .red
    )
}
