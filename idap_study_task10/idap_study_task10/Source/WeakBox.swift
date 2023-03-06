//
//  WeakBox.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

public struct WeakBox<Wrapped: AnyObject> {

    public var isEmpty: Bool {
        return self.wrapped == nil
    }

    public private(set) weak var wrapped: Wrapped?

    public init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

public struct WeakFunction<Object: AnyObject> {

    // MARK: -
    // MARK: Variables

    private let wrappedFunction: (Object) -> () -> ()

    private(set) weak var wrapped: Object?

    public var isEmpty: Bool {
        return self.wrapped == nil
    }

    // MARK: -
    // MARK: Initializations

    public init(signature: @escaping (Object) -> () -> (), object: Object) {
        self.wrappedFunction = signature
        self.wrapped = object
    }

    // MARK: -
    // MARK: Public

    public func execute() {
        self.wrapped.map {
            self.wrappedFunction($0)()
        }
    }
}

extension WeakBox: Equatable {

    public static func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs.wrapped.flatMap { lhs in
            rhs.wrapped.map { $0 === lhs }
        }
            ?? false
    }
}
