import 'package:angel_container/angel_container.dart';
import 'package:html_builder/html_builder.dart';
import 'abstract_element.dart';
import 'widgets.dart';

/// The context in which a node or widget is being rendered.
abstract class RenderContext {
  Container get container;

  /// Creates a child of this [RenderContext], optionally
  /// with a custom [reflector].
  RenderContext createChild({Reflector reflector: const EmptyReflector()});

  /// Instructs Mariposa to run a [callback] after this render is complete.
  ///
  /// Tasks trigger a re-render, so only enqueue them if you intend for an action to
  /// update the UI.
  void enqueue(void Function(RenderContext) callback);
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
