import Foundation


public func exampleOf(description: String, action: () -> ()) {
    print("\n\n--- Example of:", description, "---")
    action()
}
