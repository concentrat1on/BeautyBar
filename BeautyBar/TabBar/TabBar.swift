import SwiftUI

class TabBar: ObservableObject {
    
    @Published var currentPage: Page = .news
}

enum Page {
    case news
    case services
    case promotions
    case favorites
    case profile
}
