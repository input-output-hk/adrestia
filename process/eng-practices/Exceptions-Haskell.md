---
tags:
  - needs/review
  - needs/writing
---
# Exceptions in Haskell

In `cardano-wallet`, we currently use the following conventions for dealing with exceptions:

1. Avoid partial functions.\
    Example: Do not use `head`, but use a pattern match, or consider using functions from `Safe` module, such as `headMay`. Considering all corner cases does catch bugs.

2. Pure code vs `IO` actions
    * In pure code, use `error` instead of `undefined` if really necessary. In this case, please also add a `HasCallStack` constraint so that a backtrace can be shown when the impossible happens.
    * In `IO`, use `throwIO` to throw a regular exception.

3. Import exception utilities from `UnliftIO.Exception` module rather than `Control.Exception`; these utilities have better default behavior for asynchronous exceptions.

4. If you desire to log an exception, use the tracing framework.

5. Be specific when catching exceptions.\
    For example, if you only want to catch errors when reading a file which doesn't exist use `tryJust`, `ioeGetErrorType`, `isDoesNotExistErrorType`, etc.

6. Be aware that `IOException`s can have different forms on different platforms, especially with Windows and networking code. You need to test your exception handling on Windows.

7. Checked vs. unchecked exceptions
    * Please do not mix `IO (Either e a)` or `ExceptT` with unchecked exceptions.
    * If using checked exceptions, do not add an `Exception` instance to your error type, because this will ensure that it cannot be thrown as an unchecked exception.
    * (Guidelines on the question of checked vs. unchecked exceptions are in progress.)

8. Asynchronous exceptions — never catch them.\
    The purpose of asynchronous exceptions is to terminate the current thread. Use `bracket` or `finally` to quickly release resources if necessary.
    Exception catching functions from `UnliftIO` are typically designed to only catch synchronous exceptions, which is what you want most of the time.

9. When using callbacks that involve monad transformers over `IO`, consider `MonadUnliftIO`.


## References

* FPComplete: Safe exception handling
https://www.fpcomplete.com/haskell/tutorial/exceptions/
* Tweag: The three kinds of Haskell exceptions 
https://www.tweag.io/blog/2020-04-16-exceptions-in-haskell/
* Well-Typed: Lightweight Checked Exceptions in Haskell
https://www.well-typed.com/blog/2015/07/checked-exceptions/