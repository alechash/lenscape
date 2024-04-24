//
//  ChapterView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/22/24.
//

import SwiftUI

struct ChapterView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var chapter: Chapter
    
    var body: some View {
        ScrollView {
            HStack {
                Text(chapter.title)
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            ForEach(chapter.content) { content in
                if (content.type == .navigation) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        InlineTools(value: value)
                    }
                } else if (content.type == .caption) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        HStack {
                            Text(value)
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                    }
                } else if (content.type == .paragraph) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        HStack {
                            Text(value)
                                .font(.body)
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    }
                } else if (content.type == .header) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        HStack {
                            Text(value)
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    }
                } else if (content.type == .header2) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        HStack {
                            Text(value)
                                .font(.title2)
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                    }
                } else if (content.type == .picture) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        AsyncImage(url: URL(string: value)) { image in
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
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    }
                } else if (content.type == .quote) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        HStack {
                            VStack {
                                HStack {
                                    Text("Quote")
                                        .font(.caption)
                                        .foregroundStyle(Color.secondary)
                                    Spacer()
                                }
                                HStack {
                                    Divider()
                                        .frame(width: 2)
                                        .overlay(.blue)
                                    Text(value)
                                        .font(.body)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        .padding(.all, 15)
                        .background(colorScheme == .dark ? Color(red: 27/255, green: 27/255, blue: 30/255) : Color(red:242/255, green: 242/255, blue: 247/255) )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    }
                } else if (content.type == .slideshow) {
                    ForEach(content.content ?? [], id: \.self) { value in
                        Text(value)
                            .monospaced()
                    }
                } else if (content.type == .list) {
                    ForEach(0..<(content.content ?? []).count) { i in
                        HStack {
                            VStack {
                                Image(systemName: "\(i+1).circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.top, 4)
                                    .padding(.trailing, 4)
                                Spacer()
                            }
                            Text(try! AttributedString(markdown: content.content![i]))
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .padding(.horizontal, 5)
        .lineSpacing(10)
        .fontDesign(.serif)
    }
}
