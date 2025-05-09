import SwiftUI
import Foundation

@MainActor
public class ImageCache {
    public static let shared = ImageCache()
    private let cachedImages = NSCache<NSString, UIImage>()
    private var loadingTasks: [URL: Task<UIImage?, Never>] = [:]

    private init() {}

    @MainActor
    func load(urlString: String) async -> UIImage? {
        if let cachedImage = cachedImages.object(forKey: urlString as NSString) {
            return cachedImage
        }

        guard let url = URL(string: urlString) else {
            return nil
        }

        if let existingTask = loadingTasks[url] {
            return await existingTask.value
        }

        let newTask = Task { () -> UIImage? in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    cachedImages.setObject(image, forKey: urlString as NSString)
                    loadingTasks[url] = nil
                    return image
                } else {
                    loadingTasks[url] = nil
                    return nil
                }
            } catch {
                loadingTasks[url] = nil
                return nil
            }
        }
        loadingTasks[url] = newTask
        return await newTask.value
    }
}

struct AsyncImageView: View {
    @State private var image: UIImage?
    let urlString: String?
    let placeholder: Image?

    init(urlString: String?, placeholder: Image? = Image(systemName: "photo")) {
        self.urlString = urlString
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let loadedImage = image {
                Image(uiImage: loadedImage)
                    .resizable()
            } else if let placeholder = placeholder {
                placeholder
                    .resizable()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .text))
                    .scaleEffect(1.5)
            }
        }
        .task(id: urlString) { // Reload image if URL changes
            if let urlString = urlString {
                image = await ImageCache.shared.load(urlString: urlString)
            } else {
                image = nil
            }
        }
    }
}
