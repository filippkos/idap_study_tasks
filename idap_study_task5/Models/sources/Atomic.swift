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

    func modify(_ execute: (inout Value) -> ()) {
        self.lock.lock()
        execute(&value)
        self.lock.unlock()
    }
}
