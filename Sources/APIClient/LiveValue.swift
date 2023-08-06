import Combine
import Foundation
import Models
import Networking
import NetworkingBuilders

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared

		let subject = PassthroughSubject<Int, Never>()
		
		return Self(
			getAcronyms: {
				try await session.data(for: AcronymsRequest.acronyms, using: [Acronym].self)
			},
			getAcronym: { id in
				try await session.data(for: AcronymsRequest.acronym(id), using: Acronym.self)
			},
			updateAcronym: { acronym in
				try await session.data(for: AcronymsRequest.update(acronym))
			},
			deleteAcronym: { acronym in
				try await session.data(for: AcronymsRequest.delete(acronym))
			},
			searchAcronym: { query in
				try await session.data(for: AcronymsRequest.search(query), using: [Acronym].self)
			},
			getUsers: {
				try await session.data(for: UsersRequest.users, using: [User].self)
			},
			getUser: { id in
				try await session.data(for: UsersRequest.user(id), using: User.self)
			},
			createUser: { user in
				try await session.data(for: UsersRequest.create(user))
			},
			getSymbols: {
				try await session.data(for: LittleJohnRequest.symbols, using: [String].self)
			},
			getTicker: { symbol in
				while true {
					subject.send(Int.random(in: 0..<Int.max))
				}
				return AsyncStream { continuation in
					let cancellable = subject.sink { continuation.yield($0) }
					continuation.onTermination = { continuation in
						cancellable.cancel()
					}
				}
//				AsyncStream<Int> { continuation in
//					try await Task.sleep(nanoseconds: 100_000_000)
//					continuation.yield(Int.random(in: 0..<Int.max))
//				}
//				let (stream, response) = try await URLSession.shared.bytes(for: URLRequest(url: URL(string: "http://localhost:8080/littlejohn/ticker?AAPL")!))
//				
//				fatalError()
//				if #available(iOS 15, *) {
//					return try await session.bytes(for: LittleJohnRequest.ticker(symbol: symbol), using: [Stock].self)
//				} else {
//					 fatalError()
//				}
			},
			files: {
				let data = try await URLSession.shared.data(for: FilesRequest.status)
				return String(decoding: data, as: UTF8.self)
				
//				guard let url = URL(string: "http://localhost:8080/files/status") else {
//				  fatalError()
//				}
//				let (data, response) =
//
//				guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//				  fatalError()
//				}
//
//				return String(decoding: data, as: UTF8.self)
			},
			download: {
				try await URLSession.shared.data(for: FilesRequest.download)
			}
		)
	}()
}

extension Data: Mappable {
	public static func map(_ response: Data) -> Data {
		response
	}
}
