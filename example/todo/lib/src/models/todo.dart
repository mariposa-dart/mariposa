class Todo {
  final String text;
  bool completed;

  Todo(this.text, {this.completed: false});

  @override
  String toString() {
    if (completed)
      return '$text (complete)';
    return '$text (incomplete)';
  }

}
