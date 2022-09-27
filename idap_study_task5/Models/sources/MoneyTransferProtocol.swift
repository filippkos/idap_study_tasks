import Foundation

protocol MoneyTransferProtocol: AnyObject, MoneyContaibleProtocol {
    func getMoney<T: MoneyTransferProtocol>(another: T)
}
