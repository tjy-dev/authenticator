//
//  CodeViePlaceHolder.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftUI

struct CodeViewPlaceholder: View {
    
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
                        Image(systemName: "chevron.right")
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(Color.secondary)
                            .font(Font.system(size: 20, weight: .semibold))
                        Spacer().frame(width: 25)
                    }
                    Spacer().frame(height: 15)
                    HStack {
                        Spacer().frame(width: 30)
                        ForEach(["・","・","・","・","・","・"], id: \.self) { c in
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .foregroundColor(Color(uiColor: .background))
                                        .frame(width: 40, height: 40)
                                    Text(c)
                                        .font(.custom("AvenirNext-DemiBold", size: 24, relativeTo: .headline))
                                }
                            }
                            .foregroundColor(Color(uiColor: .systemGray))
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
