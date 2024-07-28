import SwiftUI


struct RandomButton: View {
    let action: () -> Void
    
    @State var isLoading: Bool = false
    
    var body: some View {
        Button(action: {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isLoading = false
                }
                action()
            }
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
            }
            else {
                HStack {
                    Image(systemName: "dice.fill")
                    Text("帮我决定！")
                }
                .foregroundColor(.black)
                .font(.headline)
                .padding()
            }
        }
        .frame(height: 44)
        .frame(minWidth: 180)
        .background(Color.accentColor)
        .cornerRadius(6)
    }
}

struct RandomButton_Previews: PreviewProvider {
    static var previews: some View {
        RandomButton(action: {
        })
    }
}

