part of 'package:hauberk/main.dart';

class LimitedList<T> extends StatelessWidget {
  final List<T> values;
  final Widget Function(T data, BuildContext ctx) itemBuilder;
  final Widget Function(int count) lastButtonBuilder;
  final int limit;

  const LimitedList({
    required this.limit,
    required this.values,
    required this.itemBuilder,
    required this.lastButtonBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: values.length < limit
          ? [
              for (final value in values) ...[
                itemBuilder(value, context),
                const SizedBox(height: 15),
              ],
            ]
          : buildLimitedList(context),
    );
  }

  List<Widget> buildLimitedList(BuildContext context) {
    final List<Widget> widgets = [];
    for (int i = 0; i < limit - 1; i++) {
      widgets.add(itemBuilder(values[i], context));
      widgets.add(const SizedBox(height: 15));
    }
    widgets.add(lastButtonBuilder(values.length));
    return widgets;
  }
}
