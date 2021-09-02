import SwiftUI

struct TabBarIconView: View {
    
    @StateObject var tabBar: TabBar
    let assignedPage: Page
    
    let width: CGFloat
    let height: CGFloat
    
    let systemIconName: String
    let tabName: String
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            tabBar.currentPage = assignedPage
        }
        .foregroundColor(tabBar.currentPage == assignedPage ? Color("TabBarHighlights") : .gray)

    }
}
