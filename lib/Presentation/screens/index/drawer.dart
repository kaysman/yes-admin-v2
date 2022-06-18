import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Drawer(
      width: constraints.maxWidth * 0.3,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return state.status == AuthStatus.authenticated
                  ? Row(
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
                    )
                  : SizedBox.shrink();
            }),
          ),
          if (menuItems != null)
            ...menuItems!.map((e) {
              return ListTile(
                title: Text(e.title),
                subtitle: e.subtitle != null ? Text(e.subtitle!) : null,
                onTap: onItemTapped == null ? null : () => onItemTapped!(e),
              );
            }),
        ],
      ),
    );
  }
}
