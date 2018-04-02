//: Playground - noun: a place where people can play

import UIKit
import RxSwift

//  011 Combine Observable Sequences


//Working with multiple observable sequences and reacting to new elements emitted from one or more of these sequences, there are handful operators that combines observable sequences in viraity of ways

//startWith
//will prepend or add observable sequence into the beginning of the source observable sequences and those elemnts will be emitted before beginning to emitting elements from source observable sequence


exampleOf(description: "startWith") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("1", "2", "3")
        .startWith("A")         //use it to prepend some elements
        .startWith("B")
        .startWith("C", "D")    //notice i can do it multiple times if i want to, but can include multiple elements in single call to
        .subscribe(onNext: {
            print( $0 )
        })
        .disposed(by: disposeBag)
    
    
}

//merge
/*Merge will combine emittions from multiple observable sequences into a single new observable sequenc,e and emit each element in the order as its emitted by each source sequence
Merge let you combine them but must be same type, all of them string or Int and so on
      --1--3--5--7---9---|
      ---2--4---6--8-----|

      --12-34-5-67-8-9---|
*/
exampleOf(description: "merge") {
    let disposeBag = DisposeBag()
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1, subject2)
    .merge()
        .subscribe(onNext: {
            print($0)
        })
    
    subject1.onNext("A")
    subject1.onNext("B")
    
    subject2.onNext("1")
    subject2.onNext("2")
    
    subject1.onNext("C")
    subject2.onNext("3")
    subject1.onNext("D")

}

//Zip
/*On other hand zip allow you to combine multiple observable sequences with different types, Like String and Int, and apply transformation to zip them togather, zip will combine up to 8 observable sequences into a single sequence and will emit elements from each of source observable sequences as they all emitted at the coresbonding index if you developing card game and want to wait until each player was dilt the full hand before continueing you can use zip

            ---"A"-----"B"--------->

            --------1------2------|>

            -------"A1"---"B2"----|>
*/

exampleOf(description: "zip") {
    
    let disposeBag = DisposeBag()
    
    let stringSubject = PublishSubject<String>()
    let intSubject = PublishSubject<Int>()
    
    Observable.zip(stringSubject, intSubject, resultSelector: { (stringElement, intElement)  in     //zip them togather
        
        "\(stringElement) \(intElement)"
        })
        .subscribe(onNext: { print($0) })
    
    stringSubject.onNext("A")
    stringSubject.onNext("B")       //Still doesn't emit anything yet because the int subject still didn't emit anything
    
    intSubject.onNext(1)
    intSubject.onNext(2)            //now it printed them together combines A 1 and B 2, stringified and printed for each index,-
                                    //-no matter what order the elements are emitted they will each be paired up by index
    
    intSubject.onNext(3)            //Still didn't get printed
    stringSubject.onNext("C")       //now its printed The  C 3
}








var end = "End!."
