import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphyclient/api/models/gif.dart';
import 'package:giphyclient/ui/detailed/detailed_page.dart';
import 'package:giphyclient/ui/content/content_cubit.dart';

class GifPreview extends StatelessWidget {
  final Gif gif;

  GifPreview(this.gif);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailedPage(gif)),
          );

          BlocProvider.of<ContentCubit>(context).refresh();
        },
        child: Image.network(
          gif.configurations.preview.url,
          width: double.parse(gif.configurations.preview.width),
          height: double.parse(gif.configurations.preview.height),
        ),
      );
}
