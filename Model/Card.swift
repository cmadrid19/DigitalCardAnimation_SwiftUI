//
//  Card.swift
//  WalletCardAnimation
//
//  Created by Maxim Macari on 15/4/21.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var cardHolder: String
    var cardNumber: String
    var cardValidity: String
    var cardImage: String
}

var cards = [
    Card(cardHolder: "Wyatt Carter", cardNumber: "1234 5678 9012 3456", cardValidity: "21-2-2025", cardImage: "card1"),
    Card(cardHolder: "Same Watts", cardNumber: "1234 5678 9012 3456", cardValidity: "21-8-2023", cardImage: "card2"),
    Card(cardHolder: "Ted Kennedy", cardNumber: "1234 5678 9012 3456", cardValidity: "04-4-2026", cardImage: "card3"),
    Card(cardHolder: "Ricardo Carpenter", cardNumber: "1234 5678 9012 3456", cardValidity: "09-2-2022", cardImage: "card1")
    
]
