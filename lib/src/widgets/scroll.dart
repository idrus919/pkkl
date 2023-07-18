import 'package:flutter/material.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/widgets/loading.dart';
import 'package:pkkl/src/widgets/visibility.dart';

class ScrollWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final bool loading;
  const ScrollWidget({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        child: Container(
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              VisibilityWidget(
                visible: loading,
                child: Container(
                  color: neutral1Color,
                  child: const Center(child: LoadingWidget(size: 36)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
