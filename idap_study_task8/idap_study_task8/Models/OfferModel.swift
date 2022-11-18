import Foundation

class OfferModel: Codable {
    var cod: String?
    var message: Float?
    var cnt: Float
    var list: [ListOfferModel]?
    var city: CityModel?
}
