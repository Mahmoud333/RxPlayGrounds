//: Playground - noun: a place where people can play

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//008 Work with subjects

import RxSwift

/*
//Part 1
//error and completed stop printing the rest values
//Part 2
//the newSubscription will only get new events and not old ones
//after disponse you won't get any event if subject changed
*/
 
exampleOf(description: "PublishSubject") {
    enum ErrorUs: Error {
        case Test
    }
    
    let subject = PublishSubject<String>()      //empty string
    
    subject.subscribe {
        print($0)
    }
    
    subject.on(.next("Hello"))
    //subject.onCompleted()
    //subject.onError(ErrorUs.Test)
    subject.onNext("World!")
    //subject.onCompleted()

    
    //Part 2
    let newSubscription = subject.subscribe(onNext: {
        print("New subscription:", $0)
    })
    
    subject.onNext("What's up?")
    
    newSubscription.dispose()           //remove it
    subject.onNext("Still there?")      //No not there
    
}

//-- Show Latest
//part 1
//BehaviorSubject print only latest event, notice "second" didnt print a


exampleOf(description: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "a")
    
    let firstSubscription = subject.subscribe(onNext: {
        print(#line, "first", $0)
    })
    
    subject.onNext("b")
    subject.onNext("c")

    
    let secondSubscription = subject.subscribe(onNext: {
        print(#line, "second", $0)
        
    })
}


//-- Show recent searches
//part 1
//ReplaySubject will play only last 3 elements(bufferSize)


exampleOf(description: "ReplaySubject") {
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    subject.onNext(5)
    
    subject.subscribe(onNext: {
        print($0)
    })
}


//won't get an error and if he got it he will change it into completed
//Variable is a wrapper around behavior subject he will automatically play the last event for new subscribers
//used .asObservable() first to subscribe to it
//.value = "B" will change the value and make onNext in its setter method


exampleOf(description: "Variable") {
    let disposeBag = DisposeBag()
    let variable = Variable("A")
    
    variable.asObservable()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    //add value to variable
    variable.value = "B" //change _value and make onNext for subscribers
 
    
}







var str = "Hello, playground"
