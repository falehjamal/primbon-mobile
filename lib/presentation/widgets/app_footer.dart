import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';

/// Footer copyright di bagian bawah setiap halaman.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key, this.compact = false});

  /// Versi lebih rapat untuk splash / layar pendek.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.secondary;
    final year = DateTime.now().year;
    final vPad = compact ? 20.0 : 32.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, vPad, 24, compact ? 16 : 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            margin: EdgeInsets.only(bottom: compact ? 14 : 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  secondary.withValues(alpha: 0.2),
                  secondary.withValues(alpha: 0.35),
                  secondary.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
                stops: const [0, 0.25, 0.5, 0.75, 1],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.footerMadeWith,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: secondary,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(width: 4),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    AppTheme.nikahGradient.createShader(bounds),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 13,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.footerBy,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: secondary,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                AppStrings.footerBrand,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.footerCopyright(year),
            style: theme.textTheme.labelSmall?.copyWith(
              color: secondary.withValues(alpha: 0.75),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
