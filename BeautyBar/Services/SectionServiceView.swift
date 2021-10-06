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
    
    let key: String
    let object: String
    let title: String
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(data) { service in
                    NavigationLink(
                        destination: SingleServiceView(service: service)) {
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: service.imageURL)!,
                                           placeholder: { Image("Loading")
                                        .resizable()
                                        .frame(width: 30, height: 30) },
                                           image: { Image(uiImage: $0).resizable() })
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.leading, 10)
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
        .navigationTitle(title)
        
        .onAppear {
            FBFirestore.retrieveServices(object: object, key: key) { result in
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
        SectionServiceView(key: "MakeUp", object: "service", title: "MakeUp")
    }
}

extension SectionServiceView {
    func dateFormatter(object: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: object)
    }
}
