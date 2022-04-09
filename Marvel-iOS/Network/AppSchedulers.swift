//
//  AppSchedulers.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 6.04.2022.
//

import Foundation
import RxSwift

public protocol AppSchedulers {
    var main: ImmediateSchedulerType { get }
    var background: ImmediateSchedulerType { get }
}

class MarvelAppSchedulers: AppSchedulers {
    public let main: ImmediateSchedulerType
    public let background: ImmediateSchedulerType
    
    init(main: ImmediateSchedulerType = MainScheduler.instance,
         background: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        
        self.main = main
        self.background = background
    }
}
