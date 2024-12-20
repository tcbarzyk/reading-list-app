//
//  AccountView.swift
//  reading-list
//
//  Created by Teddy Barzyk on 11/11/24.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appState: AppState
    @Binding var path: NavigationPath
    @Binding var user: User?
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)
                    .padding(.top, 50)
                if let unwrappedUser = user {
                    Text(unwrappedUser.username)
                        .font(.title)
                        .bold()
                        .padding(10)
                    Text("Email:")
                        .font(.title2)
                        .bold()
                    Text(unwrappedUser.email)
                        //.cornerRadius(2)
                        .padding(.bottom, 20)
                    Text("Member since:")
                        .font(.title2)
                        .bold()
                    Text(formatDate(unwrappedUser.dateCreated))
                        .padding(.bottom, 20)
                }
                else {
                    Text("Error getting user data")
                }
                Button(action: {
                    appState.logout()
                    path = NavigationPath()
                }) {
                    Text("Log out")
                        .font(.title3)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
    }
    
    func formatDate(_ isoDateString: String) -> String {
        let cleanDateString = isoDateString.replacingOccurrences(of: "Z", with: "+0000")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: cleanDateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
    
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
