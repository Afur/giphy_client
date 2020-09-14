extension KotlinExtensions<T> on T {
  A let<A>(A Function(T) f) => f(this);

  T also(void Function(T) f) {
    f(this);
    return this;
  }
}