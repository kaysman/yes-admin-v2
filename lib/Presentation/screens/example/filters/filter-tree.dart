import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/delete-dialog.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-create.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-update.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/titled-add-btn.dart';
import '../widgets/tree-view-item-content.dart';


class FilterTreeViewImpl extends StatefulWidget {
  const FilterTreeViewImpl({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  final ValueChanged<FilterEntity> onFilterChanged;

  @override
  State<FilterTreeViewImpl> createState() => _FilterTreeViewImplState();
}

class _FilterTreeViewImplState extends State<FilterTreeViewImpl> {
  late FilterBloc filterBloc;
  int selected_item = 0;

  @override
  void initState() {
    filterBloc = BlocProvider.of<FilterBloc>(context);
    if (filterBloc.state.filters?.isNotEmpty == true) {
      var _filter = filterBloc.state.filters?.first;
      selected_item = _filter?.id ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterBloc, FilterState>(
      listenWhen: (p, c) =>
          p.listingStatus != c.listingStatus ||
          p.updateStatus != c.updateStatus ||
          p.deleteStatus != c.deleteStatus,
      listener: (context, state) {
        if (state.updateStatus == FilterUpdateStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Updated successfully',
              ),
            ),
          );
        }
        if (state.deleteStatus == FilterUpdateStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Deleted successfully',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.listingStatus == FilterListStatus.loading) {
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(
              child: ProgressRing(),
            ),
          );
        }
        if (state.listingStatus == MarketListStatus.error) {
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(
              child: f.TryAgainButton(tryAgain: () {
                filterBloc.getAllFilters();
              }),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TitledAddBtn(
                onAdd: () {
                  showFluentAppDialog(
                    context,
                    content: CreateFilterPage(),
                  );
                },
                title: 'Filters',
              ),
              SizedBox(
                height: 8,
              ),
              TreeView(
                items: state.filterTypes?.map((e) {
                      return TreeViewItem(
                        backgroundColor: ButtonState.resolveWith(
                          (states) => Colors.white,
                        ),
                        content: Text(e.keys.first),
                        children: e.entries.first.value
                                ?.map(
                                  (e) => TreeViewItem(
                                    backgroundColor: selected_item == e.id
                                        ? ButtonState.resolveWith(
                                            (states) => Colors.grey[20],
                                          )
                                        : ButtonState.resolveWith(
                                            (states) => Colors.white,
                                          ),
                                    content: TreeViewItemContent(
                                      titleTextStyle: FluentTheme.of(context)
                                          .typography
                                          .body
                                          ?.copyWith(
                                            fontWeight: selected_item == e.id
                                                ? FontWeight.w500
                                                : null,
                                          ),
                                      title: e.name_tm ?? '-',
                                      onItemTap: () {
                                        widget.onFilterChanged.call(e);
                                        setState(() {
                                          selected_item = e.id ?? 0;
                                        });
                                      },
                                      onEdit: () async {
                                        final res = await showFluentAppDialog<
                                            FilterEntity>(
                                          context,
                                          content: UpdateFilterPage(
                                            filter: e,
                                          ),
                                        );

                                        if (res != null) {
                                          await filterBloc.updateFilter(res);
                                        }
                                      },
                                      onDelete: () async {
                                        final res =
                                            await showFluentAppDialog<bool>(
                                          context,
                                          content: DeleteDialog(),
                                        );
                                        if (res == true && e.id != null) {
                                          await filterBloc.deleteFilter(e.id!);
                                        }
                                      },
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}
