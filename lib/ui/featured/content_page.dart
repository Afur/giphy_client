import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/generated/l10n.dart';
import 'package:giphyclient/ui/base_page.dart';
import 'package:giphyclient/ui/featured/content_cubit.dart';
import 'package:giphyclient/values/dimensions.dart';
import 'package:giphyclient/widgets/centered_text.dart';
import 'package:giphyclient/widgets/gifs_grid_view.dart';
import 'package:giphyclient/extensions/kotlin_extensions.dart';

class ContentPage extends BasePage<ContentCubit> {
  final bool showSavedOnly;

  ContentPage({this.showSavedOnly = false});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.showSavedOnly
        ? widget.cubit.fetchSaved()
        : searchQueryController.text.let((query) => query.isNotEmpty
            ? widget.cubit.search(query)
            : widget.cubit.fetchFeatured());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (!widget.showSavedOnly) _searchBar(),
            const SizedBox(height: Dimensions.PADDING_M),
            Expanded(
              child: _pageBody(),
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBody() {
    return BlocProvider.value(
        value: widget.cubit,
        child: BlocBuilder<ContentCubit, ContentState>(
          cubit: widget.cubit,
          builder: (context, state) => state.when(
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ),
              loaded: (gifs) => _contentGrid(gifs),
              error: () => new Container()),
        ));
  }

  Widget _searchBar() {
    return Container(
      height: 45,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: Center(
            child: TextField(
              controller: searchQueryController,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: Dimensions.PADDING_XS),
              ),
              style: TextStyle(fontSize: 20),
            ),
          )),
          GestureDetector(
            onTap: () => searchQueryController.text.let((query) =>
                query.isNotEmpty
                    ? widget.cubit.search(query)
                    : widget.cubit.fetchFeatured()),
            child: SvgPicture.asset(
              "icons/search.svg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentGrid(List<Gif> gifs) {
    if (gifs.isEmpty) {
      var message = widget.showSavedOnly
          ? S.of(context).no_saved_gifs
          : S.of(context).no_gifs_found;
      return CenteredText(message);
    }

    return GifsGridView(
      gifs,
      onScrolledToBottom: () => widget.cubit.loadMore(),
    );
  }
}
