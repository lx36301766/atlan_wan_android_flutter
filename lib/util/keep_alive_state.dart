

import 'package:flutter/material.dart';

abstract class KeepAliveState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

}

class KeepAliveStateContainer extends StatefulWidget {

  final Widget child;

  const KeepAliveStateContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _KeepAliveStateContainerState createState() => _KeepAliveStateContainerState();

}

class _KeepAliveStateContainerState extends KeepAliveState<KeepAliveStateContainer> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

}
