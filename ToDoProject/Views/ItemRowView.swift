import SwiftUI
import Kingfisher

struct ItemRowView: View {
    @State var item: Item
    
    var body: some View {
        
        VStack{
            if let image = item.image {
                KFImage(URL(string:image))
                    .resizable()
                    .frame(width: 350, height: 150)
                    .cornerRadius(10)
            }
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
                Spacer()
                
                Text(item.dueDate.formatted())
                    .font(.subheadline)
            }
            .padding(.horizontal)
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
