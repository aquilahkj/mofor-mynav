// import 'package:flutter/material.dart';
// import 'package:mynav/provider/base_provider.dart';
// import 'package:provider/provider.dart';

// class ProviderWidget<T extends BaseProvider> extends StatefulWidget {
//   final Widget Function(BuildContext context, T model, Widget child) builder;

//   final T model;
//   final Widget child;
//   final Function(T) onModelReady;

//   ProviderWidget({Key key, this.model, this.builder, this.child, this.onModelReady})
//       : super(key: key);

//   _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
// }

// class _ProviderWidgetState<T extends BaseProvider> extends State<ProviderWidget<T>> {
//   T model;

//   void initState() {
//     model = widget.model;
//     if (widget.onModelReady != null) {
//       widget.onModelReady(model);
//     }
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<T>(
//       child: Consumer<T>(
//         builder: widget.builder,
//         child: widget.child,
//       ),
//       create: (BuildContext context) {
//         return model;
//       },
//     );
//   }
// }
