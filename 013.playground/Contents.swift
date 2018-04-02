//: Playground - noun: a place where people can play

import RxSwift
import UIKit
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

// 013 - Use Schedulers

/*
subscribeOn: Affects where entire subscription operates
observeOn: Only affects where events are received, preceding use
create the image from nsdata on the background thread then return to main thread and make it appear
if it was coming from NSURLResponse it was going to be already on the background queue, but in this example we are on main thread
*/

let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 128.0, height: 128.0))
XCPlaygroundPage.currentPage.liveView = imageView

let swift = UIImage(named: "Swift")!
let swiftImageData = UIImagePNGRepresentation(swift)!
let rx = UIImage(named: "Rx")!
let rxImageData = UIImagePNGRepresentation(rx)!

//Start

let disposeBag = DisposeBag()

let imageDataSubject = PublishSubject<Data>()

//Way 1
let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)      //create global background scheduler

//Way 2
//let myQueue = dispatch_queue_create("com.scotteg.myConcurrentQueue", Dispatch_queue_concurrent)   //if we want to create our own dispatch Que
let myQueue2 = DispatchQueue(label: "com.scotteg.myConcurrentQueue", attributes: .concurrent)
let scheduler2 = SerialDispatchQueueScheduler(queue: myQueue2, internalSerialQueueName: "com.scotteg.myConcurrentQueue")

//Way 3
let operationQueue = OperationQueue()
operationQueue.qualityOfService = .background
let scheduler3 = OperationQueueScheduler(operationQueue: operationQueue)

//use observeOn to indicate that i want events received from that sequence on the background scheduler that i created
imageDataSubject
    .observeOn(scheduler)
    .map {
        UIImage(data: $0)
    }                                     //use map to transform that NSData to uiimage instance
    .observeOn(MainScheduler.instance)    //once i have the image i need to return to mainthread so i can display it
    .subscribe(onNext: {
        imageView.image = $0
    })                                    //subscribe next to assign the image to the imageview
    .disposed(by: disposeBag)


imageDataSubject.onNext(swiftImageData)
imageDataSubject.onNext(rxImageData)










var end = "END..!"
