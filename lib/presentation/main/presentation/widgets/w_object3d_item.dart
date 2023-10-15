import '/core/resources/app_toast.dart';
import '/core/resources/styles.dart';
import '/presentation/main/data/models/object_3d_dto.dart';
import '/presentation/main/presentation/manager/objects/objects_screen_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class WObject3DItem extends StatelessWidget {
  final Object3Ddto object3ddto;

  const WObject3DItem({
    Key? key,
    required this.object3ddto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchARView(context, object3ddto),
      child: ListTile(
        leading: Container(
          clipBehavior: Clip.hardEdge,
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF262839),
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            imageUrl: object3ddto.image,
            width: 16,
            height: 16,
          ),
        ),
        title: Text(
          object3ddto.name,
          style: Styles.getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          object3ddto.excerpt,
          style:
              Styles.getTextStyle(fontSize: 12, color: const Color(0xFF7C7C7C)),
        ),
      ),
    );
  }

  Future<void> _launchARView(BuildContext context, Object3Ddto model) async {
    final String encodedModelUrl = Uri.encodeComponent(model.url);
    final String arUrl =
        'https://arvr.google.com/scene-viewer/1.0?file=$encodedModelUrl&mode=ar_preferred';
    context.read<ObjectsScreenBloc>().add(ObjectRead(objectId: model.id));
    if (!await launchUrl(Uri.parse(arUrl))) {
      AppToast.show(context: context, message: "Cannot launch the model");
    }
  }
}
