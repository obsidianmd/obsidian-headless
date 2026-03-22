# Changelog

## 0.0.9

- Fixed NaN passed to setTimeout causing a warning to show in the console.
- Improved sync-setup error messaging for when encryption key validation failed.

## 0.0.8

- Add publish support.

## 0.0.7

- Fixed lock failure on file systems returning floating point modified times.
- Fixed some initialization errors were previously caught and completely ignored, leading to no output on failure.

## 0.0.6

- Fixed default value of file type configuration not properly applied, causing images to not sync.

## 0.0.5

- Added new sync modes "pull-only" (only download, ignore local changes) and "mirror-remote" (only download, revert local changes).
- Print the vault config when starting a sync session.

## 0.0.4

- Fixed version command always gave "1.0.0".
- Fixed config syncing deletes remote config files after downloading them.

## 0.0.3

- Removed keytar in favor of flat file configuration, as it is not available in many headless setups.
- Fix download freeze caused by a race condition in the data receiving pipeline, due to microtask queuing differences between node and web (credits to @marcus-crane).

## 0.0.2

- Updated README.md

## 0.0.1

- Initial release.
