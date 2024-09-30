//
//  FlatMapCombineOperatorViewController.swift
//  CombineTutorial
//
//  Created by SHUVRO on 9/30/24.
//

import Foundation
import Combine
import UIKit

class FlatMapCombineOperatorViewController: UIViewController {
    
    var blogPublisher = PassthroughSubject<PostQuery, URLError>()
    var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let publisher = blogPublisher
            .flatMap(maxPublishers: .unlimited) { query -> URLSession.DataTaskPublisher in
                let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(query.id)")!
                return URLSession.shared.dataTaskPublisher(for: url)
            }
            .eraseToAnyPublisher()
        
        publisher
            .map { $0.data }
            .decode(type: Post.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { output in
                print(output)
            }
            .store(in: &cancellables)

        blogPublisher.send(PostQuery(id: 1))
        blogPublisher.send(PostQuery(id: 2))
    }
}

struct PostQuery {
    let id: Int
}

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
}
