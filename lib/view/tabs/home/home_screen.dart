import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/nuggets/providers/nuggets.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    ref.read(nuggetsProvider.notifier).loadNuggets();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  } 

  int currentIndex = 0;

  _handlePageChange(int current) {
    if (current > currentIndex) {
      currentIndex = current;
      ref
          .read(nuggetsProvider.notifier)
          .getNextNuggetOrRemoveVideo(currentIndex: currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nuggets = ref.watch(nuggetsProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          home,
          style: const TextStyle(fontWeight: FontWeight.w200),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: (nuggets.isEmpty)
          ? const MainContentLoading()
          : PageView.builder(
              onPageChanged: (current) => _handlePageChange(current),
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: nuggets.length,
              itemBuilder: (BuildContext context, int index) {
                if (index >= nuggets.length) {
                  return const MainContentLoading();
                }
                return MainContent(nugget: nuggets[index]);
              },
            ),
    );
  }
}
