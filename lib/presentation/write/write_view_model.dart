import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:logging/logging.dart';

import '../../core/constants/enum.dart';
import '../../core/mixins/async_state_mixin.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/journal/journal.dart';
import '../../domain/entities/journal/location_info.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/entities/journal/weather_info.dart';
import '../../domain/models/create_journal_request.dart';
import '../../domain/models/update_journal_ai_response_request.dart';
import '../../domain/models/update_journal_request.dart';
import '../../domain/use_cases/check_ai_usage_limit_use_case.dart';
import '../../domain/use_cases/gemini_use_case.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/journal_use_case.dart';
import '../../domain/use_cases/log_mood_entry_use_case.dart';
import '../../domain/use_cases/pick_image_use_case.dart';
import '../../domain/use_cases/settings_use_case.dart';
import '../../domain/use_cases/tag_use_case.dart';
import '../../domain/use_cases/weather_use_case.dart';
import '../../presentation/providers/app_state_provider.dart';
import '../providers/ai_generation_provider.dart';

class WriteViewModel extends ChangeNotifier with AsyncStateMixin {
  final GeminiUseCase _geminiUseCase;
  final AppStateProvider _appStateProvider;
  final AiGenerationProvider _aiGenerationProvider;
  final PickImageUseCase _pickImageUseCase;
  final SettingsUseCase _settingsUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherUseCase _weatherUseCase;
  final JournalUseCase _journalUseCase;
  final CheckAiUsageLimitUseCase _checkAiUsageLimitUseCase;
  final LogMoodEntryUseCase _logMoodEntryUseCase;
  final TagUseCase _tagUseCase;

  WriteViewModel({
    required GeminiUseCase geminiUseCase,
    required AppStateProvider appStateProvider,
    required AiGenerationProvider aiGenerationProvider,
    required PickImageUseCase pickImageUseCase,
    required SettingsUseCase settingsUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required WeatherUseCase weatherUseCase,
    required JournalUseCase journalUseCase,
    required CheckAiUsageLimitUseCase checkAiUsageLimitUseCase,
    required TagUseCase tagUseCase,
    required LogMoodEntryUseCase logMoodEntryUseCase,
    DateTime? selectedDate,
    int? editJournalId,
  }) : _geminiUseCase = geminiUseCase,
       _appStateProvider = appStateProvider,
       _aiGenerationProvider = aiGenerationProvider,
       _pickImageUseCase = pickImageUseCase,
       _settingsUseCase = settingsUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _weatherUseCase = weatherUseCase,
       _journalUseCase = journalUseCase,
       _logMoodEntryUseCase = logMoodEntryUseCase,
       _checkAiUsageLimitUseCase = checkAiUsageLimitUseCase,
       _tagUseCase = tagUseCase,
       _selectedDate = selectedDate ?? DateTime.now(),
       _editJournalId = editJournalId,
       _isEditMode = editJournalId != null {
    _initialize();
  }

  final Logger _log = Logger('WriteViewModel');
  late QuillController _quillController;
  String? _content;
  MoodType _selectedMood = MoodType.neutral;
  List<String> _selectedImageList = [];
  bool _isSubmitted = false;
  int? _submittedJournalId;
  bool _aiEnabled = true;
  DateTime _selectedDate;
  bool _canUseAiToday = true;
  LocationInfo? _locationInfo;
  bool _isLoadingLocation = false;
  WeatherInfo? _weatherInfo;
  bool _isLoadingWeather = false;
  List<Tag> _availableTags = [];
  List<Tag> _selectedTags = [];
  final bool _isEditMode;
  final int? _editJournalId;

  QuillController get quillController => _quillController;

  String? get content => _content;

  bool get aiEnabled => _aiEnabled;

  MoodType get selectedMood => _selectedMood;

  DateTime get selectedDate => _selectedDate;

  List<String> get selectedImageList => _selectedImageList;

  bool get isSubmitted => _isSubmitted;

  int? get submittedJournalId => _submittedJournalId;

  bool get canUseAiToday => _canUseAiToday;

  bool get isAiAvailable => _aiEnabled && _canUseAiToday;

  LocationInfo? get locationInfo => _locationInfo;

  bool get isLoadingLocation => _isLoadingLocation;

  WeatherInfo? get weatherInfo => _weatherInfo;

  bool get isLoadingWeather => _isLoadingWeather;

  List<Tag> get availableTags => _availableTags;

  bool get isEditMode => _isEditMode;

  List<Tag> get selectedTags => _selectedTags;

  bool get isFormValid {
    return _content != null &&
        _content!.trim().isNotEmpty &&
        !_isLoadingLocation;
  }

  void _initialize() {
    _quillController = QuillController.basic();
    _quillController.addListener(_onQuillTextChanged);
    _checkAiUsageLimit();
    _loadCurrentLocationOnInit();
    _loadCurrentWeatherOnInit();
    _loadAllTags();
    if (_isEditMode) {
      _loadJournalForEdit(_editJournalId!);
    }
  }

  void _onQuillTextChanged() {
    try {
      // QuillDocument에서 마크다운 형태의 텍스트를 생성하여 저장
      final markdownText = _convertDocumentToMarkdown(
        _quillController.document,
      );
      updateContent(markdownText);
    } catch (e) {
      _log.warning('Failed to convert document to markdown: $e');
      // 실패 시 plain text만 저장
      final plainText = _quillController.document.toPlainText();
      updateContent(plainText);
    }
  }

  String _convertDocumentToMarkdown(Document document) {
    final buffer = StringBuffer();
    final operations = document.toDelta().operations;

    for (final op in operations) {
      if (op.data is String) {
        String text = op.data as String;

        // 포맷팅 적용
        if (op.attributes != null) {
          final attributes = op.attributes!;

          // 볼드 처리
          if (attributes.containsKey('bold') && attributes['bold'] == true) {
            text = '**$text**';
          }
          // 이탤릭 처리
          else if (attributes.containsKey('italic') &&
              attributes['italic'] == true) {
            text = '*$text*';
          }
          // 밑줄 처리
          else if (attributes.containsKey('underline') &&
              attributes['underline'] == true) {
            text = '__${text}__';
          }
          // 취소선 처리
          else if (attributes.containsKey('strike') &&
              attributes['strike'] == true) {
            text = '~~$text~~';
          }
        }

        buffer.write(text);
      }
    }

    return buffer.toString();
  }

  Document _parseMarkdownToDocument(String content) {
    final document = Document();

    // 마크다운 패턴을 순서대로 처리
    final patterns = [
      {'pattern': r'\*\*(.*?)\*\*', 'attribute': Attribute.bold},
      {'pattern': r'__(.*?)__', 'attribute': Attribute.underline},
      {'pattern': r'~~(.*?)~~', 'attribute': Attribute.strikeThrough},
      {'pattern': r'(?<!\*)\*([^*]+?)\*(?!\*)', 'attribute': Attribute.italic},
    ];

    String processedContent = content;
    final List<Map<String, dynamic>> formatRanges = [];

    // 각 패턴에 대해 매치 찾기
    for (final patternData in patterns) {
      final pattern = patternData['pattern'] as String;
      final attribute = patternData['attribute'] as Attribute;
      final regex = RegExp(pattern);

      final matches = regex.allMatches(processedContent).toList();

      // 역순으로 처리하여 인덱스 변화 방지
      for (final match in matches.reversed) {
        final matchText = match.group(1) ?? '';
        final start = match.start;
        final end = match.end;

        // 포맷 정보 저장
        formatRanges.add({
          'start': start,
          'length': matchText.length,
          'attribute': attribute,
        });

        // 마크다운 마커 제거하고 텍스트만 남기기
        processedContent =
            processedContent.substring(0, start) +
            matchText +
            processedContent.substring(end);
      }
    }

    // 텍스트 삽입
    document.insert(0, processedContent);

    // 포맷 적용 (시작 위치 기준으로 정렬)
    formatRanges.sort((a, b) => a['start'].compareTo(b['start']));

    int offset = 0;
    for (final range in formatRanges) {
      final start = range['start'] as int;
      final length = range['length'] as int;
      final attribute = range['attribute'] as Attribute;

      document.format(start - offset, length, attribute);

      // 제거된 마커 길이만큼 오프셋 조정
      offset += _getMarkerLength(attribute) * 2; // 시작/끝 마커
    }

    return document;
  }

  int _getMarkerLength(Attribute attribute) {
    if (attribute == Attribute.bold) return 2; // **
    if (attribute == Attribute.underline) return 2; // __
    if (attribute == Attribute.strikeThrough) return 2; // ~~
    if (attribute == Attribute.italic) return 1; // *
    return 0;
  }

  void updateAiEnabled(bool value) {
    if (_canUseAiToday) {
      _aiEnabled = value;
      notifyListeners();
    }
  }

  void updateMoodType(MoodType value) {
    if (_selectedMood != value) {
      _selectedMood = value;
      notifyListeners();
    }
  }

  void updateContent(String? value) {
    if (_content != value) {
      _content = value;
      notifyListeners();
    }
  }

  void deleteImage(String imageUri) {
    _selectedImageList = _selectedImageList
        .where((uri) => uri != imageUri)
        .toList();
    notifyListeners();
  }

  void resetForm() {
    _content = null;
    _quillController.clear();
    _selectedMood = MoodType.neutral;
    _selectedImageList = [];
    _isSubmitted = false;
    _submittedJournalId = null;
    _aiEnabled = true;
    _locationInfo = null;
    _isLoadingLocation = false;
    _weatherInfo = null;
    _isLoadingWeather = false;
    _selectedTags.clear();
    _checkAiUsageLimit();
    clearState();
    notifyListeners();
  }

  Future<void> pickImage() async {
    setLoading();
    final result = await _pickImageUseCase.fromGallery();
    switch (result) {
      case Ok<String?>():
        _log.fine('Image picked successfully');
        _selectedImageList = [..._selectedImageList, result.value!];
        setSuccess();
      case Error<String?>():
        _log.warning('Failed to pick image: ${result.error}');
        setError(result.error);
    }
  }

  void clearWeather() {
    _weatherInfo = null;
    notifyListeners();
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    double latitude = 37.5665; // 서울 기본 위치
    double longitude = 126.9780;

    // 위치 정보가 있으면 사용, 없으면 서울 기본 위치 사용
    if (_locationInfo != null) {
      latitude = _locationInfo!.latitude;
      longitude = _locationInfo!.longitude;
      _log.info('Using actual location: $latitude, $longitude');
    } else {
      _log.info('Using default location (Seoul): $latitude, $longitude');
    }

    _isLoadingWeather = true;
    notifyListeners();

    final result = await _weatherUseCase.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );

    switch (result) {
      case Ok<WeatherInfo>():
        _log.fine('Weather retrieved successfully');
        _weatherInfo = result.value;
      case Error<WeatherInfo>():
        _log.warning('Failed to get weather: ${result.error}');
        setError(result.error);
    }

    _isLoadingWeather = false;
    notifyListeners();
  }

  void removeTag(Tag tag) {
    _selectedTags.remove(tag);
    notifyListeners();
  }

  Future<void> addNewTag(String tagName) async {
    final trimmedName = tagName.trim();
    if (trimmedName.isEmpty) return;

    final existingTag = _availableTags.firstWhere(
      (tag) => tag.name.toLowerCase() == trimmedName.toLowerCase(),
      orElse: () => Tag(id: -1, name: '', createdAt: DateTime.now()),
    );

    if (existingTag.id != -1) {
      addExistingTag(existingTag);
      return;
    }

    final result = await _tagUseCase.addTag(trimmedName, null);
    switch (result) {
      case Ok<Tag>():
        _availableTags.add(result.value);
        addExistingTag(result.value);
      case Error<Tag>():
        _log.warning('Failed to add tag: ${result.error}');
        setError(result.error);
    }
  }

  void addExistingTag(Tag tag) {
    if (!_selectedTags.contains(tag)) {
      _selectedTags.add(tag);
      notifyListeners();
    }
  }

  void clearLocation() {
    _locationInfo = null;
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully');
        _locationInfo = result.value;
      case Error<LocationInfo>():
        _log.warning('Failed to get location: ${result.error}');
        setError(result.error);
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<Result<void>> submitJournal() async {
    if (!isFormValid) {
      _log.warning('Content is required');
      return Result.error(Exception('Content is required'));
    }

    setLoading();
    _isSubmitted = false;
    _submittedJournalId = null;

    if (_isEditMode) {
      return _updateExistingJournal();
    } else {
      return _createNewJournal();
    }
  }

  Future<Result<void>> _createNewJournal() async {
    final newJournal = CreateJournalRequest(
      content: _content,
      moodType: _selectedMood,
      imageUri: _selectedImageList,
      aiResponseEnabled: _aiEnabled,
      createdAt: _selectedDate,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      temperature: _weatherInfo?.temperature,
      weatherIcon: _weatherInfo?.icon,
      weatherDescription: _weatherInfo?.description,
      tagNames: _selectedTags.map((tag) => tag.name).toList(),
    );
    final result = await _journalUseCase.addJournal(newJournal);

    switch (result) {
      case Ok<Map<String, dynamic>>():
        _log.fine('Journal added successfully');
        _isSubmitted = true;
        _submittedJournalId = result.value['id'];
        final aiResponseEnabled = result.value['aiResponseEnabled'];

        if (_selectedTags.isNotEmpty) {
          await _tagUseCase.updateJournalTags(
            result.value['id'],
            _selectedTags.map((tag) => tag.id).toList(),
          );
        }

        _logMoodEntryUseCase(
          moodType: _selectedMood.name,
          entryType: 'manual',
          hasImage: _selectedImageList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );

        if (aiResponseEnabled == true) {
          _generateAiResponse();
        }
        setSuccess();
        return Result.ok(null);
      case Error<Map<String, dynamic>>():
        _log.warning('Failed to add journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _updateExistingJournal() async {
    final updateJournal = UpdateJournalRequest(
      id: _editJournalId!,
      aiResponseEnabled: _aiEnabled,
      content: _content,
      imageUri: _selectedImageList,
      latitude: _locationInfo?.latitude,
      longitude: _locationInfo?.longitude,
      address: _locationInfo?.address,
      moodType: _selectedMood,
      tagNames: _selectedTags.map((tag) => tag.name).toList(),
    );

    final result = await _journalUseCase.updateJournal(updateJournal);

    switch (result) {
      case Ok<int>():
        _log.fine('Journal updated successfully');
        _isSubmitted = true;
        _submittedJournalId = _editJournalId;

        // 태그 업데이트
        await _tagUseCase.updateJournalTags(
          _editJournalId,
          _selectedTags.map((tag) => tag.id).toList(),
        );

        // 태그 업데이트 후 journal stream에 변경사항 알림
        await _journalUseCase.notifyJournalUpdate();

        _logMoodEntryUseCase.call(
          moodType: _selectedMood.name,
          entryType: 'edit',
          hasImage: _selectedImageList.isNotEmpty,
          hasTag: _selectedTags.isNotEmpty,
        );

        setSuccess();
        return Result.ok(null);
      case Error<int>():
        _log.warning('Failed to update journal: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<void> _checkAiUsageLimit() async {
    final result = await _checkAiUsageLimitUseCase();

    switch (result) {
      case Ok<bool>():
        _canUseAiToday = result.value;
        _log.info('AI usage check result: canUseAiToday = $_canUseAiToday');

        if (!_canUseAiToday) {
          _aiEnabled = false;
        }

        notifyListeners();
      case Error<bool>():
        _log.warning('Failed to check AI usage limit: ${result.error}');
        _canUseAiToday = false;
        _aiEnabled = false;
        notifyListeners();
    }
  }

  void _generateAiResponse() async {
    _aiGenerationProvider.setGeneratingAiResponse();

    // Record AI usage
    await _settingsUseCase.updateLastAiUsageDate(DateTime.now());
    _canUseAiToday = false;
    notifyListeners();

    final aiPersonality = _appStateProvider.appState.aiPersonality;
    await _geminiUseCase.initialize(aiPersonality);
    final aiResponse = await _geminiUseCase.generateResponse(
      prompt: content!,
      moodType: selectedMood,
    );

    switch (aiResponse) {
      case Ok<String>():
        _log.fine('AI response generated successfully');
        final dto = UpdateJournalAiResponseRequest(
          id: _submittedJournalId!,
          aiResponseEnabled: true,
          aiResponse: aiResponse.value,
        );
        await _journalUseCase.updateJournalAiResponse(dto);
        _aiGenerationProvider.setSuccessGeneratingAiResponse();
      case Error<String>():
        _log.warning('Failed to add AI response: ${aiResponse.error}');
        _aiGenerationProvider.setErrorGeneratingAiResponse(aiResponse.error);
    }
  }

  Future<void> _loadCurrentLocationOnInit() async {
    _isLoadingLocation = true;
    notifyListeners();

    final result = await _getCurrentLocationUseCase();

    switch (result) {
      case Ok<LocationInfo>():
        _log.fine('Location retrieved successfully on init');
        _locationInfo = result.value;
        // 위치 정보가 로드되면 자동으로 날씨 정보도 로드
        await getCurrentWeather();
      case Error<LocationInfo>():
        _log.info('Failed to get location on init: ${result.error}');
    }

    _isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> _loadCurrentWeatherOnInit() async {
    // 위치 정보 로드를 잠시 기다렸다가 날씨 정보 로드 (기본 위치 사용)
    await Future.delayed(Duration(milliseconds: 500));
    await getCurrentWeather();
  }

  Future<void> _loadAllTags() async {
    final result = await _tagUseCase.getAllTags();
    switch (result) {
      case Ok<List<Tag>>():
        _availableTags = result.value;
        notifyListeners();
      case Error<List<Tag>>():
        _log.warning('Failed to load tags: ${result.error}');
    }
  }

  Future<void> _loadJournalForEdit(int journalId) async {
    try {
      _log.info('Loading journal for edit: $journalId');
      final result = await _journalUseCase.getJournalById(journalId);
      switch (result) {
        case Ok<Journal>():
          final journal = result.value;
          _log.info('Journal loaded successfully: ${journal.content}');
          _content = journal.content;
          if (journal.content != null) {
            // 저장된 마크다운 텍스트를 QuillDocument로 변환
            final document = _parseMarkdownToDocument(journal.content!);
            _quillController.document = document;
          }
          _selectedMood = journal.moodType;
          _selectedImageList = journal.imageUri ?? [];
          _aiEnabled = journal.aiResponseEnabled;
          _selectedDate = journal.createdAt;
          _selectedTags = journal.tags ?? [];

          if (journal.latitude != null && journal.longitude != null) {
            _locationInfo = LocationInfo(
              latitude: journal.latitude!,
              longitude: journal.longitude!,
              address: journal.address,
            );
          }

          if (journal.temperature != null) {
            _weatherInfo = WeatherInfo(
              temperature: journal.temperature!,
              icon: journal.weatherIcon ?? '',
              description: journal.weatherDescription ?? '',
              humidity: 0.0,
              pressure: 0.0,
              windSpeed: 0.0,
              location: journal.address ?? '',
              timestamp: journal.createdAt,
            );
          }

          notifyListeners();
        case Error<Journal>():
          _log.warning('Failed to load journal for edit: ${result.error}');
      }
    } catch (e) {
      _log.warning('Error loading journal for edit: $e');
    }
  }

  @override
  void dispose() {
    _quillController.removeListener(_onQuillTextChanged);
    _quillController.dispose();
    _selectedImageList.clear();
    super.dispose();
  }
}
