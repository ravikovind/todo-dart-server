import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.event = 'Loading...',
    this.style,
  });
  final String event;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 12.0,
        runSpacing: 12.0,
        children: [
          CircularProgressIndicator.adaptive(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          Text(
            event,
            style: style ??
                Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
    );
  }
}
