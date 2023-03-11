# URLSession Modern Concurrency
A networking layer based on URLSession with modern concurrency and multipart request capabilities and support for iOS 13.0+.

## Why:  Modern Concurrency
URLSession does support Modern Concurrency using the [data(for:delegate:)](https://developer.apple.com/documentation/foundation/urlsession/3767352-data) method but it's supported only from iOS 15.0 and upwards. So, if you're looking to support older systems. You're out of luck.

## How: Modern Concurrency
In Swift 5.5, when async functions were introduced. It also introduced a way to wrap our older asynchronus functions in an async function and call them using [withCheckedContinuation(function:_:)](https://developer.apple.com/documentation/swift/withcheckedcontinuation(function:_:)) and its multiple variations.
```
    func loadService<Model: Codable>(route: Route, model: Model.Type) async throws -> Model {
        try await withCheckedThrowingContinuation { continuation in
            performRequest(route: route, model: model.self) { model, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: model!)
                }
            }
        }
    }
```

The earlier code snippet uses [withCheckedThrowingContinuation(function:_:)](https://developer.apple.com/documentation/swift/withcheckedthrowingcontinuation(function:_:)) which allows me to throw an error if the call failed for whatever reason using the `resume(throwing:)` function.


## Why: Multipart Requests
There's no direct way to make API requests with multipart content like uploading images, audio or any kind of files using URLSession and that's why people mostly use Alamofire to provide this capability.

## How: Multipart Requests
[Orestis Papadopoulos](https://orjpap.github.io/) provided a detailed guide on [how to make multipart requests using URLSession](https://orjpap.github.io/swift/http/ios/urlsession/2021/04/26/Multipart-Form-Requests.html) which I encorporated in how my Router enums work 
```
    fileprivate func toMultiPart() -> Data? {
        if case .multipart(let boundary) = self.contentType {
            var data = Data()
            data.append(body.toMultiPart(with: boundary))
            data.append(dataFields.toMultiPart(with: boundary))
            data.append("--\(boundary)--")
            return data
        } else {
            return nil
        }
    }
```

This code generates multipart body segments form textFields and dataFields from the route object and joins them together to use them in the `httpBody` of the `URLRequest`.


# Usage
## How to create a router?
The router is mainly, an enum that conforms to the `Route` protocol.

In the repository, I provided an example router object
```
enum Router {
    case placeholder
    // Add as many case as you need
}
```
Create an extension that conforms to the `Route` protocol
```
extension Router: Route {
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var routePath: String {
        switch self {
        case .placeholder:
            return "posts"
        }
    }
    
    var method: URLRequest.HTTPMethod {
        switch self {
        case .placeholder: return .get
        }
    }
    
    var body: HTTPBodyTextFields {
    // This is basically a dictionary [String: Any]
        .empty
    }
    
    var query: QueryParameters {
    // This is basically a dictionary [String: String]
        .empty
    }
    
    var contentType: URLRequest.ContentType {
        .formData
    }
    
    var acceptType: URLRequest.AcceptType {
        .json
    }
    
    var dataFields: HTTPBodyDataFields {
        switch self {
        case .placeholder:
            return .empty
        }
    }
}

```

# Make an API call
All you have to do, now, is to make an API call by calling the `loadService(route:model:)` function
```
Task {
    self.posts = try await Webservice.main.loadService(route: Router.placeholder, model: [Post].self)
    tableView.reloadData()
}
```

In the above code snippet I made an API call to retrieve an array of post objects and view the in a `UITableView` and called `tableView.reloadData()` to update the tableView.

The API call runs on the background thread and switches to the main thread when it retrieves the data. That enables me to reload the table view without worrying about crashing my application.

Also, because the function call is marked with await inside a Task closure (Not that the compiler will allow you to do otherwise, anyway) the app will "wait" for the call to finish before executing `tableView.reloadData()`

# Suggestions and Feedback
If you have any feedback or suggestions I'd greatly appreciate it.

You can contact me on my [LinkedIn](https://www.linkedin.com/in/ahmedfathy-mha/) or via [email](mailto:ahmedfathy.mha@gmail.com)

