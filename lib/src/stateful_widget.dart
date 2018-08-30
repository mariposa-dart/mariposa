import 'package:html_builder/html_builder.dart';
import 'package:meta/meta.dart';
import 'abstract_element.dart';
import 'render_context.dart';

abstract class StatefulWidget extends ContextAwareWidget {
  State _state;

  State _createState(RenderContext context) {
    if (_state != null) {
      return _state;
    } else if (!context.container.has<Map<StatefulWidget, State>>()) {
      throw new StateError(
          'The RenderContext has no Map<StatefulWidget, State> injected; StatefulWidget cannot be used.');
    } else {
      var states = context.container.make<Map<StatefulWidget, State>>();
      _state = states.putIfAbsent(this, () {
        var state = createState();
        return state
          .._renderContext = context
          .._widget = this
          ..initState();
      });

      if (_state == null) {
        throw new StateError(
            'A call createState() on $runtimeType returned null.');
      }

      return _state;
    }
  }

  State createState();

  /// A callback function run after this widget's corresponding node is destroyed.
  void beforeDestroy(AbstractElement element) {
    _state?.deactivate();
  }

  void contextAwareAfterRender(RenderContext context, AbstractElement element) {
    _state?._renderContext = context;
  }

  Node contextAwareRender(RenderContext context) {
    _state ??= _createState(context);
    _state._renderContext = context;
    return _state.render();
  }
}

abstract class State<T extends StatefulWidget> {
  RenderContext _renderContext;
  T _widget;

  T get widget => _widget;

  RenderContext get renderContext => _renderContext;

  @mustCallSuper
  void initState() {}

  @mustCallSuper
  void deactivate() {}

  /// Enqueues a state update.
  ///
  /// The [callback] will run *after* the current render is complete.
  void setState(void Function() callback) {
    renderContext.enqueue((_) {
      callback();
    });
  }

  Node render();
}
