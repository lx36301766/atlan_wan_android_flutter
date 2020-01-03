
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePageProviderConsumer<T extends ChangeNotifier> extends StatelessWidget {

  final T model;

  final Widget Function(BuildContext context, T value, Widget child) builder;

  SinglePageProviderConsumer({ @required this.model, @required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer(builder: builder),
    );
  }

}
