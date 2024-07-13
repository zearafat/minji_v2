//
//  WidgetearningView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 15/05/24.
//

import SwiftUI

struct WidgetEarningView: View {
    
    // MARK: - Props
    var totalEarning: Double = 0.0
    var ongoingProject: Int = 0
    var titleWidget1: String = "Total earnings"
    var titleWidget2: String = "Ongoing projects"
    
    var body: some View {
        HStack() {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("🚀")
                        .padding(.bottom, 14)
                    
                    Text(titleWidget1)
                        .roundedFont(forSize: .medium)
                    
                    Text("\(totalEarning.formattedAsDollar())")
                        .roundedFont(forSize: .large)
                        .bold()
                }
                .foregroundColor(.white)
                .padding()
            }
            
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: .slate200.opacity(0.5), radius: 10, x: 0.0, y: 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("🔥")
                        .padding(.bottom, 14)
                    
                    Text(titleWidget2)
                        .roundedFont(forSize: .medium)
                    
                    Text("\(ongoingProject)")
                        .roundedFont(forSize: .large)
                        .bold()
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    WidgetearningView()
//}
