//
//  DetailKeySectionView.swift
//  KeyLocker
//
//  Created by Josue on 19/3/25.
//

import SwiftUI
import UIKit

struct DetailKeySectionView: View {
    
    @Binding
    var visible: Bool
    
    var alias: String
    
    var icon: String
    
    var password: String
    
    var onEdit: () -> Void
    
    var body: some View {
        Section(
            header: Label(
                title: { Text(alias) },
                icon: {
                    Image(icon)
                        .resizable()
                        .frame(width: 12,height: 12)
                }
            )
        ) {
            VStack {
                // MARK: Password text
                Text(visible ? password : "******")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity)
                
                // MARK: Actions
                if visible {
                    HStack {
                        // MARK: Edit action
                        Button(action: { onEdit() }) {
                            HStack {
                                Image(systemName: "square.and.pencil")
                                    .frame(height: 24)
                                Text("Edit")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .buttonStyle(.bordered)
                        
                        // MARK: Copy action
                        Button(action: {
                            UIPasteboard.general.string = password
                            vibrate(type: .success)
                        }) {
                            HStack {
                                Image(systemName: "document.on.document")
                                    .frame(height: 24)
                                Text("Copy")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding(16)
            .frame(
                maxWidth: .infinity
            )
        }
    }
    
    func vibrate(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
}

#Preview {
    
    @Previewable
    @State
    var visible: Bool = true
    
    DetailKeySectionView(
        visible: $visible,
        alias: "preview alias",
        icon: "facebook",
        password: "preview",
        onEdit: {
            
        }
    )
}
