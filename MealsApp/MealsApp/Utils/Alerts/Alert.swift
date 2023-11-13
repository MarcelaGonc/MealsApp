//
//  Alert.swift
//  MealsApp
//
//  Created by Marcela De Souza Goncalves on 09/11/23.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("Ther was an issue connecting to the server. If persist, contact support."),
                                      dismissButton: .default(Text("Ok")))

    static let invalidResponse = AlertItem(title: Text("Server error"),
                                           message: Text("Invalid response from the server. Please try again later."),
                                           dismissButton: .default(Text("Ok")))

    static let invalidData = AlertItem(title: Text("Server error"),
                                       message: Text("The data received from server was invalid. Please contact support."),
                                       dismissButton: .default(Text("Ok")))

    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("Ok")))
}
