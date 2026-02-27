# Obsidian CLI

Headless client for [Obsidian](https://obsidian.md) services.
Sync your vaults from the command line without the desktop app.

Requires Node.js 22 or later.

## Install

```bash
npm install -g obsidian-headless
```

## Authentication

Login interactively:

```bash
ob login
```

If already logged in, `ob login` displays your account info. To switch accounts, pass `--email` and/or `--password` to log in again.

### Environment variable

For non-interactive use (CI, scripts, servers), set the `OBSIDIAN_AUTH_TOKEN` environment variable instead of using `ob login`:

```bash
export OBSIDIAN_AUTH_TOKEN="your-auth-token"
```

When set, all commands that require authentication will use this token automatically.

## Quick start

```bash
# Login
ob login

# List your remote vaults
ob sync-list-remote

# Setup a vault for syncing
cd ~/vaults/my-vault
ob sync-setup --vault "My Vault"

# Run a one-time sync
ob sync

# Run continuous sync (watches for changes)
ob sync --continuous
```

## Commands

### `ob login`

Login to your Obsidian account, or display login status if already logged in.

```
ob login [--email <email>] [--password <password>] [--mfa <code>]
```

All options are interactive when omitted — email and password are prompted, and 2FA is requested automatically if enabled on the account.

### `ob logout`

Logout and clear stored credentials.

### `ob sync-list-remote`

List all remote vaults available to your account, including shared vaults.

### `ob sync-list-local`

List locally configured vaults and their paths.

### `ob sync-create-remote`

Create a new remote vault.

```
ob sync-create-remote --name "Vault Name" [--encryption <standard|e2ee>] [--password <password>] [--region <region>]
```

| Option | Description                                              |
|---|----------------------------------------------------------|
| `--name` | Vault name (required)                                    |
| `--encryption` | `standard` for managed encryption, `e2ee` for end-to-end |
| `--password` | End-to-end encryption password (prompted if omitted)     |
| `--region` | Server region (automatic if omitted)                     |

### `ob sync-setup`

Set up sync between a local vault and a remote vault.

```
ob sync-setup --vault <id-or-name> [--path <local-path>] [--password <password>] [--device-name <name>] [--config-dir <name>]
```

| Option | Description                                                     |
|---|-----------------------------------------------------------------|
| `--vault` | Remote vault ID or name (required)                              |
| `--path` | Local directory (default: current directory)                    |
| `--password` | E2E encryption password (prompted if omitted)                   |
| `--device-name` | Device name to identify this client in the sync version history |
| `--config-dir` | Config directory name (default: `.obsidian`)                    |

### `ob sync`

Run sync for a configured vault.

```
ob sync [--path <local-path>] [--continuous]
```

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--continuous` | Run continuously, watching for changes |

### `ob sync-config`

View or change sync settings for a vault.

```
ob sync-config [--path <local-path>] [options]
```

Run with no options to display the current configuration.

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--conflict-strategy` | `merge` or `conflict` |
| `--file-types` | Attachment types to sync: `image`, `audio`, `video`, `pdf`, `unsupported` (comma-separated, empty to clear) |
| `--configs` | Config categories to sync: `app`, `appearance`, `appearance-data`, `hotkey`, `core-plugin`, `core-plugin-data`, `community-plugin`, `community-plugin-data` (comma-separated, empty to disable config syncing) |
| `--excluded-folders` | Folders to exclude (comma-separated, empty to clear) |
| `--device-name` | Device name to identify this client in the sync version history |
| `--config-dir` | Config directory name (default: `.obsidian`) |

### `ob sync-status`

Show sync status and configuration for a vault.

```
ob sync-status [--path <local-path>]
```

### `ob sync-unlink`

Disconnect a vault from sync and remove stored credentials.

```
ob sync-unlink [--path <local-path>]
```

## Native modules

### btime

The `btime` directory contains a prebuilt native N-API addon for setting file creation time (birthtime) on Windows and macOS.
This is used when downloading files from the server to preserve their original creation timestamps.

Since it targets N-API version 3, the compiled `.node` binaries are ABI-stable and work across Node.js versions without recompilation.

On Linux, birthtime is not supported — the addon is not included and sync operates normally without it.

Prebuilt binaries are included for:
- `win32-x64`
- `win32-arm64`
- `win32-ia32`
- `darwin-x64`
- `darwin-arm64`
