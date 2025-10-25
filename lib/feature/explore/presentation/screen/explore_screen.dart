// feature/property_filter/presentation/widgets/search_sheet.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_real_state/config/theme/app_text_style.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_cubit.dart';
import 'package:nawy_real_state/feature/explore/presentation/manger/browse_state.dart';

import '../widget/tab_bar_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late final TabController _tabController;

  Timer? _debounce;
  bool _isTyping = false;
  bool _touchedField = false;
  final tabs = const [
    Tab(text: 'All'),
    Tab(text: 'Compounds'),
    Tab(text: 'Locations'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _controller.addListener(_onChanged);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging &&
          _tabController.index == _tabController.animation?.value.round()) {}
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {
      _isTyping = true; // show shimmer as user types
    });

    // Debounce: wait for the user to stop typing
    _debounce?.cancel();

    // final filtered = _filterItems(query);
    setState(() {
      // _results = filtered;
      _isTyping = false; // typing paused, show results now
    });
  }

  @override
  Widget build(BuildContext context) {
    final showEmptyState =
        _touchedField && _controller.text.isEmpty && !_isTyping;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(title: const Text('Search'), centerTitle: false),
        body: BlocConsumer<BrowseCubit, BrowseState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Area, Compound, Developer',
                        hintStyle: TextStyles.light12LightGray(context),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (change) {
                        context.read<BrowseCubit>().searchByCategory(
                          _controller.text,
                          _tabController.index,
                        );
                      },

                      onTap: () {
                        if (!_touchedField) {
                          setState(() => _touchedField = true);
                        }
                      },
                    ),
                  ),
                  _controller.text.isNotEmpty
                      ? TabBar(
                          onTap: (int index) {
                            context.read<BrowseCubit>().searchByCategory(
                              _controller.text,
                              index,
                            );
                          },
                          controller: _tabController,
                          isScrollable: false,
                          tabs: tabs,
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TabCompoundContent(
                          key: const PageStorageKey('tab_all'),
                          state: state,
                          touchedField: _touchedField,
                          isTyping: _isTyping,
                          showEmptyState: showEmptyState,
                        ),
                        TabAllContent(
                          key: const PageStorageKey('tab_compounds'),
                          state: state,
                          touchedField: _touchedField,
                          isTyping: _isTyping,
                          showEmptyState: showEmptyState,
                        ),
                        TabLocationContent(
                          key: const PageStorageKey('tab_locations'),
                          state: state,
                          touchedField: _touchedField,
                          isTyping: _isTyping,
                          showEmptyState: showEmptyState,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
