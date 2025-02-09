import 'package:flutter/material.dart';

/// リポジトリの説明を表示するウィジェット
class DetailRepositoryDescription extends StatelessWidget {
  const DetailRepositoryDescription({
    Key? key,
    required this.description,
  }) : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) => Text(
    description,
    style: Theme.of(context).textTheme.bodyMedium,
  );
}