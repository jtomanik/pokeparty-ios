//
//  UIView+Keyboard.swift
//  Switchboard
//
//  Created by Jaroslaw Gliwinski on 2016-05-15.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


enum ComfortFindingMode {
    case SmallestPossible
    case LargestPossible
}


protocol ComfortableViewingAreaView {
    var comfortableBounds: CGRect { get }
}


extension ComfortableViewingAreaView {
    
    var comfortableBounds: CGRect {
        guard let view = self as? UIView else {
            return CGRectZero
        }

        return view.bounds
    }
}


protocol ComfortableViewingAreaFinder {
    func findComfortableView(withMode mode: ComfortFindingMode) -> UIView?
}


extension UIView: ComfortableViewingAreaFinder {

    func findComfortableView(withMode mode: ComfortFindingMode = .LargestPossible) -> UIView? {
        switch mode {
            case .SmallestPossible:
                return smallestComfortableView
            case .LargestPossible:
                return largestComfortableViewWith(candidateSoFar: self)
        }
    }

    var smallestComfortableView: UIView? {
        if self is ComfortableViewingAreaView {
            return self
        }

        return superview?.smallestComfortableView
    }

    func largestComfortableViewWith(candidateSoFar candidate: UIView) -> UIView? {
        guard let superview = superview else {
            return candidate
        }

        if self is ComfortableViewingAreaView {
            return superview.largestComfortableViewWith(candidateSoFar: self)
        }

        return superview.largestComfortableViewWith(candidateSoFar: candidate)
    }
}
