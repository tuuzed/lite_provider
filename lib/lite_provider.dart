import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class LiteProvider<T extends Listenable> extends StatefulWidget {
  final T Function(BuildContext) create;
  Widget? child;

  LiteProvider({super.key, required this.create, this.child});

  _injectChild(Widget child) {
    this.child = child;
  }

  @override
  State<LiteProvider<T>> createState() => _LiteProviderState<T>();

  static T of<T>(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    } else {
      return context
          .getInheritedWidgetOfExactType<_InheritedWidget<T>>()!
          .model;
    }
  }
}

class _LiteProviderState<T extends Listenable> extends State<LiteProvider<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    this.model = widget.create(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: model,
      builder: (context, child) {
        return _InheritedWidget<T>(
          model: model,
          child: widget.child ?? ErrorWidget("LiteProvider not child!"),
        );
      },
    );
  }
}

class MutilLiteProvider extends StatelessWidget {
  final List<LiteProvider<dynamic>> providers;
  final Widget child;
  const MutilLiteProvider({
    super.key,
    required this.providers,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var child_ = child;
    for (var i = providers.length - 1; i >= 0; i--) {
      child_ = providers[i].._injectChild(child_);
    }
    return child_;
  }
}

class Consumer<T extends Listenable> extends StatelessWidget {
  final Widget Function(BuildContext, T model) builder;

  const Consumer({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final model = LiteProvider.of<T>(context, listen: true);
    return builder(context, model);
  }
}

class _InheritedWidget<T> extends InheritedWidget {
  final T model;

  const _InheritedWidget({required super.child, required this.model});

  @override
  bool updateShouldNotify(covariant _InheritedWidget oldWidget) {
    return true;
  }
}

extension LiteProviderExtension on BuildContext {
  T watch<T>() => LiteProvider.of(this, listen: true);
  T read<T>() => LiteProvider.of(this, listen: false);
}
