import 'package:flutter/cupertino.dart';

class ImageView extends StatelessWidget {

  final String url;

  const ImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty ? ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(url)) : ConstrainedBox(constraints: BoxConstraints(maxHeight: 100, maxWidth: 100), child: Image.asset('assets/images/no_photo.png'),);
  }
}
