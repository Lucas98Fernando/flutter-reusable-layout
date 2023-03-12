import 'package:flutter/material.dart';

abstract class IBuilder {
  void buildAppBar({required String title});
  void buildOptions({required List<num> list});
}

class DefaultLayoutBuilder implements IBuilder {
  late Layout layout;

  DefaultLayoutBuilder() {
    reset();
  }

  reset() => layout = Layout();

  @override
  buildAppBar({required String title}) {
    layout.parts.add(
      AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  buildOptions({required List<num> list}) {
    layout.parts.add(
      Column(
        children: [
          ...list.map((e) => Text(e.toString())),
        ],
      ),
    );
  }

  Layout getLayout() {
    final result = layout;
    reset();
    return result;
  }
}

class Layout {
  late List<Widget> parts = [];

  generateProduct() {
    return Column(
      children: [
        ...parts,
      ],
    );
  }
}

class BuilderPage {
  late IBuilder builder;

  setBuilder(IBuilder builder) {
    this.builder = builder;
  }

  void buildMinimalViableProduct({required String title}) {
    builder.buildAppBar(title: title);
  }

  void buildFullFeaturedProduct({
    required String title,
    required List<num> list,
  }) {
    builder.buildAppBar(title: title);
    builder.buildOptions(list: list);
  }
}

class ReusableLayout extends StatelessWidget {
  const ReusableLayout({Key? key}) : super(key: key);

  List<Widget> buildMinimalLayout(BuilderPage builderPage) {
    final builder = DefaultLayoutBuilder();

    builderPage.setBuilder(builder);
    builderPage.buildMinimalViableProduct(title: "Hello!");
    return builder.getLayout().parts;
  }

  List<Widget> buildFullLayout(BuilderPage builderPage) {
    final builder = DefaultLayoutBuilder();

    builderPage.setBuilder(builder);
    builderPage.buildFullFeaturedProduct(title: "Hello!", list: [1, 2, 3]);
    return builder.getLayout().parts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...buildFullLayout(BuilderPage()),
        ],
      ),
    );
  }
}
