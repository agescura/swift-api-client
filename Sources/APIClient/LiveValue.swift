import Foundation
import Models
import Networking
import NetworkingBuilders

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared

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
			}
		)
	}()
}
