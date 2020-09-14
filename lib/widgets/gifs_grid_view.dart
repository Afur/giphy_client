import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/widgets/gif_preview.dart';

class GifsGridView extends StatelessWidget {
  final List<Gif> gifs;
  final VoidCallback onScrolledToBottom;
  final ScrollController _controller = ScrollController();

  GifsGridView(this.gifs, {this.onScrolledToBottom}) {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          onScrolledToBottom.call();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: gifs.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) =>
            GifPreview(gifs[index]),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 16.0,
      );
}
