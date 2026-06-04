import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../providers/primbon_provider.dart';
import '../widgets/date_input_field.dart';
import 'info_nikah_screen.dart';
import 'info_weton_screen.dart';
import 'result_jodoh_section.dart';
import 'result_nikah_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PrimbonProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<PrimbonProvider>(
          builder: (context, p, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: 72,
                      height: 72,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.appTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 32),
                  DateInputField(
                    label: AppStrings.labelLanang,
                    value: p.tglLanang,
                    onChanged: p.setTglLanang,
                  ),
                  const SizedBox(height: 24),
                  DateInputField(
                    label: AppStrings.labelWedok,
                    value: p.tglWedok,
                    onChanged: p.setTglWedok,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {
                            await p.hitungKecocokan();
                            if (p.errorMessage != null && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(p.errorMessage!)),
                              );
                            }
                          },
                          child: const Text(AppStrings.hitungKecocokan),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).cardTheme.color,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () =>
                            Navigator.push(context, InfoWetonScreen.route()),
                        icon: const Icon(Icons.info_outline),
                        tooltip: AppStrings.pituduhWeton,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppTheme.nikahGradient,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.nikahEnd.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                await p.cariHariNikah();
                                if (p.errorMessage != null && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(p.errorMessage!)),
                                  );
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.favorite, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      AppStrings.cariHariNikah,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).cardTheme.color,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: () =>
                            Navigator.push(context, InfoNikahScreen.route()),
                        icon: const Icon(Icons.info_outline),
                        tooltip: AppStrings.caraCariNikah,
                      ),
                    ],
                  ),
                  if (p.resultView == ResultView.jodoh && p.hasilJodoh != null) ...[
                    const SizedBox(height: 32),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: ResultJodohSection(
                        key: ValueKey(p.hasilJodoh!.nama),
                        hasil: p.hasilJodoh!,
                      ),
                    ),
                  ],
                  if (p.resultView == ResultView.nikah && p.hasilNikah != null) ...[
                    const SizedBox(height: 32),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: ResultNikahSection(
                        key: ValueKey(p.hasilNikah!.angkaTarget),
                        hasil: p.hasilNikah!,
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                  Text(
                    AppStrings.riwayat.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  if (p.riwayat.isEmpty)
                    Text(
                      AppStrings.belumRiwayat,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    )
                  else
                    ...p.riwayat.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => p.loadFromRiwayat(item),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  Text(
                                    item.waktu,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
