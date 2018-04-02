//: Playground - noun: a place where people can play

import UIKit
import RxSwift


//010 Filter Observable Sequences

/*in addition to transforming observable sequences you will frequently want to filter the observable sequence to only react to next event based on certain criteria
//example: sequence of Intigers and want to work with only prime intigers which is greater than 1 and only divisors by itself or one
//we can use filter operator here, filter applies a bradicate to each element emitted and only allows those elements through that pass, to set this up we will use generate operator which used to generate observable sequence
*/
 
exampleOf(description: "filter") {
    let disposeBag = DisposeBag()
    let numbers = Observable.generate(initialState: 1, condition: { $0 < 101 }, iterate: {$0 + 1}) //from 0 to 100
    
    numbers.filter({ (number) -> Bool in
        
        guard number > 1 else { return false }
        var isPrime = true
        
        (2..<number).forEach({
            if number % $0 == 0 {
                isPrime = false
            }
        })  //irirate in range of 2 to the numbers of setting isPrime
        
        
        return isPrime
    })          //filter takes predicate that will be applied to test each element in this case Intgier and will return a bool
        .toArray()  //use it to convert the sequence to a single observable array sequence
        .subscribe(onNext: {
            print($0)
        }) //then subscribe to print the next event elements
        .disposed(by: disposeBag)
}


//distinctUntilChanged()
//will only allow unique contiguse elements to pass through, if the next event element is equal to the previous one it will not be allowed through
//[ 1 , 2 , 2 , 1 ]  ---> [ 1 , 2 , 1 ]
//this can be used with search logic to prevent exiquting search twice in a row on the same search string

exampleOf(description: "distinctUntilChanged") {
    
    let disposeBag = DisposeBag()
    let searchString = Variable("")         //make it first an empty string
    
    searchString.asObservable()
        .map({ $0.lowercased() })    //change it to lowerCase to make it uncase sensitave
        .distinctUntilChanged()      //to ignore the equal sequenial elements
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)

    searchString.value = "APPLE"        //and only the 1st element passed through the subscribtion and printed out
    searchString.value = "apple"
    
    searchString.value = "Banana"       //diff value printed out
    searchString.value = "APPLE"        //then add the same value that i did initially again

}



//takeWhile
/*like filter also applies a predicate to elements emitted from observable sequence however take while will terminate the sequence after the first time the specified condition is false and their for the remaining emitted elemets will be ignored, think of take while as a gate and once the gate is closed nothing else get through

//will create a numbers observable of type array of Int with a sequence the increments one to four and decrements back to one
*/

exampleOf(description: "takeWhile") {
    let disposeBag = DisposeBag()
    var numbers: Variable<[Int]> = Variable([1 , 2, 3, 4, 3, 2, 1])
    //[1 , 2, 3, 4, 3, 2, 1].toObservable() -WAS
    //var numbers: Observable<[Int]> = Observable.from([1, 2, 3, 4, 3, 2, 1])//Observable.just([1, 2, 3, 4, 3, 2, 1])//Variable([1, 2, 3, 4, 3, 2, 1])
    //var numbers: Observable<[Int]> = Observable.of(1, 2, 3, 4, 3, 2, 1)
    
    //numbers.asObservable()
    Observable.of(1, 2, 3, 4, 3, 2, 1)
        .takeWhile({ $0 < 4 })  //use takeWhile to only take elements while each element is less than 4 and then terminate
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
    
    //should print it like this [1, 2, 3] supposed
}



























var str = "End."
