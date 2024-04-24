//
//  LearnView.swift
//  Lenscape
//
//  Created by Jude Wilson on 4/15/24.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID();
    let title: String
    let caption: String
    let image: String
    let tags: [String]
    var chapters: [Chapter]
}

struct Chapter: Identifiable {
    let id = UUID()
    let title: String
    let content: [ChapterSection]
}

struct ChapterSection: Identifiable {
    let id = UUID()
    let type: ContentType
    let content: [String]?
}

enum ContentType {
    case header, header2, caption, paragraph, picture, quote, navigation, slideshow, list
}

struct LearnView: View {
    var exmapleCourse = Course(title: "Basics of Photography: Understanding Exposure", caption: "Learn about how to create new courses and read them!", image: "https://images.unsplash.com/photo-1516724562728-afc824a36e84?q=80&w=2342&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", tags: ["tutorial", "course", "read the course"], chapters: [
        Chapter(title: "Introduction", content: [
            ChapterSection(type: .paragraph, content: ["Photography is an art form that blends creativity with technical skills. One of the fundamental technical aspects of photography is understanding exposure. Exposure determines how light or dark an image will appear when it's captured by your camera. The three main components that affect exposure are aperture, shutter speed, and ISO. In this tutorial, we will explore each of these elements and how they interact to affect the overall exposure of a photograph."]),
        ]),
        Chapter(title: "1. Understanding Aperture", content: [
            ChapterSection(type: .paragraph, content: ["Aperture refers to the opening in your camera lens through which light passes. It is measured in f-stops (e.g., f/1.8, f/4, f/16). Here’s how it works:"]),
            ChapterSection(type: .list, content: ["**Size of Aperture**: A lower f-stop number means a larger aperture, allowing more light to enter the lens. Conversely, a higher f-stop number means a smaller aperture, reducing the amount of light.", "**Depth of Field**: Aperture also affects depth of field, which is the range of distance within a photo that appears acceptably sharp. A larger aperture (lower f-stop) results in a shallower depth of field, focusing attention on subjects close to the camera while blurring the background."]),
        ]),
        Chapter(title: "2. Exploring Shutter Speed", content: [
            ChapterSection(type: .picture, content: ["https://images.unsplash.com/photo-1609294507412-a761caa06ad7?q=80&w=2338&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]),
            ChapterSection(type: .paragraph, content: ["Shutter speed is the duration for which the camera shutter is open to expose light onto the camera sensor. Shutter speed is measured in seconds or fractions of a second (e.g., 1/500 or 1 second). It impacts your photos as follows:"]),
            ChapterSection(type: .list, content: ["**Capturing Motion**: A faster shutter speed (e.g., 1/1000) can freeze fast-moving subjects, while a slower shutter speed (e.g., 1 second) can blur motion, useful in creating a sense of speed or motion.", "**Exposure Levels**: Faster shutter speeds let in less light, and slower speeds allow more light, affecting the exposure."]),
        ]),
        Chapter(title: "3. Setting the ISO", content: [
            ChapterSection(type: .paragraph, content: ["ISO measures the sensitivity of the camera's sensor to light. It typically ranges from 100 to 6400 or higher. Here’s how ISO settings influence your photos:"]),
            ChapterSection(type: .list, content: ["**Light Sensitivity**: A lower ISO number (e.g., 100) means less sensitivity to light, suitable for bright conditions. A higher ISO (e.g., 3200) increases sensitivity, useful in darker conditions but can introduce noise or graininess in the images."]),
        ]),
        Chapter(title: "4. Balancing the Exposure Triangle", content: [
            ChapterSection(type: .navigation, content: ["exp_tri"]),
            ChapterSection(type: .paragraph, content: ["Aperture, shutter speed, and ISO together form what is known as the exposure triangle. Balancing these settings is key to achieving the desired exposure in your photos:"]),
            ChapterSection(type: .list, content: ["**Adjusting for Brightness**: In bright conditions, you might use a smaller aperture, faster shutter speed, and lower ISO. In dim lighting, a larger aperture, slower shutter speed, and higher ISO might be necessary.", "**Creative Control**: Understanding how each component affects the image allows you to make creative decisions about how to capture your scene or subject."]),
            ChapterSection(type: .picture, content: ["https://images.unsplash.com/photo-1627843240167-b1f9d28f732e?q=80&w=2232&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]),
        ]),
        Chapter(title: "5. Practical Application and Experimentation", content: [
            ChapterSection(type: .paragraph, content: ["The best way to master exposure is through practice and experimentation:"]),
            ChapterSection(type: .list, content: ["**Experiment with Settings**: Try shooting the same scene with different settings to see how changes in aperture, shutter speed, and ISO affect the outcome.", "**Review and Adjust**: Review your photos to see if the exposure is as desired. If not, adjust your settings and try again."]),
        ]),
        Chapter(title: "Conclusion", content: [
            ChapterSection(type: .paragraph, content: ["Mastering the basics of exposure in photography allows you to take greater creative control over your images. By understanding and manipulating aperture, shutter speed, and ISO, you can adapt to any lighting situation and convey your vision effectively."]),
            ChapterSection(type: .header2, content: ["Checklist for Mastering Photography Exposure"]),
            ChapterSection(type: .list, content: [
                "Familiarize yourself with the exposure triangle components: aperture, shutter speed, and ISO.",
                "Practice shooting in various lighting conditions to see how different settings affect your images.",
                "Experiment with aperture settings to understand the impact on depth of field and light.",
                "Use shutter speed to creatively capture motion as either sharp or blurred.",
                "Adjust ISO settings to balance the light sensitivity and noise level in your images.",
                "Regularly review your photographs to understand how adjustments affect your results.",
                "Always carry a notebook or use a photography app to note down the settings used for future reference and learning."
            ]),
            ChapterSection(type: .paragraph, content: ["This structured approach will help you develop a solid foundation in photography and enhance your ability to capture stunning photographs under varying conditions."])
        ]),
    ])
    
    let portraitPhotographyCourse = Course(
        title: "Portrait Photography: Capturing Expressions",
        caption: "This tutorial will guide you on how to capture expressive portraits with natural light.",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=2187&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        tags: ["Portrait Photography", "Natural Light", "Expressions", "Tutorial"],
        chapters: [
            Chapter(
                title: "Introduction to Portrait Photography",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "Portrait photography is not just about capturing a person's appearance; it's about revealing a facet of their personality. This tutorial will explore techniques for using natural light to enhance the expressiveness of your subjects.",
                            "Understanding the fundamentals of exposure, composition, and the interaction between light and your subject will set the foundation for capturing compelling portraits."
                        ]
                    )
                ]
            ),
            Chapter(
                title: "1. Understanding Natural Light",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "Natural light is one of the most important tools available to photographers. Its quality drastically affects the atmosphere of the portrait and can convey a wide range of moods depending on how it is used.",
                            "Mastering the use of natural light requires observation and understanding of how light changes with the time of day and weather conditions. Each type of natural light can be used to create different looks and feels in your portraits."
                        ]
                    ),
                    ChapterSection(
                        type: .list,
                        content: [
                            "Early morning or late afternoon light is softer and creates long, gentle shadows.",
                            "Overcast skies provide diffused light, which is ideal for avoiding harsh shadows and highlighting facial details without overexposure.",
                            "Direct sunlight can be challenging but offers high-contrast lighting for dramatic effects."
                        ]
                    )
                ]
            ),
            Chapter(
                title: "2. Setting Up Your Shooting Space",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "Choosing the right environment is crucial for portrait photography. The background should complement the subject and not detract from them. Look for simple, unobtrusive backgrounds that help emphasize your subject.",
                            "Preparing your shooting space involves not only selecting the right background but also positioning your subject to make the best use of the natural light available. Sometimes, minor adjustments to the subject's position can dramatically improve the quality of the captured image."
                        ]
                    )
                ]
            ),
            Chapter(
                title: "3. Techniques for Capturing Expressions",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "Capturing genuine expressions involves interaction between the photographer and the subject. The ability to make your subject feel comfortable and relaxed is just as important as technical skills.",
                            "Discussing with the subject, using humor, and giving them an active role in the shoot can lead to more natural and spontaneous expressions. This engagement is crucial for capturing the essence of the subject's personality."
                        ]
                    ),
                    ChapterSection(
                        type: .picture,
                        content: [
                            "https://images.unsplash.com/photo-1601412436405-1f0c6b50921f?q=80&w=2264&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                        ]
                    ),
                    ChapterSection(
                        type: .list,
                        content: [
                            "A shallow depth of field, often achieved with wide aperture settings, helps focus on the eyes while softly blurring the background.",
                            "Proper exposure settings ensure that the subject's face is well illuminated, capturing every subtle nuance of their expression without losing detail in shadows or highlights."
                        ]
                    )
                ]
            ),
            Chapter(
                title: "4. Review and Adjust",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "The process of reviewing images during the shoot is vital. It allows for immediate feedback and adjustment, which is essential in achieving the desired results.",
                            "Checking images on the fly helps to refine camera settings, adjust compositions, and ensure that the subject's expressions are captured as intended."
                        ]
                    )
                ]
            ),
            Chapter(
                title: "Conclusion",
                content: [
                    ChapterSection(
                        type: .paragraph,
                        content: [
                            "Mastering portrait photography with natural light is a rewarding challenge that combines technical skills with the art of human interaction.",
                            "With practice, you will not only enhance your ability to use natural light effectively but also improve your skills in capturing the unique expressions that give life to portrait photography."
                        ]
                    ),
                    ChapterSection(
                        type: .list,
                        content: [
                            "Practice using different natural lighting conditions to understand their impact on portraits.",
                            "Engage actively with your subjects to capture more natural and expressive portraits.",
                            "Continuously review your work and adjust settings and composition as needed.",
                            "Keep experimenting with different backgrounds and subject positions to enhance your portraits.",
                            "Always be patient and wait for those perfect moments when the subject's expression is just right."
                        ]
                    )
                ]
            )
        ]
    )
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                
                ScrollView {
                    HStack {
                        Text("Understanding the basics")
                            .font(.title3)
                            .bold()
                            .padding(.leading, 18)
                            .padding(.top, 18)
                        Spacer()
                    }
                    ZStack {
                        ScrollView (.horizontal, showsIndicators: false) {
                            LazyHStack {
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: portraitPhotographyCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                Article(geometry: geometry, course: exmapleCourse)
                                    .padding(.trailing, 17)
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .safeAreaPadding(.leading, 15)
                        .clipped()

                        // inject gradient at right side only
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(stops: [
                                    .init(color: Color(UIColor.systemBackground).opacity(0.01), location: 0),
                                    .init(color: Color(UIColor.systemBackground), location: 1)
                                ]), startPoint: .leading, endPoint: .trailing)
                            ).frame(width: 0.2 * geometry.size.width)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                            .allowsHitTesting(false)  // << now works !!
                        
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(.primary)
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(Color(UIColor.systemBackground))
                                }
                                .padding(.trailing, 10)
                                Spacer()
                            }
                        }
                    }
                    .padding(.bottom, 12)
                    
                    HStack {
                        Text("Different types of photography")
                            .font(.title3)
                            .bold()
                            .padding(.leading, 18)
                            .padding(.top, 18)
                        Spacer()
                    }
                }
                .background(.background)
                .navigationTitle("Lenschool")
            }
        }
    }
}
