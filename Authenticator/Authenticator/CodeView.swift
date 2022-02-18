//
//  CodeView.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftUI

struct CodeView: View {
    
    @Binding
    var timeLeft: Int
    var item: Item
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color(uiColor: .contentBackground))
                    .frame(width: abs(geo.size.width - 30), height: 140)
                VStack {
                    HStack {
                        Spacer().frame(width: 30)
                        VStack {
                            HStack {
                                Text(item.title!)
                                    .font(.custom("AvenirNext-DemiBold", size: 18, relativeTo: .headline))
                                    .foregroundColor(Color.primary)
                                Spacer()
                            }
                            Spacer().frame(height: 5)
                            HStack {
                                Text(item.desc ?? "")
                                    .font(.custom("AvenirNext", size: 14, relativeTo: .title))
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                        }
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(Color(uiColor: .systemGray6), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                .frame(width: 30, height: 30)
                            Circle()
                                .trim(from: CGFloat(Double(30 - timeLeft) / 30.0), to: 1)
                                .stroke(timeLeft < 9 ? Color(uiColor: .distructiveText) : Color(uiColor: .barColor), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                .frame(width: 30, height: 30)
                                .rotationEffect(.init(degrees: -90))
                                .animation(.none, value: timeLeft)
                        }
                        Spacer().frame(width: 30)
                    }
                    Spacer().frame(height: 15)
                    HStack {
                        Spacer().frame(width: 30)
                        ForEach(item.key!.generateCode().codeArray(), id: \.self) { c in
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .foregroundColor(timeLeft < 9 ? Color(uiColor: .distructiveBackground) : Color(uiColor: .codeBackground))
                                        .frame(width: 40, height: 40)
                                    Text(c)
                                        .font(.custom("AvenirNext-DemiBold", size: 24, relativeTo: .headline))
                                }
                            }
                            .foregroundColor(timeLeft < 9 ? Color(uiColor: .distructiveText) : Color(uiColor: .highlightText))
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
