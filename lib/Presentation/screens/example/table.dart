import 'package:faker/faker.dart' as faker;
import 'package:fluent_ui/fluent_ui.dart';

import 'dashboard.dart' show Person;

class FluentTable extends StatefulWidget {
  const FluentTable({Key? key}) : super(key: key);

  @override
  State<FluentTable> createState() => _FluentTableState();
}

class _FluentTableState extends State<FluentTable> {
  List<Person> people = [];
  List<String> columns = ['Name', 'Email', 'Phone', 'Address'];
  Person? hoveredP;

  final autoSuggestBox = TextEditingController();

  @override
  void initState() {
    final f = faker.Faker();
    people.addAll(List.generate(
        10,
        (index) => Person(
              f.person.firstName(),
              f.internet.email(),
              f.phoneNumber.us(),
              f.address.city(),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hoveredP != null) {
          setState(() {
            hoveredP = null;
          });
        }
      },
      child: ScaffoldPage(
        header: PageHeader(
          commandBar: SizedBox(
            width: 600,
            child: CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
              compactBreakpointWidth: 300,
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.search),
                  label: const Text('Search'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return ContentDialog(
                          constraints: BoxConstraints(maxWidth: 800),
                          title: Text('Search Box'),
                          content: _autoSuggestBox(),
                          actions: [
                            Button(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FilledButton(
                              child: Text('Go'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.add),
                  label: const Text('Add'),
                  onPressed: () {},
                ),
              ],
              secondaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.archive),
                  label: const Text('Archive'),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.move),
                  label: const Text('Move'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        content: Column(
          children: [
            ...people.map((p) {
              final selected = hoveredP == p;
              return MouseRegion(
                onHover: (v) {
                  setState(() {
                    hoveredP = p;
                  });
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(8),
                      tileColor:
                          selected ? Color.fromARGB(255, 255, 247, 238) : null,
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 207, 159),
                        child: Center(child: Text(p.name[0].toUpperCase())),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(p.name,
                                  overflow: TextOverflow.ellipsis)),
                          Expanded(
                              child: Text(p.phone,
                                  overflow: TextOverflow.ellipsis)),
                          Expanded(
                              child: Text(p.email,
                                  overflow: TextOverflow.ellipsis)),
                          Expanded(
                              child: Text(p.address,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                    if (selected)
                      Positioned(
                        right: 10,
                        child: DropDownButton(
                          leading: Icon(FluentIcons.more),
                          items: [
                            MenuFlyoutItem(
                              leading: const Icon(FluentIcons.edit),
                              onPressed: () {},
                              text: Text('Edit'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  _autoSuggestBox() {
    return AutoSuggestBox(
      controller: autoSuggestBox,
      items: people.map((e) => e.name).toList(),
      placeholder: 'adidas, etc',
      scrollPadding: EdgeInsets.all(28),
    );
  }
}
