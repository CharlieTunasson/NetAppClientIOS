//
//  Box.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-28.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
