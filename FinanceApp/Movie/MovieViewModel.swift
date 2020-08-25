





import RxSwift
import RxCocoa

class MovieViewModel{
    
    
    let dataSource: BehaviorRelay<[MovieInfo]> = BehaviorRelay(value: [])
    var error : Error?
    let disposeBag = DisposeBag()
    
    
    public func callAPIFromViewModel(withUrlString : String) {
        var apiHandler = APIHandler.init()
        let disposable = apiHandler.movieHandler(withUrlString : withUrlString).subscribe(onNext: { (data) in
            
            let jsonDcoderObj = JSONDecoder.init()
            
            do{
                let model = try jsonDcoderObj.decode(MovieResults.self, from: data!)
                print(data)
                self.dataSource.accept(model.results)
            }catch{
                //error
                self.error = error
            }
            
        }, onError: { (error) in
            self.error = error
        }, onCompleted: {
            
        }) {
            print("Disposed")
        }
        disposable.disposed(by: disposeBag)
    }
    
}
