//
//  SettingsView.swift
//  KeyLocker
//
//  Created by Josue on 20/3/25.
//

import SwiftUI

struct SettingsView: View {
    
    @State
    var isOn: Bool
    
    private var authHelper = AuthenticationHelper()
    
    init() {
        self.isOn = readBoolDefault(KEY_FACEID_ENABLED) ?? false
    }
    
    var body: some View {
        List {
            
            Section(header: Label("About", systemImage: "info.circle")) {
                VStack(alignment: .center) {
                    Image(.icLogo48)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 100,
                            height: 100
                        )
                    Text("KeyLocker")
                        .font(.title)
                        .bold()
                    Text("v1.0")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("This app is developed by ArdonDev.\nYou can check my profile in LinkedIn and Github.")
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Button("Github", image: .github) {
                            openWeb(url: "https://github.com/ardon-dev")
                        }
                        .buttonStyle(.bordered)
                        Button("LinkedIn", image: .linkedin) {
                            openWeb(url: "https://www.linkedin.com/in/josue-ardon/")
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.top, 16)
                }
                .frame(maxWidth: .infinity)
                
            }
            
            Section(header: Label("Options", systemImage: "gear")) {
                Toggle("Authenticate to unlock", systemImage: "faceid", isOn: $isOn)
                    .onChange(of: isOn) { oldValue, newValue in
                        if oldValue == true {
                            authHelper.authenticate { result in
                                switch result {
                                case .success(_):
                                    saveBoolDefault(newValue, key: KEY_FACEID_ENABLED)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    isOn = true
                                }
                            }
                        } else {
                            saveBoolDefault(newValue, key: KEY_FACEID_ENABLED)
                        }
                    }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
