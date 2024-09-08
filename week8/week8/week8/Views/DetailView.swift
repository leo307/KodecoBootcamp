//
//  DetailView.swift
//  week8
//
//  Created by Leo DelPrete on 6/9/24.
//

import SwiftUI

struct DetailView: View {
    let university: University

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Name: \(university.name)")
            
            Text("Country: \(university.country)")
            
            ForEach(university.web_pages, id: \.self) { webPage in
                Link(webPage, destination: URL(string: webPage)!)
            }
        }
        .padding()
        .navigationTitle(university.name)
    }
}

#Preview {
    DetailView(university: University(name: "Leo College", country: "US", web_pages: ["https://l102.cc"]))
}

