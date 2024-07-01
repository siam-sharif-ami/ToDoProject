import SwiftUI

struct ItemRowView: View {
    @State var item: Item
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Button(action: {
                    withAnimation {
                        item.isCompleted.toggle()
                    }
                }) {
                    Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    Text(item.itemDescription)
                        .lineLimit(2)
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                Text(item.dueDate.formatted())
                    .font(.subheadline)
                    .frame(width: geometry.size.width * 0.3)
            }
            .padding(.horizontal) // Example padding, adjust as needed
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
