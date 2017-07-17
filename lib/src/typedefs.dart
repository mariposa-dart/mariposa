import 'state.dart';
import 'widget.dart';

typedef Widget<T> MariposaApplication<T>();
typedef Map<String, T> DefaultStateProvider<T>();
typedef void StateChangeListener<T>(StateChangeInfo<T> changeInfo);