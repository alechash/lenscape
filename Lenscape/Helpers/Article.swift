//
//  Article.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/15/24.
//

import SwiftUI

struct Article: View {
    @State var geometry: GeometryProxy
    @State var course: Course

    var body: some View {
        Group {
            NavigationLink(destination: Tutorial(course: course)) {
                ZStack {
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: course.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 500)
                                    .frame(height: 200)
                                    .clipped()
                            } placeholder: {
                                Image("placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 500)
                                    .frame(height: 200)
                                    .clipped()
                            }
                        }
                        .mask(LinearGradient(gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 1),
                            .init(color: .black, location: 1),
                            .init(color: .clear, location: 1)
                        ]), startPoint: .top, endPoint: .bottom))
                        .padding(.all, -15)
                        .padding(.bottom, 20)
                        Spacer()
                    }
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                
                                ForEach (course.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.system(size: 10))
                                        .foregroundColor(.primary)
                                        .padding(.vertical, 3.5)
                                        .padding(.horizontal, 4.5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.accentColor, lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal, 2)
                            .padding(.vertical, 1)
                        }
                        HStack {
                            Text(course.title)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .bold()
                                .font(.system(size: 20))
                            Spacer()
                        }
                        .padding(.vertical, 1)
                        HStack {
                            Text(course.caption)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 13))
                                .padding(.bottom, 1)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "clock")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                            Text("5 minute read")
                                .font(.caption2)
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        .padding(.top, 1)
                    }
                    .padding(.top, 140)
                }
            }
            .multilineTextAlignment(.leading)
            .padding(.all, 15)
            .background(Color("ListBackground"))
            .clipShape(
                RoundedRectangle(cornerRadius: 15)
            )
            .padding(.vertical, 20)
            .frame(maxWidth: geometry.size.width * 0.9)
            .frame(maxWidth: 500)
        }
    }
}
