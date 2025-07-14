import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';

class FilterInfo extends StatefulWidget {
  const FilterInfo({Key? key, required this.selectedFilterId})
      : super(key: key);
  final int? selectedFilterId;
  @override
  State<FilterInfo> createState() => _FilterInfoState();
}

class _FilterInfoState extends State<FilterInfo> {
  late FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = BlocProvider.of<FilterBloc>(context);
    if (widget.selectedFilterId != null) {
      filterBloc.getFilterById(widget.selectedFilterId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterBloc, FilterState>(
      listenWhen: (s1, s2) => s1.selectedFilter != s2.selectedFilter,
      listener: (context, state) {},
      builder: (context, state) {
        if (state.getFilterByIdStatus == GetFilterByIdStatus.loading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: CircularProgressIndicator(
                color: kswPrimaryColor,
              ),
            ),
          );
        }
        if (state.selectedFilter == GetFilterByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedFilterId != null) {
                    await filterBloc.getFilterById(widget.selectedFilterId!);
                  }
                },
              ),
            ),
          );
        }
        var filter = state.selectedFilter;
        return ViewInfoDialog(
          infoTitle: 'Filter barada',
          infoChildren: [
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Filterin ady-tm :',
              subTitle: '${filter?.name_tm}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Filterin ady-ru :',
              subTitle: '${filter?.name_ru}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Filterin gornusi :',
              subTitle: '${filter!.type?.readableText}',
            ),
          ],
          productTitle: 'Filterin harytlary',
          products: filter.products ?? [],
        );
      },
    );
  }
}
