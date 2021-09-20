import SwiftUI

class TabBar: ObservableObject {
    
    @Published var currentPage: Page = .services
}

enum Page {
    case services
    case favorites
    case promotions
    case news
    case profile
}
