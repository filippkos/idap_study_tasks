//
//  F.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

public enum F {

    typealias ResultHandler<T> = (Result<T, Error>) -> ()
    public typealias VoidFunc<T> = (T) -> ()
}
