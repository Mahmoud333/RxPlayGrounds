//: Playground - noun: a place where people can play

import RxSwift

//009 Transform observable sequences

//Map
//want to transform nsData to String to display it on label
//Transform element emitted from observable sequence .map {$0 * $0}

exampleOf(description: "map") {
    Observable.of(1, 2, 3)
        .map{ $0 * $0}                        //multiply each element by it self
        .subscribe(onNext: { print( $0 )  })  //and subscribe next to print each transformed element
        .dispose()                            //subscribtion return disposable

}


//flatMapLatest will release elements from most recent observable sequence
exampleOf(description: "flatMap & flatMapLatest") {
    
    let disposeBag = DisposeBag()
    
    struct Player {
        let score: Variable<String>

    }
    
    let scott = Player(score: Variable("scott 80"))
    let lori = Player(score: Variable("lori 90"))
    
    var player = Variable(scott)
    
    player.asObservable()
        .flatMap({ $0.score.asObservable() }) //reaching the element player instance and accessing its score variable event & obtaing its observable subject variable
        .subscribe(onNext: { print($0) })      //now subscribe to that observable, subscribe to next event on score variable of player variable, bec, variable wraps the behavior subject which release the new elemnt to new subscribers i get that variable printed out
        .disposed(by: disposeBag)
    
    
    player.value.score.value = "player 85"  //if update player scroe value, i will see that printed out as well, its important to realise that wht i subscribe to is scotts score bec. the player value is currenlty scott, so i could also add new value to scotts score
    
    
    scott.score.value = "scott 88"    //, and my subscription will print also that value, and what if i add new player instance into player , my subscribtion will print out that new player score
    
    
    player.value = lori            //90 in that case bec. lori current value is 90, so what happen to my subscribtion of scott score?, if i add new value to scott score it will also print it
    
    
    scott.score.value = "scott 95"    //thats because flat map doesn't subscribe to the previous sequence, flatMapLatest will ignore the emittions from previous sequence and only produce values from most current observable sequence
    
    
    lori.score.value = "lori 100"
    player.value.score.value = "player 105"

}
exampleOf(description: "flatMapLatest") {
    
    let disposeBag = DisposeBag()
    
    struct Player {
        let score: Variable<String>
    }
    
    let scott = Player(score: Variable("scott 80"))
    let lori = Player(score: Variable("lori 90"))
    
    var player = Variable(scott)
    
    player.asObservable()
        .flatMapLatest({ $0.score.asObservable() }) //reaching the element player instance and accessing its score variable event & obtaing its observable subject variable
        .subscribe(onNext: { print($0) })      //now subscribe to that observable, subscribe to next event on score variable of player variable, bec, variable wraps the behavior subject which release the new elemnt to new subscribers i get that variable printed out
        .disposed(by: disposeBag)
    
    player.value.score.value = "player 85"
    
    scott.score.value = "scott 88"
    
    player.value = lori
    
    scott.score.value = "scott 95"
    
    //wont print the scott score value eventhough they are exactly the same code
    //put if i added the value into lori score or player value it will get printed
    lori.score.value = "lori 100"
    player.value.score.value = "player 105"
}



//Scan
//if you familiar with swift reduce, scan works similary, scan starts with initial seed value and used agugate value just like reduce except each time a new item is added into a sequence scan will emit a next event containg each entermediat avigat value along the way, u can apply any avigat formula u want, & their is also reduce rxswift operator that works just like the standard library reduce on observable sequences though
//Like using it for scoing system for Dart game, each person throw that stick to Dart board will receive a score and you want to display that score,

exampleOf(description: "scan") {
    let disposeBag = DisposeBag()
    let dartScore = PublishSubject<Int>()
    
    dartScore.asObservable()
        //.observeOn(MainScheduler.instance)  //remove it will, find warnings
        .buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance) //will return observable array
        .map({  $0.reduce(0, +)  })
        .scan(501, accumulator: { (intermediate, newValue) in
            let result = intermediate - newValue        // intermediate = the main value which is 501 at the first time
            return result == 0 || result > 1 ? result : intermediate
        })
        .do(onNext: {
            if $0 == 0 {                    //all im doing here is checking if intermediate score is equal 0, and if so complete the sequence
                dartScore.onCompleted()
            }
        }) //will add doOnNext which allow you to insert some side effects and pass through observable, will cover it alittle later
        .subscribe({ print($0.isStopEvent ?  $0 : $0.element!) })
        .addDisposableTo(disposeBag)
    
    
    
    //the player play now and score
    dartScore.onNext(13)
    dartScore.onNext(60)    //will see the dartScore reduce with each score
    dartScore.onNext(50)
    dartScore.onNext(0)
    dartScore.onNext(0)
    dartScore.onNext(378)

}

//can use buffer operator to group emittions, buffer can hold on to events emitted by source observable sequence until specified timeSpan time or count number has reached whichever occurs first then will emit observable array of the buffers event, passing 0 in timespan or count it will then ignore it and don't care about that argument

//will insert it before scan
//buffer will return observable array
//so will insert a map and use reduce to sum the values of the array



var str = "End"
