//
//  Mentor.swift
//  Mentors_UIKit
//
//  Created by Giovanni Monaco on 22/03/23.
//

import Foundation
import UIKit

struct Mentor {
    var name: String
    var surname: String
    var imageName: String {
        "\(name.lowercased())_\(surname.lowercased())"
    }
    var description: String?
    var favouriteColor: UIColor?
}
