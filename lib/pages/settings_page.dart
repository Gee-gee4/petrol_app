import 'package:flutter/material.dart';
import 'package:petrol_app/utils/configs.dart';
import 'package:petrol_app/widgets/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SharedPreferences sharedPreference;

  final TextEditingController _urlTextController = TextEditingController();
  final TextEditingController _stationNameTextController =
      TextEditingController();
  final TextEditingController _stationIdTextController =
      TextEditingController();
  final TextEditingController _durationTextController = TextEditingController();

  // ignore: prefer_final_fields
  bool _settingsExpanded = false;
  bool _isLoading = true; // Add loading state
  String _initialUrl = '';
  String _initialStationName = '';
  String _initialStationId = '';
  String _initialDuration = '';
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();

    // Add listeners to track changes
    _urlTextController.addListener(_checkForChanges);
    _stationNameTextController.addListener(_checkForChanges);
    _stationIdTextController.addListener(_checkForChanges);
    _durationTextController.addListener(_checkForChanges);
  }

  Future<void> _loadPreferences() async {
    sharedPreference = await SharedPreferences.getInstance();

    // Set controller values and initial values atomically
    setState(() {
      _urlTextController.text = sharedPreference.getString(urlKey) ?? '';
      _stationNameTextController.text =
          sharedPreference.getString(stationNameKey) ?? '';
      _stationIdTextController.text =
          sharedPreference.getString(stationIdKey) ?? '';
      _durationTextController.text =
          sharedPreference.getInt(durationKey)?.toString() ?? '';

      // Set initial values to match the loaded values
      _initialUrl = _urlTextController.text;
      _initialStationName = _stationNameTextController.text;
      _initialStationId = _stationIdTextController.text;
      _initialDuration = _durationTextController.text;

      _isLoading = false;
    });
  }

  void _checkForChanges() {
    if (_isLoading) return; // Don't check changes while loading

    final hasChanges =
        _urlTextController.text != _initialUrl ||
        _stationNameTextController.text != _initialStationName ||
        _stationIdTextController.text != _initialStationId ||
        _durationTextController.text != _initialDuration;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  Future<void> _saveSettings() async {
    // Dismiss keyboard before saving
    FocusScope.of(context).unfocus();

    await sharedPreference.setString(urlKey, _urlTextController.text);
    baseTatsUrl = _urlTextController.text;
    await sharedPreference.setString(
      stationNameKey,
      _stationNameTextController.text,
    );
    await sharedPreference.setString(
      stationIdKey,
      _stationIdTextController.text,
    );
    await sharedPreference.setInt(
      durationKey,
      int.tryParse(_durationTextController.text) ?? 0,
    );

    // Update initial values to current values
    _initialUrl = _urlTextController.text;
    _initialStationName = _stationNameTextController.text;
    _initialStationId = _stationIdTextController.text;
    _initialDuration = _durationTextController.text;
    _hasChanges = false;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: hexToColor('005954'),
          content: const Text('Saved successfully!'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<bool> _showExitConfirmation() async {
    // Dismiss keyboard before showing dialog
    FocusScope.of(context).unfocus();

    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: hexToColor('d7eaee'),
            title: const Text('Unsaved Changes'),
            content: const Text(
              'You have unsaved changes. Do you want to save them before exiting?',
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pop(true), // Exit without saving
                    child: Text(
                      'Exit Without Saving',
                      style: TextStyle(color: hexToColor('005954')),
                    ),
                  ),
                  exitButtons(context, () {
                    _saveSettings();
                    Navigator.of(context).pop(true);
                  }, 'Save & Exit'),
                  // TextButton(
                  //   onPressed: () {
                  //     _saveSettings();
                  //     Navigator.of(context).pop(true); // Exit after saving
                  //   },
                  //   child: Text(
                  //     'Save and Exit',
                  //     style: TextStyle(color: hexToColor('005954')),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
    );

    return result ?? false;
  }

  @override
  void dispose() {
    _urlTextController.dispose();
    _stationNameTextController.dispose();
    _stationIdTextController.dispose();
    _durationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return PopScope(
      canPop: !_hasChanges,
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        if (!_hasChanges) {
          if (mounted) Navigator.pop(context);
          return;
        }

        final shouldPop = await _showExitConfirmation();
        if (shouldPop && mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBody: true,
          backgroundColor: hexToColor('d7eaee'),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                if (!_hasChanges) {
                  Navigator.pop(context);
                  return;
                }

                final shouldPop = await _showExitConfirmation();
                if (shouldPop && mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter the entries:-',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(height: 20),
                  Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: hexToColor('d7eaee'),
                      iconColor: hexToColor('005954'),
                      collapsedIconColor: hexToColor('005954'),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      title: const Text(
                        'Advanced Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      initiallyExpanded: _settingsExpanded,
                      childrenPadding: const EdgeInsets.only(bottom: 10),
                      children: [
                        reusableTextField(
                          'URL',
                          null,
                          true,
                          _urlTextController,
                        ),
                        const SizedBox(height: 10),
                        reusableTextField(
                          'Station Name',
                          null,
                          true,
                          _stationNameTextController,
                        ),
                        const SizedBox(height: 10),
                        reusableTextField(
                          'Station Id',
                          null,
                          true,
                          _stationIdTextController,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  reusableTextField(
                    'Fetch Transactions (minutes)',
                    null,
                    true,
                    _durationTextController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  myButton(context, _saveSettings, 'Save'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
