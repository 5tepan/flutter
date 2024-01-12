import 'package:flutter/material.dart';
import 'package:shop/core/model/base_data_model.dart';

abstract class BasePage<T extends BaseModel> extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState<T> createState() => _BasePageState<T>();

  T createProvider(BuildContext context);

  Widget buildBody(BuildContext context, T model);
  Widget buildAppBarTitle();
}

class _BasePageState<T extends BaseModel> extends State<BasePage<T>> {
  late final T _pageModel;

  @override
  void initState() {
    _pageModel = widget.createProvider(context);
    _loadData();
    super.initState();
  }

  void _loadData() async {
    await _pageModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: buildAppBar(theme),
      body: ListenableBuilder(
        listenable: _pageModel,
        builder: (context, child) {
          if (_pageModel.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_pageModel.error.isNotEmpty) {
            return Center(child: Text('Error: ${_pageModel.error}'));
          } else {
            return widget.buildBody(context, _pageModel);
          }
        },
      ),
    );
  }

  PreferredSizeWidget buildAppBar(ThemeData theme) {
    return AppBar(
      title: widget.buildAppBarTitle(),
      backgroundColor: theme.colorScheme.inversePrimary,
    );
  }

  Widget buildAppBarTitle() {
    return const Text('Default title');
  }
}
