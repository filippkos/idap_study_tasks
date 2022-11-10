import UIKit

extension UIImage {
    func compress(cellHeight: Double) -> UIImage {
        let finalHeight = cellHeight
        let finalWidth = (finalHeight * self.size.width) / self.size.height
        let targetSize = CGSize(width: finalWidth, height: finalHeight)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        let resized = renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resized
    }
}
