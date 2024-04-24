//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Francisco Lucena on 24/4/24.
//

import SwiftUI

struct CharacterCell: View {
    var imageUrl: URL?
    var name: String
    var body: some View {
        HStack(spacing: 10){
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .background(Color.gray)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            
            Text(name)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    CharacterCell(imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/361.jpeg"),
                  name: "Toxic Rick")
}
