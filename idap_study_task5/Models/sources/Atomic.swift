import Foundation

class Atomic<Value> {
    
    // MARK: -
    // MARK: Variables
    
    private var value: Value
    private let lock = NSLock()

    var wrappedValue: Value {
      get { return load() }
      set { store(newValue: newValue) }
    }
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(wrappedValue value: Value) {
        self.value = value
    }

    // MARK: -
    // MARK: Public ( Public visible funcs )
    
    private func load() -> Value {
        lock.lock()
        defer { lock.unlock() }
        return value
    }

    private func store(newValue: Value) {
        lock.lock()
        value = newValue
        lock.unlock()
    }

    func modify<Result>(_ execute: (inout Value) -> Result) -> Result {
        self.lock.lock()
        defer { lock.unlock() }
        return execute(&value)
    }
    
    func takeValue() -> Value {
        self.lock.lock()
        defer { lock.unlock() }
        return value
    }
    
}
