import Foundation
import SwiftUI

struct CharacterRow: View {
    let character: DomainCharacter
    var onCellTap: ((DomainCharacter) -> Void)?

    var body: some View {
        Button {
            onCellTap?(character)
        } label: {
            HStack {
                AsyncImageView(urlString: character.image)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.listItemBackground.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 2)

                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                        .foregroundColor(Color.text)
                    Text(character.species)
                        .font(.subheadline)
                        .foregroundColor(Color.text.opacity(0.7))
                }
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
        .listRowBackground(Color("listItemBackground"))
    }
}
