import SwiftUI

class TabBar: ObservableObject {
    
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case services
    case promotions
    case favorites
    case profile
}
