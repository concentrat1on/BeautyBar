//
//  SectionServiceView.swift
//  BeautyBar
//
//  Created by Илья on 11.09.2021.
//

import SwiftUI

struct SectionServiceView: View {
    
    @State private var data: [FBServices] = []
    @EnvironmentObject var favorites: FavoritesModel
    
    let service: String
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(data) { service in
                    NavigationLink(
                        destination: SingleServiceView(service: service)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(service.title)
                                    .padding()
                                Text(dateFormatter(object: service.date))
/*                                if self.favorites.contains(service) {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                    .accessibility(label: Text("This is a favorite resort"))
                                        .foregroundColor(.red)
                                        .padding()
                                }
 */
                            }
                            Divider()
                        }
                    }
                }
            }
        }
        .navigationTitle(service)
        
        .onAppear {
            FBFirestore.retrieveServices(key: service) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    self.data = data
                        .sorted(by: {$0.date > $1.date })
                }
            }
        }
        
    }
    
}

struct SectionServiceView_Previews: PreviewProvider {
    static var previews: some View {
        SectionServiceView(service: "MakeUp")
    }
}

extension SectionServiceView {
    func dateFormatter(object: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: object)
    }
}
