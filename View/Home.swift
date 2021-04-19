//
//  Home.swift
//  WalletCardAnimation
//
//  Created by Maxim Macari on 15/4/21.
//

import SwiftUI

struct Home: View {
    
    //animatin properties
    @State var startAnimation: Bool = false
    @State var startCardRotation: Bool = false
    @State var selectedCard: Card = Card(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
    
    //hero effect
    @State var cardAnimation: Bool = false
    @Namespace var animation
    
    //Color Scheme
    @Environment(\.colorScheme) var colorScheme
    
    //open popup
    @State var showPopup: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack {
                    
                    HStack(spacing: 15){
                        Button(action: {
                        }, label: {
                            Image(systemName: "line.horizontal.3.decrease")
                                .font(.title)
                                .foregroundColor(.primary)
                        })
                        
                        Text("Welcome back")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {
                        }, label: {
                            Image(systemName: "person")
                                .resizable()
                                .padding(5)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Circle())
                        })
                    }
                    
                    
                    //CardView
                    ZStack {
                        
                        
                        ForEach(cards.indices.reversed(), id: \.self){ index in
                            CardView(cardNumber: cards[index].cardNumber, ownerName: cards[index].cardHolder, expireDate: cards[index].cardValidity)
                                
                                .scaleEffect(selectedCard.id == cards[index].id ? 1 : index == 0 ? 1 : 0.9)
                                .rotationEffect(.init(degrees: startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                                
                                .onTapGesture {
                                    animateView(card: cards[index])
                                }
                                .offset(y: startAnimation ? 0 : index == 1 ? 60 : (index == 2 ? -60 : 0))
                                //hero effect
                                .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                                .rotationEffect(.init(degrees: selectedCard.id == cards[index].id && startCardRotation ? -90 : 0))
                                
                                //moving the selected Card to the top
                                .zIndex(selectedCard.id == cards[index].id ? 1000 : 0)
                                
                                //Hiding unselected cards
                                .opacity(startAnimation ? selectedCard.id == cards[index].id ? 1 : 0 : 1)
                        }
                    }
                    .rotationEffect(.init(degrees: 90)) // height will be thee width
                    .frame(height: getRect().width - 30)
                    .scaleEffect(0.9)
                    .padding(.top, 20)
                    
                    //Spent
                    VStack(alignment: .leading, spacing: 6, content: {
                        
                        HStack{
                            Text("Total amount spent")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.spring()){
                                    showPopup = true
                                }
                            }, label: {
                                
                                ZStack{
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.primary)
                                        .opacity(0.18)
                                        .offset(x: 3)
                                    
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.primary)
                                        .opacity(0.10)
                                        .offset(x: 6)
                                }
                                .padding(10)
                                .padding(.trailing, 6)
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Capsule())
                            })
                        }
                        Text("140.00 €")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primary.opacity(0.04)
                            .ignoresSafeArea())
            .blur(radius: cardAnimation ? 100 : 0)
            .overlay(
                ZStack(alignment: .topTrailing, content: {
                    if cardAnimation {
                        //Close Button
                        Button(action: {
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.5)){
                                startCardRotation = false
                                selectedCard = Card(cardHolder: "", cardNumber: "", cardValidity: "", cardImage: "")
                                cardAnimation = false
                                startAnimation = false
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(colorScheme != .dark ? .white : .black)
                                .padding()
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                        .padding()
                        
                        //CardView
                        CardView(cardNumber: selectedCard.cardNumber, ownerName: selectedCard.cardHolder, expireDate: selectedCard.cardValidity)
                            .matchedGeometryEffect(id: "CARD_ANIMATION", in: animation)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                })
            )
            .blur(radius: showPopup ? 80 : 0)
            
            if showPopup {
                CustomPopup(showPopup: $showPopup, cardSelected: $selectedCard)
            }
        }
    }
    
    
    func animateView(card: Card) {
        
        //setting current card
        selectedCard = card
        
        //rotation
        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)){
            //to avoid multiple clicks, we wont use toggle()
            startAnimation = true
        }
        
        //after 0.2s Rotating card
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring()){
                startCardRotation = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring()){
                cardAnimation = true
            }
        }
    }
}

struct CustomPopup: View {
    
    @Binding var showPopup: Bool
    @Environment(\.colorScheme) var colorScheme
    @Binding var cardSelected: Card
    
    var body: some View {
        ZStack{
            (colorScheme == .dark ? Color.black : Color.white)
            VStack(alignment: .center, spacing: 0, content: {
                
                HStack(){
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.spring()){
                            showPopup = false
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme != .dark ? .white : .black)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding(.horizontal)
                }
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    ForEach(cards){ card in
                        
                        Button(action: {
                            cardSelected = card
                            showPopup = false
                        }, label: {
                            Text("\(card.cardHolder)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(15)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(15)
                            
                        })
                        
                    }
                })
        })
        .padding()
    }
    .frame(width: getRect().width * 0.9, height: getRect().width * 0.9)
    .cornerRadius(20)
    .shadow(radius: 20)
    
}
}

//xtending view to get Screen Frame
extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


