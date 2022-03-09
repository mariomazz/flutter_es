import 'package:flutter/material.dart';

class SnapshotResolving extends StatelessWidget {
  const SnapshotResolving({
    Key? key,
    required this.snapshot,
    this.onData,
    this.onError,
    this.onProcessed,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final Widget? onError;
  final Widget? onData;
  final Widget? onProcessed;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      return onData ?? Container();
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return onProcessed ?? const Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.active ||
        snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return onError ??
            Center(child: Text('Error => ${snapshot.error?.toString()}'));
      } else if (snapshot.hasData) {
        return onData ?? Container();
      } else {
        return const Center(child: Text('Empty data'));
      }
    } else {
      return Center(child: Text('State: ${snapshot.connectionState}'));
    }
  }
}
