import SwiftUI

struct InfoSectionView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .foregroundColor(.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    InfoSectionView(title: "a fake title", value: "a fake value")
        .padding()
        .background(Color.black)
}
