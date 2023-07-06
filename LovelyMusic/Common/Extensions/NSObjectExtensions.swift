import Foundation
import RxSwift
import ObjectiveC

var disposeBagKey: String = "DISPOSE_BAG_KEY"
public extension NSObject {
    var disposeBag: DisposeBag {
        if let bag = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag {
            return bag
        }

        let newBag = DisposeBag()
        objc_setAssociatedObject(self, &disposeBagKey, newBag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return newBag
    }
}
