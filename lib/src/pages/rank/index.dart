import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkkl/src/constants/index.dart';
import 'package:pkkl/src/constants/themes/colors.dart';
import 'package:pkkl/src/constants/themes/dimens.dart';
import 'package:pkkl/src/widgets/inkwell.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Penilaian'),
        toolbarHeight: 56,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildAsk),
          SliverToBoxAdapter(child: _buildButton),
        ],
      ),
    );
  }

  Widget get _buildAsk {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: inset(12),
      itemBuilder: (context, index) {
        return Container(
          padding: insetSymmetric(10, 8),
          decoration: BoxDecoration(
            color: neutral1Color,
            borderRadius: borderRadius(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}. ',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: neutral8Color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Menurut kriteria penilaian anda apakah yang bersangkutan dapat memahami dan memenuhi kebutuhan masyarakat dalam tugasnya sebagai Kepala Lingkungan?',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  width(4),
                  InkWellWidget(
                    onTap: () {},
                    radius: borderRadius(20),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: neutral8Color,
                    ),
                  ),
                ],
              ),
              height(8),
              Text('Jawaban', style: Get.textTheme.bodySmall),
              height(2),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: scores.map((e) {
                  return Container(
                    decoration: BoxDecoration(
                      color: neutral1Color,
                      border: Border.all(color: neutral5Color),
                      borderRadius: borderRadius(20),
                    ),
                    child: InkWellWidget(
                      padding: insetSymmetric(8, 4),
                      radius: borderRadius(20),
                      onTap: () {},
                      child: Text(
                        e.name ?? '',
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: neutralColor,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => height(),
      itemCount: 20,
    );
  }

  Widget get _buildButton {
    return Padding(
      padding: inset(12),
      child: ElevatedButton(
        onPressed: () {},
        child: const Center(child: Text('Simpan')),
      ),
    );
  }
}
