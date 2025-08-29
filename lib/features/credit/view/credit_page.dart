import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreditPage extends ConsumerStatefulWidget {
  const CreditPage({super.key});

  @override
  ConsumerState<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends ConsumerState<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Credit Info")),
      body: const Center(child: Text("Credit Info")),
    );
  }
}
