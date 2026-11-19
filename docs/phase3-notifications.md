# Phase 3 — Notifications and alarms

## Implemented

* `lib/core/notifications/reminder_service.dart` initializes local notifications,
  timezone data, and the `alarm` plugin.
* `scheduleTaskReminder` uses a default lead time of 15 minutes, accepts a
  per-task override, skips past-due tasks, and cancels the previous schedule
  before replacing it.
* `cancelTaskReminder` cancels both notification and alarm IDs for a task.
* Android alarm mode uses looping audio and vibration. The alarm package owns
  its native alarm and reboot behavior; scheduled notification reboot receivers
  are declared in the Android manifest.
* iOS uses a local notification. iOS suspends apps in the background and does
  not allow a third-party app to run a continuous alarm sound after termination.
  Phase 5 should add follow-up notifications and an in-app alarm view when the
  user opens the app.

## Permission behavior

`ReminderService.initialize()` does not show permission prompts. Request access
at onboarding or when the user enables reminders by calling
`ReminderService().requestPermissions()`. If the user denies access, explain how
to enable notifications in system settings. Exact-alarm special access may also
need to be enabled in Android Settings, depending on OS version and device.

Android manifest includes notification, exact-alarm, full-screen-intent, and
boot permissions plus the local-notification scheduling/boot receivers. The
`alarm` plugin contributes its own required components through manifest merge.
Do not add iOS background audio modes: they cannot make a third-party alarm
reliable after app termination and would request an unrelated capability.

## Next wiring

When creating/editing a task, call `scheduleTaskReminder` with a stable positive
integer task ID, due date, lead time, and `withAlarm` choice. Call
`cancelTaskReminder` before deleting the task. The full-screen alarm route and
notification action handling are added with the Phase 5 screens.

## Commands

From the project root:

```powershell
flutter pub get
flutter analyze
flutter run
```

Test on a physical Android device: allow notifications, schedule a reminder a
few minutes ahead, background the app, and confirm delivery. Separately test
alarm mode and reboot rescheduling. iOS testing requires macOS/Xcode; verify the
notification is delivered with the app suspended and confirm that no continuous
alarm is promised while terminated.
