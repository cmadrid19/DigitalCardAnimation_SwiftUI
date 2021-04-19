//
//  CardView.swift
//  WalletCardAnimation
//
//  Created by Maxim Macari on 15/4/21.
//

import SwiftUI



struct CardView: View {
    
    
    let width = UIScreen.main.bounds.width - 50
    
    var cardNumber: String
    var ownerName: String
    var expireDate: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 15){
                HStack(spacing: 20){
                    VStack(alignment: .leading ,spacing: 0){
                        
                        Text("Digital card mockup".uppercased())
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: true, vertical: true)
                        
                        HStack(){
                            Image("chip")
                                .resizable()
                                .frame(width: 50,height: 50)
                            
                            Image(systemName: "wave.3.right")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)   
                        }
                    }
                    
                    Spacer()
                    
                    Image("mastercard-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                }
                
                
                VStack(alignment: .leading, spacing: 0, content: {
                    Text("\(cardNumber)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .italic()
                        .foregroundColor(.white)
                        .fixedSize(horizontal: true, vertical: true)
                    
                })
                
                HStack(spacing: 20){
                    VStack(alignment: .leading,spacing: 0){
                        Text("Owener name: ")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text("\(ownerName)")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading,spacing: 0){
                        Text("Exp date:")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text("\(expireDate)")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(25)
        }
        .frame(width: width, height: width / 1.586)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(16)
        .shadow(color: .white, radius: 1, x: 1, y: 1)
        .shadow(color: .white, radius: 1, x: -1, y: -1)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardNumber: "1234 5678 9012 3456", ownerName: "Santo Domingo Torrejón", expireDate: "02/25")
            
    }
}
