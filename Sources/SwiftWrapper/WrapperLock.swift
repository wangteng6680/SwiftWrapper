import Foundation

private protocol Lock {
	func lock()
	func unlock()
}

extension Lock {
	/// Executes a closure returning a value while acquiring the lock.
	///
	/// - Parameter closure: The closure to run.
	///
	/// - Returns:           The value the closure generated.
	func around<T>(_ closure: () -> T) -> T {
		lock(); defer { unlock() }
		return closure()
	}

	/// Execute a closure while acquiring the lock.
	///
	/// - Parameter closure: The closure to run.
	func around(_ closure: () -> Void) {
		lock(); defer { unlock() }
		closure()
	}
}

/// An `os_unfair_lock` wrapper.
final class UnfairLock: Lock {

	private let unfairLock: os_unfair_lock_t

	init() {
		unfairLock = .allocate(capacity: 1)
		unfairLock.initialize(to: os_unfair_lock())
	}

	deinit {
		unfairLock.deinitialize(count: 1)
		unfairLock.deallocate()
	}

	fileprivate func lock() {
		os_unfair_lock_lock(unfairLock)
	}

	fileprivate func unlock() {
		os_unfair_lock_unlock(unfairLock)
	}
}

/// A thread-safe wrapper around a value.
@propertyWrapper
public struct WrapperLock<T> {

	private let lock = UnfairLock()

	private var value: T

	public init(_ value: T) {
		self.value = value
	}

	/// The contained value. Unsafe for anything more than direct read or write.
	public var wrappedValue: T {
		get { lock.around { value } }
		set { lock.around { value = newValue } }
	}

	public init(wrappedValue: T) {
		value = wrappedValue
	}
}

