import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../providers/primbon_provider.dart';
import '../widgets/date_input_field.dart';
import 'info_nikah_screen.dart';
import 'info_weton_screen.dart';
import 'nikah_calendar_screen.dart';
import 'result_jodoh_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                              onTap: () {
                                if (p.tglLanang == null || p.tglWedok == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(AppStrings.tanggalKosong),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  NikahCalendarScreen.route(
                                    tglLanang: p.tglLanang!,
                                    tglWedok: p.tglWedok!,
                                  ),
                                );
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
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
