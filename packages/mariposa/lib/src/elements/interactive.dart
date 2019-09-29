import 'package:html_builder/html_builder.dart';
import 'package:merge_map/merge_map.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart' show Event, KeyboardEvent;
import 'html_element.dart';

class Button extends Html5Component {
  Button._(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      Iterable<Node> children,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick})
      : super(key, 'button', id, className, style, props, eventListeners,
            children) {
    this.eventListeners['click'] ??= onClick;
    this.eventListeners['dblclick'] ??= onDoubleClick;
  }

  factory Button(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node child,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick}) {
    return Button._(
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners,
        children: [child],
        onClick: onClick,
        onDoubleClick: onDoubleClick);
  }

  factory Button.icon(
      {String key,
      String id,
      className,
      Style style,
      Map<String, dynamic> props,
      Map<String, void Function(Event)> eventListeners,
      @required Node icon,
      @required Node child,
      void Function(Event) onClick,
      void Function(Event) onDoubleClick}) {
    return Button._(
        id: id,
        key: key,
        className: className,
        style: style,
        props: props,
        eventListeners: eventListeners,
        children: [icon, child],
        onClick: onClick,
        onDoubleClick: onDoubleClick);
  }
}

class Input extends Html5Component {
  Input(
      {String key,
      String id,
      className,
      bool checked = false,
      String placeholder,
      String type = 'text',
      String value,
      Style style,
      Map<String, dynamic> props,
      void Function(Event) onBlur,
      void Function(Event) onChange,
      void Function(Event) onFocus,
      void Function(Event) onInput,
      void Function(KeyboardEvent) onKeyDown,
      void Function(KeyboardEvent) onKeyPress,
      void Function(KeyboardEvent) onKeyUp,
      Map<String, void Function(Event)> eventListeners})
      : super(
            key,
            'input',
            id,
            className,
            style,
            mergeMap([
              {
                'checked': checked,
                'placeholder': placeholder,
                'type': type,
                'value': value,
              },
              props,
            ]),
            mergeMap([
              {
                'blur': onBlur,
                'change': onChange,
                'focus': onFocus,
                'input': onInput,
                'keydown': castEventHandler<KeyboardEvent>(onKeyDown),
                'keypress': castEventHandler<KeyboardEvent>(onKeyPress),
                'keyup': castEventHandler<KeyboardEvent>(onKeyUp),
              },
              eventListeners,
            ]),
            []);
}
