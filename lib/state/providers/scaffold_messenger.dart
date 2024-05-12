import 'package:flutter/material.dart';
import 'package:nugget_berg/state/providers/scaffold_messenger_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scaffold_messenger.g.dart';

@riverpod
ScaffoldMessengerState scaffoldMessenger(ScaffoldMessengerRef ref) {
  return ref.watch(scaffoldMessagerKeyProvider).currentState!;
}
