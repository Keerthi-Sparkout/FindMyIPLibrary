//
//  IpDetailsViewModel.swift
//  FindMyIP
//
//  Created by apple on 31/08/24.
//

import Foundation
import Combine
import Alamofire

@available(iOS 13.0, *)
public  protocol NetworkDataProtocol {
    func fetchIpDetails(url: String) -> AnyPublisher<IPDetailsModel, AFError>
}

@available(iOS 13.0, *)
public struct NetworkService: NetworkDataProtocol {
    public func fetchIpDetails(url: String) -> AnyPublisher<IPDetailsModel, AFError> {
        guard let url = URL(string: url) else {
            fatalError("Bad url")
        }
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: IPDetailsModel.self, decoder: JSONDecoder())
            .value()
            .eraseToAnyPublisher()
    }
}


@available(iOS 13.0, *)
public class IpDetailsViewModel: ObservableObject {
   
    @Published public var details: IPDetailsModel?
    var network: NetworkDataProtocol
    var cancellable = Set<AnyCancellable>()
    
    public init(network: NetworkDataProtocol) {
        self.network = network
    }
    
    public func fetchIDetailsAPI(completion: @escaping (Result<IPDetailsModel, AFError>) -> Void) {
        network.fetchIpDetails(url: "https://ipapi.co/json/")
            .receive(on: DispatchQueue.main)
            .sink { result in
                print(result)
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
//                    completion(.success(error))
                    
                }
            } receiveValue: { model in
                completion(.success(model))
            }.store(in: &cancellable)
        
        
    }
    
}
