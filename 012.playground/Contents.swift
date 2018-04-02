//: Playground - noun: a place where people can play

import UIKit
import RxSwift

//  012 Perform Side Effects

/*So in the Dart example earlier, when we work with observable sequences u want to perform some action or side effect when elements are emitted they wont change anything specifically above the elements that emitted, you can use doOn operator to perform side effects and they are convenience operators including doOnNext , doOnError and doOnCompleted, think do on as wire tap on the observable sequence, you can listen in but not modify the elements and doOn will pass through each event
*/
//might use doOn for login for example

exampleOf(description: "doOnNext") {
    
    let disposeBag = DisposeBag()
    
    let fahrenheitTemps = [-40, 0, 32, 70, 212]
    
    Observable.of(-40, 0, 32, 70, 212)
        .do(onNext: {
            $0 * $0
        })
        .do(onNext: {
            print("\($0)°F = ", terminator: "")  //terminator: prevent printing new line
        })
        .map({
            Double($0 - 32) * 5/9               //change from fahrenheit to celices
        })
        .subscribe(onNext: {
            print(String(format: "%.1f°C", $0))
        })
        .disposed(by: disposeBag)
    
}







var end = "End.."
