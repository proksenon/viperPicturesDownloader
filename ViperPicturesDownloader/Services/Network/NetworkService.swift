import Foundation

final class NetworkService: NetworkServiceProtocol {
	var session = URLSession.shared

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	/// Получает данные
	public func getData(url: URL, completion: @escaping (Data) -> ()) {
		session.dataTask(with: url) { (data, resonse, error) in
			guard let data = data else {return}
			DispatchQueue.main.async {
				completion(data)
			}
		}.resume()
	}
	
}
