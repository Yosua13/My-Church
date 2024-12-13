import 'package:flutter/material.dart';
import 'package:proyek_akhir/models/church_model.dart';
import 'package:proyek_akhir/routes/details_mobile_page.dart';
import 'package:proyek_akhir/routes/details_web_and_tablet_page.dart';

class ChurchDetailPage extends StatelessWidget {
  final ChurchModel church;

  const ChurchDetailPage({super.key, required this.church});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return DetailsWebAndTabletPage(church: church);
      } else {
        return DetailsMobilePage(church: church);
      }
    });
  }
}
