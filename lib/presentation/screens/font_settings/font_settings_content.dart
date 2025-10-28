part of 'font_settings_view.dart';

class _FontSettingsContent extends StatefulWidget {
  final GoogleFontsRepository googleFontsRepository;

  const _FontSettingsContent({required this.googleFontsRepository});

  @override
  State<_FontSettingsContent> createState() => _FontSettingsContentState();
}

class _FontSettingsContentState extends State<_FontSettingsContent> {
  String _searchQuery = '';
  bool _isInitialLoading = true;
  bool _isLoadingFont = false;
  FontType? _loadingFont;
  String? _errorMessage;
  List<GoogleFontEntity> _allFonts = [];

  @override
  void initState() {
    super.initState();
    _loadFonts();
  }

  Future<void> _loadFonts() async {
    try {
      final fonts = await widget.googleFontsRepository.getAllFonts();
      if (mounted) {
        setState(() {
          _allFonts = fonts;
          _isInitialLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          _errorMessage = l10n.font_settings_error_load_failed;
          _isInitialLoading = false;
        });
      }
    }
  }

  List<_FontSection> _getFontSections(FontType currentFont) {
    final sections = <_FontSection>[];

    final l10n = AppLocalizations.of(context)!;

    // 기본 폰트 섹션 (Pretendard)
    final defaultFont = LocalFont.pretendard;
    sections.add(
      _FontSection(
        title: l10n.font_settings_section_default,
        fonts: [defaultFont],
      ),
    );

    // 선택된 폰트 섹션 (기본 폰트가 아닌 경우)
    if (currentFont != defaultFont) {
      sections.add(
        _FontSection(
          title: l10n.font_settings_section_selected,
          fonts: [currentFont],
        ),
      );
    }

    // 나머지 폰트 섹션
    final allGoogleFonts = _searchQuery.isEmpty
        ? _allFonts.cast<FontType>()
        : _allFonts
              .where(
                (font) => font.family.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
              )
              .cast<FontType>();

    final remainingFonts = allGoogleFonts
        .where((font) => font != currentFont && font != defaultFont)
        .toList();

    if (remainingFonts.isNotEmpty) {
      sections.add(
        _FontSection(
          title: l10n.font_settings_section_all,
          fonts: remainingFonts,
        ),
      );
    }

    return sections;
  }

  Future<void> _selectFont(FontType font) async {
    if (font is GoogleFontEntity) {
      setState(() {
        _isLoadingFont = true;
        _loadingFont = font;
        _errorMessage = null;
      });

      try {
        await Future.delayed(Duration(milliseconds: 500));
        if (mounted) {
          context.read<SettingsViewModel>().setFontType(font);
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          setState(() {
            _isLoadingFont = false;
            _loadingFont = null;
            _errorMessage = l10n.font_settings_error_apply_failed;
          });
          _showErrorDialog();
        }
      }
    } else {
      try {
        context.read<SettingsViewModel>().setFontType(font);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          setState(() {
            _errorMessage = l10n.font_settings_error_apply_failed;
          });
          _showErrorDialog();
        }
      }
    }
  }

  void _showErrorDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.font_settings_error_title),
        content: Text(_errorMessage ?? l10n.font_settings_error_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.common_confirm_ok),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildFontItem(FontType font, FontType currentFont) {
    final isLoading = _isLoadingFont && _loadingFont == font;

    if (font is LocalFont) {
      return RadioListTile<FontType>(
        value: font,
        title: Text(font.displayName),
      );
    } else if (font is GoogleFontEntity) {
      return ListTile(
        title: Text(font.family, style: TextStyle(fontSize: 16)),
        leading: Radio<FontType>(
          value: font,
          groupValue: currentFont,
          onChanged: isLoading
              ? null
              : (value) {
                  if (value != null) {
                    _selectFont(value);
                  }
                },
        ),
        trailing: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : null,
        onTap: isLoading ? null : () => _selectFont(font),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final currentFont = context.select(
      (SettingsViewModel vm) => vm.appState.fontType,
    );
    final l10n = AppLocalizations.of(context)!;
    final fontSections = _getFontSections(currentFont);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.font_settings_title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: l10n.font_settings_search_hint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isInitialLoading
                ? Center(child: CircularProgressIndicator())
                : RadioGroup<FontType>(
                    groupValue: currentFont,
                    onChanged: _selectFont,
                    child: ListView.builder(
                      itemCount: fontSections.fold<int>(
                        0,
                        (sum, section) => sum + section.fonts.length + 1,
                      ),
                      itemBuilder: (context, index) {
                        int currentIndex = 0;
                        for (final section in fontSections) {
                          if (index == currentIndex) {
                            return _buildSectionHeader(section.title);
                          }
                          currentIndex++;

                          if (index < currentIndex + section.fonts.length) {
                            final fontIndex = index - currentIndex;
                            final font = section.fonts[fontIndex];
                            return _buildFontItem(font, currentFont);
                          }
                          currentIndex += section.fonts.length;
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class RadioGroup<T> extends InheritedWidget {
  final T groupValue;
  final ValueChanged<T> onChanged;

  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  static RadioGroup<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RadioGroup<T>>();
  }

  @override
  bool updateShouldNotify(RadioGroup<T> oldWidget) {
    return oldWidget.groupValue != groupValue;
  }
}

class RadioListTile<T> extends StatelessWidget {
  final T value;
  final Widget title;

  const RadioListTile({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    final group = RadioGroup.of<T>(context);
    if (group == null) {
      throw FlutterError('RadioListTile must be wrapped with RadioGroup');
    }

    return ListTile(
      title: title,
      leading: Radio<T>(
        value: value,
        groupValue: group.groupValue,
        onChanged: (T? newValue) {
          if (newValue != null) {
            group.onChanged(newValue);
          }
        },
      ),
      onTap: () => group.onChanged(value),
    );
  }
}

class _FontSection {
  final String title;
  final List<FontType> fonts;

  _FontSection({required this.title, required this.fonts});
}
