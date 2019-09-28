# 2.0.0
* Mariposa was re-written from the ground-up.
* The core rendering functionality is now generic, and solely requires
an `IncrementalDom<T>` implementation, where `T` is a type such as `Element`.