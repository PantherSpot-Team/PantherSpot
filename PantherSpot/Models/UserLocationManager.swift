import Combine
import CoreLocation
import Foundation

@MainActor
final class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private enum RequestState {
        case idle
        case checkingServices
        case waitingForPermission
        case locating
    }

    enum LocationError: Equatable {
        case accessDenied
        case restricted
        case servicesDisabled
        case unavailable

        var message: String {
            switch self {
            case .accessDenied:
                return "Allow location access for PantherSpot in Settings to find your position. You can still browse all study spots."
            case .restricted:
                return "Location access is restricted on this device. You can still browse all study spots."
            case .servicesDisabled:
                return "Turn on Location Services in Settings to find your position. You can still browse all study spots."
            case .unavailable:
                return "We couldn't find your location. Please try again. You can still browse all study spots."
            }
        }

        var canOpenSettings: Bool {
            self == .accessDenied || self == .servicesDisabled
        }
    }

    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    @Published private(set) var location: CLLocation?
    @Published private var requestState: RequestState = .idle
    @Published private(set) var error: LocationError?

    private let manager: CLLocationManager
    private var requestTask: Task<Void, Never>?
    private var timeoutTask: Task<Void, Never>?

    var isLocating: Bool {
        requestState != .idle
    }

    var isAuthorized: Bool {
        authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }

    override init() {
        let manager = CLLocationManager()
        self.manager = manager
        authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func findLocation() {
        guard !isLocating else { return }
        location = nil
        error = nil
        requestState = .checkingServices

        requestTask = Task {
            let servicesEnabled = await Task.detached {
                CLLocationManager.locationServicesEnabled()
            }.value
            guard !Task.isCancelled, requestState == .checkingServices else { return }

            guard servicesEnabled else {
                finish(with: .servicesDisabled)
                return
            }

            refreshAuthorization()
            switch authorizationStatus {
            case .notDetermined:
                requestState = .waitingForPermission
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                requestFix()
            case .denied:
                finish(with: .accessDenied)
            case .restricted:
                finish(with: .restricted)
            @unknown default:
                finish(with: .unavailable)
            }
        }
    }

    func refreshAuthorization() {
        authorizationStatus = manager.authorizationStatus
        if !isAuthorized {
            location = nil
        }
    }

    func cancelRequest() {
        requestTask?.cancel()
        timeoutTask?.cancel()
        manager.stopUpdatingLocation()
        requestState = .idle
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        refreshAuthorization()
        guard requestState == .waitingForPermission || requestState == .locating else { return }

        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            guard requestState == .waitingForPermission else { return }
            requestFix()
        case .denied:
            finish(with: .accessDenied)
        case .restricted:
            finish(with: .restricted)
        case .notDetermined:
            break
        @unknown default:
            finish(with: .unavailable)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard requestState == .locating, let fix = locations.last, fix.horizontalAccuracy >= 0 else { return }
        // Approximate positions refresh less often than precise fixes.
        guard manager.accuracyAuthorization == .reducedAccuracy || abs(fix.timestamp.timeIntervalSinceNow) <= 60 else { return }
        cancelRequest()
        location = fix
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard requestState == .locating else { return }
        finish(with: (error as? CLError)?.code == .denied ? .accessDenied : .unavailable)
    }

    private func requestFix() {
        requestState = .locating
        manager.requestLocation()
        timeoutTask?.cancel()
        timeoutTask = Task {
            do {
                try await Task.sleep(for: .seconds(15))
            } catch {
                return
            }
            guard requestState == .locating else { return }
            finish(with: .unavailable)
        }
    }

    private func finish(with error: LocationError) {
        cancelRequest()
        self.error = error
    }
}
