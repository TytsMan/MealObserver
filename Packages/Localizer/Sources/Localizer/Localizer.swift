// The Swift Programming Language
// https://docs.swift.org/swift-book

public final class LocalizerClient {
    
    public init() { }
    
    public func localize(string: String) -> String {
        switch Int.random(in: 0...99) {
        case 0:
            "!\(string)"
        case 1:
            "@\(string)"
        case 2:
            "#\(string)"
        case 3:
            "$\(string)"
        case 4:
            "%\(string)"
        case 5:
            "ˆ\(string)"
        case 6:
            "&\(string)"
        case 7:
            "*\(string)"
        case 8:
            "(\(string)"
        case 9:
            ")\(string)"
        default:
            string
        }
    }
    
}
