//
//  ManagerWindow.swift
//  exampleWindow
//
//  Created by Remi Robert on 02/12/2016.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

protocol ManagerWindowDelegate: class {
    func isPointEvent(point: CGPoint) -> Bool
}

class ManagerWindow: UIWindow {

    weak var delegate: ManagerWindowDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.windowLevel = UIWindow.Level.statusBar - 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.delegate?.isPointEvent(point: point) ?? false
    }

    /// Affirm override hack: We use a shake motion to trigger our tweaks window: https://github.com/facebook/Tweaks/blob/master/FBTweak/FBTweakShakeWindow.m
    /// When Dotzu is present, it intercepts these and they terminate at the top of its responder chain.
    // We need them to be forwarded to other window, notably, our tweak window
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIApplication.shared.windows.forEach { window in
            guard window !== self else { return }
            window.motionBegan(motion, with: event)
        }
        super.motionBegan(motion, with: event)
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIApplication.shared.windows.forEach { window in
            guard window !== self else { return }
            window.motionEnded(motion, with: event)
        }
        super.motionEnded(motion, with: event)
    }
}
