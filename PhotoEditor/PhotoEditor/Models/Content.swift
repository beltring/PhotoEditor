//
//  Content.swift
//  PhotoEditor
//
//  Created by Pavel Boltromyuk on 25.11.22.
//

import UIKit

enum Content {
    case image(_ preview: UIImage?)
    case video(_ preview: UIImage?, _ duration: Double)
}
