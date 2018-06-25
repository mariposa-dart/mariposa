import 'package:html_builder/html_builder.dart';
import 'abstract_element.dart';
import 'widgets.dart';

/// The context in which a node or widget is being rendered.
class RenderContext {
  final RenderContext _parent;

  final List _values = [];

  RenderContext(this._parent);

  RenderContext createChild() => new RenderContext(this);

  /// Adds a value to this context's injections.
  void inject(value) => _values.add(value);

  /// Gets a value within this context, matched by [matcher].
  T find<T>(bool Function(dynamic) matcher) {
    return _values.firstWhere(matcher, orElse: () => _parent?.find<T>(matcher))
        as T;
  }
}

/// A special [Widget] that can interact with a [RenderContext].
abstract class ContextAwareWidget extends Widget {
  Node contextAwareRender(RenderContext context);

  void contextAwareAfterRender(
      RenderContext context, AbstractElement element) {}

  @override
  void afterRender(AbstractElement element) {
    throw new StateError(
        'A ContextAwareWidget cannot call `afterRender` without passing a RenderContext to it.');
  }

  @override
  Node render() {
    throw new StateError(
        'A ContextAwareWidget cannot be rendered without passing a RenderContext to it.');
  }
}
