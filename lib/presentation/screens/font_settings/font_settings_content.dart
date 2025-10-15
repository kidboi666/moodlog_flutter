part of 'font_settings_view.dart';

class _FontSettingsContent extends StatelessWidget {
  final GoogleFontsRepository googleFontsRepository;

  const _FontSettingsContent({required this.googleFontsRepository});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final localFonts = LocalFont.values;

    return Scaffold(
      appBar: AppBar(title: Text('폰트 설정')),
      body: Column(
        children: [
          Expanded(
            child: RadioGroup<FontType>(
              groupValue: viewModel.appState.fontType,
              onChanged: (value) {
                viewModel.setFontType(value);
                Navigator.of(context).pop();
              },
              child: ListView(
                children: localFonts.map((localFont) {
                  return RadioListTile<FontType>(
                    value: localFont,
                    title: Text(
                      localFont.displayName,
                      style: TextStyle(
                        fontFamily: localFont.fontName,
                        fontSize: localFont.fixedFontSize,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showGoogleFontsBottomSheet(
                    context,
                    viewModel,
                    googleFontsRepository,
                  );
                },
                icon: Icon(Icons.cloud_download),
                label: Text('폰트 더보기'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showGoogleFontsBottomSheet(
    BuildContext context,
    SettingsViewModel viewModel,
    GoogleFontsRepository googleFontsRepository,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _GoogleFontsBottomSheet(
        viewModel: viewModel,
        googleFontsRepository: googleFontsRepository,
      ),
    );
  }
}

class _GoogleFontsBottomSheet extends StatefulWidget {
  final SettingsViewModel viewModel;
  final GoogleFontsRepository googleFontsRepository;

  const _GoogleFontsBottomSheet({
    required this.viewModel,
    required this.googleFontsRepository,
  });

  @override
  State<_GoogleFontsBottomSheet> createState() =>
      _GoogleFontsBottomSheetState();
}

class _GoogleFontsBottomSheetState extends State<_GoogleFontsBottomSheet> {
  String _searchQuery = '';
  bool _isLoading = false;
  bool _isInitialLoading = true;
  GoogleFontEntity? _loadingFont;
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
        setState(() {
          _errorMessage = '폰트 목록을 불러오는데 실패했습니다';
          _isInitialLoading = false;
        });
        _showErrorDialog();
      }
    }
  }

  List<GoogleFontEntity> get _filteredFonts {
    if (_searchQuery.isEmpty) return _allFonts;
    return _allFonts
        .where(
          (font) => font.family.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<void> _selectFont(GoogleFontEntity font) async {
    setState(() {
      _isLoading = true;
      _loadingFont = font;
      _errorMessage = null;
    });

    try {
      await Future.delayed(Duration(milliseconds: 500));
      widget.viewModel.setFontType(font);
      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '폰트 적용에 실패했습니다';
        });
        _showErrorDialog();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingFont = null;
        });
      }
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('오류'),
        content: Text(_errorMessage ?? '오류가 발생했습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Google Fonts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '폰트 검색',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isInitialLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: _filteredFonts.length,
                      itemBuilder: (context, index) {
                        final font = _filteredFonts[index];
                        final isLoading = _isLoading && _loadingFont == font;

                        return ListTile(
                          title: Text(
                            font.family,
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                            'ABC 가나다 あいう',
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(Icons.download),
                          onTap: isLoading ? null : () => _selectFont(font),
                        );
                      },
                    ),
            ),
          ],
        );
      },
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
