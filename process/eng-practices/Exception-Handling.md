# Exception Handling Guidelines

1. Always import from `UnliftIO.Exception` module rather than `Control.Exception`
2. Be aware that the `Alternative` instance of `IO` probably doesn't work how you want with respect to `<|>`.
3. Use the tracing framework to log exceptions.
4. Be reasonably specific when catching exceptions. For example, if you only want to catch errors when reading a file which doesn't exist use `tryJust`, `ioeGetErrorType`, `isDoesNotExistErrorType`, etc.
5. Be aware that `IOException`s can have different forms on different platforms, especially with Windows and networking code. You need to test your exception handling on Windows.
6. Don't mix `IO (Either e a)` or `ExceptT` with unchecked exceptions.
7. If using checked exceptions, never add an `Exception` instance to your error type.
8. Never catch asynchronous exceptions. This is almost never needed, except at the top level of your program, where you may wish to log that a signal was recieved. Exception catching functions from `UnliftIO` will only catch synchronous exceptions, which is what you want.
9. Never use `error` in an `IO` function. Use a regular exception instead. The `UnliftIO.Exception.throwString` function can be helpful.
10. Avoid partial functions.
11. In pure functions, if using `error`, or if calling a function which uses `error`, add `HasCallStack` constraints so that a backtrace can be shown when the impossible happens.
12. Use the bracket pattern to ensure that resources are cleaned up if there is an error. Get acquainted with `MonadUnliftIO` because it's necessary when using callbacks which are monad transformers over IO.
