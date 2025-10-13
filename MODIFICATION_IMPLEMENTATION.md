# Modification Implementation Plan: Refactor Premium Features to Free

This document outlines the step-by-step plan to refactor the App Lock, Cloud Backup, and Cloud Restore features from premium to free, based on the approved design document.

## Journal

*This section will be updated after each phase to log actions, learnings, and any deviations from the plan.*

---

## Phase 1: Preparation and Initial Refactoring

### Tasks

- [ ] Run all existing tests to ensure the project is in a good state before starting modifications.
- [ ] Create a new file `lib/presentation/widgets/common/pro_feature_dialog.dart`.
- [ ] Move the `_showProFeatureDialog` function from `lib/presentation/screens/settings/settings_content.dart` into the new file. Refactor it into a reusable `showProFeatureDialog(BuildContext context)` function and a `ProFeatureDialog` widget.
- [ ] Update `lib/presentation/screens/statistics/statistics_content.dart` to import and use the new `showProFeatureDialog` function, ensuring it still works as expected.
- [ ] Create/modify unit tests for the new `ProFeatureDialog` widget, if relevant.
- [ ] Run the `dart_fix` tool to clean up the code.
- [ ] Run the `analyze_files` tool and fix any issues.
- [ ] Run all tests to make sure they all pass.
- [ ] Run `dart_format` to ensure correct formatting.
- [ ] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to check for any changes.
- [ ] Update the `MODIFICATION_IMPLEMENTATION.md` file's Journal section with the current state. Check off completed tasks.
- [ ] Use `git diff` to verify the changes and create a suitable commit message. Present the commit message to the user for approval.
- [ ] Wait for user approval before committing.
- [ ] After committing, if an app is running, use the `hot_reload` tool to reload it.

---

## Phase 2: Refactor Settings Screen and Finalize

### Tasks

- [ ] In `lib/presentation/screens/settings/settings_content.dart`, remove all Pro-gating logic (e.g., `Consumer`, `GestureDetector`, `AbsorbPointer`, premium icons) from the "App Lock", "Data Backup", and "Data Restore" tiles.
- [ ] Simplify the `onChanged` and `onTap` handlers for these tiles to directly execute their respective functions, removing any `isProUser` checks. Use `context.read` and `context.select` for better performance.
- [ ] Remove the now-unused `_showProFeatureDialog` function from `lib/presentation/screens/settings/settings_content.dart`.
- [ ] In `lib/presentation/screens/statistics/statistics_view_model.dart`, remove the `isProUser` getter as it's no longer needed for gating these features.
- [ ] Create/modify unit tests for the changes made in this phase, if relevant.
- [ ] Run the `dart_fix` tool to clean up the code.
- [ ] Run the `analyze_files` tool and fix any issues.
- [ ] Run all tests to make sure they all pass.
- [ ] Run `dart_format` to ensure correct formatting.
- [ ] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to check for any changes.
- [ ] Update the `MODIFICATION_IMPLEMENTATION.md` file's Journal section with the current state. Check off completed tasks.
- [ ] Use `git diff` to verify the changes and create a suitable commit message. Present the commit message to the user for approval.
- [ ] Wait for user approval before committing.
- [ ] After committing, if an app is running, use the `hot_reload` tool to reload it.

---

## Phase 3: Final Review and Cleanup

### Tasks

- [ ] Update the `README.md` file if any information has changed regarding app features.
- [ ] Update the `GEMINI.md` file to ensure it still correctly describes the app's features and implementation details.
- [ ] Ask the user to inspect the package (and running app, if any) and confirm if they are satisfied with the modifications.
