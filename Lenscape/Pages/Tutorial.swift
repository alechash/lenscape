//
//  Tutorial.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/21/24.
//

import SwiftUI

struct Tutorial: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var course: Course
    
    var body: some View {
        List {
            Section {
                ForEach(course.chapters) { chapter in
                    NavigationLink(destination: ChapterView(chapter: chapter)) {
                        Text(chapter.title)
                    }
                }
                
            } header: {
                VStack {
                    HStack {
                        Text(course.title)
                            .padding(.horizontal, -8)
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                            .textCase(.none)
                            .padding(.bottom, 2)
                        Spacer()
                    }
                    HStack {
                        Text(course.caption)
                            .padding(.horizontal, -8)
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                            .textCase(.none)
                            .padding(.bottom, 15)
                            .fontWeight(.regular)
                        Spacer()
                    }
                    
                    HStack {
                        AsyncImage(url: URL(string: course.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
                    .padding(.all, -15)
                    .padding(.bottom, 26)
                    
                    HStack {
                        Text("Chapters")
                            .headerStyle()
                        Spacer()
                    }
                }
            }
            
            /*Section {
             
             } header: {
             VStack {
             Image("placeholder")
             .resizable()
             .aspectRatio(contentMode: .fill)
             .padding(.horizontal, -10)
             .clipShape(
             RoundedRectangle(cornerRadius: 10)
             )
             Text("Course caption. This is a sentence describing the course.")
             .padding(.top, 5)
             .font(.body)
             .textCase(.none)
             .padding(.horizontal, -15)
             }
             .ignoresSafeArea()
             }*/
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
