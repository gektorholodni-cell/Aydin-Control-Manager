import 'package:flutter/material.dart';

class TaskPeopleWrap extends StatelessWidget {
  const TaskPeopleWrap({required this.people, super.key});

  final List<String> people;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: people
          .map(
            (String name) => Chip(
              avatar: const CircleAvatar(child: Icon(Icons.person, size: 14)),
              label: Text(name),
            ),
          )
          .toList(growable: false),
    );
  }
}
