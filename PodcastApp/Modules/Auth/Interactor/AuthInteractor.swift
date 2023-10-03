import Foundation

final class AuthInteractor {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
}

extension AuthInteractor: AuthInteractorInput {
    
}
