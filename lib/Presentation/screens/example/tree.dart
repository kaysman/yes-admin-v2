import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Category {
  String name;
  List<Category>? subs;

  Category({
    required this.name,
    this.subs,
  });
}

class TreeViewImpl extends StatefulWidget {
  const TreeViewImpl({Key? key}) : super(key: key);

  @override
  State<TreeViewImpl> createState() => _TreeViewImplState();
}

class _TreeViewImplState extends State<TreeViewImpl> {
  List<Category> categories = [];

  @override
  void initState() {
    final f = Faker();
    categories.addAll(List.generate(
        f.randomGenerator.integer(5),
        (index) => Category(
            name: f.food.dish(),
            subs: List.generate(f.randomGenerator.integer(10),
                (index) => Category(name: f.food.cuisine())))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView(
      items: categories.map((e) {
        return TreeViewItem(
          content: Text(
            e.name,
            style: FluentTheme.of(context).typography.bodyStrong,
          ),
          children: e.subs
                  ?.map((e) => TreeViewItem(content: Text('${e.name}')))
                  .toList() ??
              [],
        );
      }).toList(),
    );
  }
}
