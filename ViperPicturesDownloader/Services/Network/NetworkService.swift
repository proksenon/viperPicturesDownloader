import Foundation

final class NetworkService: NetworkServiceProtocol {
	var session: URLSession
	var dispatchQueue: DispatchQueue

	init(session: URLSession = URLSession.shared, dispatchQueue: DispatchQueue = DispatchQueue.main) {
		self.session = session
		self.dispatchQueue = dispatchQueue
	}
	/// Получает данные
	public func getData(url: URL, completion: @escaping (Data) -> ()) {
		session.dataTask(with: url) { (data, resonse, error) in
			guard let data = data else {return}
			self.dispatchQueue.async {
				completion(data)
			}
		}.resume()
	}
	
}
