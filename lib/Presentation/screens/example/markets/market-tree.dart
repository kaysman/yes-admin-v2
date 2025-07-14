import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-update.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/delete-dialog.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/markets/market-create.dart';
import 'package:admin_v2/Presentation/screens/markets/market-update.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../brands/bloc/brand.bloc.dart';
import '../../brands/bloc/brand.state.dart';
import '../widgets/titled-add-btn.dart';
import '../widgets/tree-view-item-content.dart';

class Category {
  String name;
  List<Category>? subs;

  Category({
    required this.name,
    this.subs,
  });
}

class MarketTreeViewImpl extends StatefulWidget {
  const MarketTreeViewImpl({
    Key? key,
    required this.onMarketIdChanged,
  }) : super(key: key);

  final ValueChanged<MarketEntity> onMarketIdChanged;

  @override
  State<MarketTreeViewImpl> createState() => _MarketTreeViewImplState();
}

class _MarketTreeViewImplState extends State<MarketTreeViewImpl> {
  late MarketBloc marketBloc;
  int selected_item = 0;
  String? action;
  MarketEntity? market;

  @override
  void initState() {
    marketBloc = BlocProvider.of<MarketBloc>(context);
    if (marketBloc.state.markets?.isNotEmpty == true) {
      var market = marketBloc.state.markets?.first;
      selected_item = market?.id ?? 0;
    }
    super.initState();
  }

  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      listenWhen: (p, c) =>
          p.listingStatus != c.listingStatus ||
          p.createStatus != c.createStatus ||
          p.marketDeleteStatus != c.marketDeleteStatus,
      listener: (context, state) {
        // log(state.brandUpdateStatus);
        if (state.marketUpadteStatus == MarketUpadteStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Updated successfully',
              ),
            ),
          );
        }
        if (state.marketDeleteStatus == MarketDeleteStatus.success) {
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
        if (state.listingStatus == MarketListStatus.loading) {
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
                marketBloc.getAllMarkets();
              }),
            ),
          );
        }
        var markets = state.markets;

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
                    content: CreateMarketPage(),
                  );
                },
                title: 'Markets',
              ),
              SizedBox(
                height: 8,
              ),
              TreeView(
                items: markets?.map(
                      (e) {
                        return TreeViewItem(
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
                            title: e.title ?? '-',
                            onItemTap: () {
                              widget.onMarketIdChanged.call(e);
                              setState(() {
                                selected_item = e.id ?? 0;
                              });
                            },
                            onEdit: () async {
                              final res =
                                  await showFluentAppDialog<MarketEntity>(
                                context,
                                content: UpdateMarketPage(
                                  market: e,
                                ),
                              );

                              if (res != null) {
                                await marketBloc.updateMarket(res);
                              }
                            },
                            onDelete: () async {
                              final res = await showFluentAppDialog<bool>(
                                context,
                                content: DeleteDialog(),
                              );
                              if (res == true && e.id != null) {
                                await marketBloc.deleteMarket(e.id!);
                              }
                            },
                          ),
                        );
                      },
                    ).toList() ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}
