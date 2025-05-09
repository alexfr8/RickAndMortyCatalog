import Foundation
import Network

protocol ReachabilityManagerProtocol: Sendable {
    func close() async
    func getStatus() async -> Bool
}

actor ReachabilityManager: ReachabilityManagerProtocol {
    private(set) var isConnected: Bool
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    public init(
        isConnected: Bool = true,
        monitor: NWPathMonitor = NWPathMonitor(),
        queue: DispatchQueue = DispatchQueue(label: "NetworkMonitor")
    ) {
        self.isConnected = isConnected
        self.monitor = monitor
        self.queue = queue

        self.monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            Task {
                await self.updateConnectionStatus(path.status == .satisfied)
            }
        }
    }

    public func close() async {
        monitor.cancel()
    }

    public func getStatus() async -> Bool {
        return isConnected
    }

    private func updateConnectionStatus(_ status: Bool) {
        isConnected = status
    }
}
