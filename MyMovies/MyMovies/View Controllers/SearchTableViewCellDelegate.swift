//
//  SearchTableViewCellDelegate.swift
//  MyMovies
//
//  Created by Farhan on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

protocol SearchTableViewCellDelegate : class {
    func didTapAddMovie(_ sender: SearchTableViewCell)
}
