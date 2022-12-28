//
//  Figure.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 28.12.22.
//

import UIKit

protocol Figure: NSObjectProtocol {
    var historyId: String { get set }
    var isText: Bool { get }
}
