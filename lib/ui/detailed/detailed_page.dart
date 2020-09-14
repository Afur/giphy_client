import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/generated/l10n.dart';
import 'package:giphyclient/ui/base_page.dart';
import 'package:giphyclient/ui/detailed/detailed_cubit.dart';
import 'package:giphyclient/values/dimensions.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:giphyclient/extensions/kotlin_extensions.dart';
import 'package:share/share.dart';

class DetailedPage extends BasePage<DetailedCubit> {
  final Gif gif;

  DetailedPage(this.gif);

  @override
  _DetailedPageState createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  final searchQueryController = TextEditingController();

  @override
  void initState() {
    widget.cubit.checkIfSaved(widget.gif);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          gradient:
              LinearGradient(colors: [Color(0xff24cafc), Color(0xffce47c7)])),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: Dimensions.PADDING_M),
            Expanded(
              child: BlocBuilder<DetailedCubit, DetailedState>(
                cubit: widget.cubit,
                builder: (context, state) => state.when(
                    loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                    loaded: (isSaved) => _pageBody(isSaved),
                    error: () => new Container()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBody(bool isSaved) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.PADDING_XL, right: Dimensions.PADDING_XL),
            child: Image.network(widget.gif.configurations.original.url),
          )),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.PADDING_XL, right: Dimensions.PADDING_XL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [saveButton(isSaved), shareButton()],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget saveButton(bool isSaved) {
    return GestureDetector(
      onTap: () => widget.gif.let(
          (it) => isSaved ? widget.cubit.unsave(it) : widget.cubit.save(it)),
      child: Container(
        width: Dimensions.BUTTON_WIDTH,
        height: Dimensions.BUTTON_HEIGHT,
        color: Color(0xff686afb),
        child: Center(
          child: Text(
            isSaved ? S.of(context).unsave : S.of(context).save,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget shareButton() {
    return GestureDetector(
      onTap: () => Share.share(widget.gif.configurations.original.url),
      child: Container(
        width: Dimensions.BUTTON_WIDTH,
        height: Dimensions.BUTTON_HEIGHT,
        color: Color(0xff686afb),
        child: Center(
          child: Text(S.of(context).share, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
