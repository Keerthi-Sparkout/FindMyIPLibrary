//
//  IPDetailsContentView.swift
//
//
//  Created by apple on 31/08/24.
//

import SwiftUI

@available(iOS 14.0, *)
public struct IPDetailsContentView: View {
    @StateObject var viewModel: IpDetailsViewModel = .init(network: NetworkService())
    @State var isLoading: Bool = true
    @State var errorMessage: String = ""
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            Text("IP Details")
                .font(.title)
                .fontWeight(.semibold)
            if isLoading {
                ProgressView()
            } else {
                if errorMessage.isEmpty  {
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("IP Address:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(viewModel.details?.ip ?? "")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                        }.background(Color.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Version:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(viewModel.details?.version ?? "")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                        }.background(Color.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("City:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(viewModel.details?.city ?? "")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                        }.background(Color.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Country:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text(viewModel.details?.country ?? "")
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                        }.background(Color.white)
                    }
                   
                } else {
                    Text(errorMessage)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear() {
            viewModel.fetchIDetailsAPI { result in
                isLoading = false
                switch result {
                case .success(let model):
                    viewModel.details = model
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}


//#Preview {
//    SwiftUIView()
//}
