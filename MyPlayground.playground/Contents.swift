import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import Foundation
import RxSwift

let disposeBag = DisposeBag()

//How To Define Them

/*
var array = Variable([1,2,3])
var array = PublishSubject<[Int]>()
var array = BehaviorSubject(value: [1,2,3]) ////BehaviorSubject print only latest event,
var array = ReplaySubject<Int>.create(bufferSize: 3)
*/

// Variable
print("\n ~~~~~ Variable ~~~~~ \n")

let array = Variable([1,2,3])
array.asObservable()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
array.value.append(6)
array.value.append(10)

let dict = Variable(["Hello":10,"World!": 20])
dict.asObservable()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

dict.value["Hello"] = 100
dict.value["Testing"] = 1000

let string = Variable("")
string.asObservable()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

string.value = "Hello from Emptyines"


// PublishSubject
print("\n ~~~~~ PublishSubject ~~~~~ \n")


let array1 = PublishSubject<[Int]>()
array1.asObserver()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
array1.onNext([1,2,3,4])
array1.onNext([5,6,7,8])

let dict1 = PublishSubject<[String: Int]>()
dict1.asObserver()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
dict1.onNext(["Hello": 1, "FirstTry": 2])
dict1.onNext(["Hello": 10, "SecondTry": 20])

let string1 = PublishSubject<String>()
string1.asObserver()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
string1.onNext("Hello ")
string1.onNext("Hello second time")


Observable.of(1,2,3,4)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

Observable


// BehaviorSubject
print("\n ~~~~~ BehaviorSubject ~~~~~ \n")
