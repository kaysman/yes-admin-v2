import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/view-info.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandInfo extends StatefulWidget {
  const BrandInfo({Key? key, required this.selectedBrandId}) : super(key: key);
  final int? selectedBrandId;
  @override
  State<BrandInfo> createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  late BrandBloc brandBloc;

  @override
  void initState() {
    super.initState();
    brandBloc = BlocProvider.of<BrandBloc>(context);
    if (widget.selectedBrandId != null) {
      brandBloc.getBrandById(widget.selectedBrandId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandBloc, BrandState>(
      listenWhen: (s1, s2) => s1.selectedBrand != s2.selectedBrand,
      // && s1.getBrandByIdStatus != s2.getBrandByIdStatus,
      listener: (context, state) {
        print(state.getBrandByIdStatus);
      },
      builder: (context, state) {
        if (state.getBrandByIdStatus == GetBrandByIdStatus.loading) {
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
        if (state.getBrandByIdStatus == GetBrandByIdStatus.error) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: Center(
              child: TryAgainButton(
                tryAgain: () async {
                  if (widget.selectedBrandId != null) {
                    await brandBloc.getBrandById(widget.selectedBrandId!);
                  }
                },
              ),
            ),
          );
        }
        var brand = state.selectedBrand;
        return ViewInfoDialog(
          infoTitle: 'Brand barada',
          infoChildren: [
            brand?.fullPathLogo != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 34,
                      backgroundImage:
                          Image.network(brand!.fullPathLogo!).image,
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: kswPrimaryColor,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'Brand ady :',
              subTitle: '${brand?.name}',
            ),
            SizedBox(
              height: 10,
            ),
            InfoChild(
              title: 'VIP :',
              subTitle: '${brand?.vip == true ? 'Howwa' : 'Yok'}',
            ),
          ],
          productTitle: 'Brand harytlary',
          products: brand?.products ?? [],
        );
      },
    );
  }
}
