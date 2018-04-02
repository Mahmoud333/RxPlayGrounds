//: Playground - noun: a place where people can play
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

// 007 Observable sequences

import RxSwift

exampleOf(description: "just") {
    let observable = Observable.just("Hello, World!")
    
    observable.subscribe({ (event) in
        print(event)
        
    })
    
}

exampleOf(description: "of") {
    var observable = Observable.of(1,2,3)
    
    observable.subscribe {
        print($0)
    }
    observable.subscribe {
        print($0)
    }
    
}

exampleOf(description: "toObservable") {
    var array: Variable<[Int]> = Variable([1,2,3])
    array.asObservable()
        .subscribe {
            print("1st way: \($0) " ) //nest([1, 2, 3])
    }
    
    array.asObservable().subscribe(onNext: { (updatedArray) in
        print("2nd way: \(updatedArray)") // [1, 2, 3]
    })
    
    
    //Part 2
    
    let disposeBag = DisposeBag()
    let subscription: Disposable = array.asObservable()
        .subscribe(onNext: { (updatedArray) in
            print("3rd way: \(updatedArray) ")
        })
    subscription.addDisposableTo(disposeBag)
    
    //This two are the same but diff syntax
    
    array.asObservable()
        .subscribe(onNext: { (updatedArray) in
            print("4th way: \(updatedArray) ")
        })
    .addDisposableTo(disposeBag)
    
    //Part 3
    
    var array2: Variable<[Int]> = Variable([4, 5, 6])
    array2.asObservable().subscribe(onNext: { (intArray) in
        
    }, onError: { (error) in
        
    }, onCompleted: {
        print("~~Completed")
    }).disposed(by: disposeBag)
}

exampleOf(description: "error") {

    enum ErrorUS: Error {
        case Test
    }
    
    Observable<Int>.error(ErrorUS.Test)
        .subscribe {
            print($0)
    }
    
    
}



var str = "Hello, playground"
