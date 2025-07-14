import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth_state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBar extends StatefulWidget {
  MenuBar({
    Key? key,
    required this.constraints,
    this.menuItems,
    this.onItemTapped,
  }) : super(key: key);

  final BoxConstraints constraints;
  final List<SidebarItem>? menuItems;
  final ValueChanged<SidebarItem>? onItemTapped;

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.constraints.maxWidth * 0.3,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'YES',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                          letterSpacing: -5,
                          color: kswPrimaryColor,
                          fontSize: 30),
                    ),
                  ),
                  if (state.status == AuthStatus.authenticated) ...[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              await context.read<AuthBloc>().setAuthLoggedOut();
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 25,
                            ),
                            label: Text(
                              'Log Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.redAccent),
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                ],
              );
            }),
          ),
          if (widget.menuItems != null)
            Container(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView(
                // shrinkWrap: true,
                physics: ScrollPhysics(),
                controller: _controller,
                children: widget.menuItems!.map((e) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: kWhite,
                        primary: kGrey5Color,
                        elevation: 0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            e.logo ?? SizedBox(),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              e.title,
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
                      onPressed: widget.onItemTapped == null
                          ? null
                          : () => widget.onItemTapped!(e),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
