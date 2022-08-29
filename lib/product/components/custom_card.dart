import 'package:flutter/material.dart';

import '../../core/init/theme/theme.dart';

class BuildCard extends StatelessWidget {
  const BuildCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: white, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: white),
        ),
      ),
    );
  }
}
