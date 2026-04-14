# Obsidian Headless

Headless client for [Obsidian Sync](https://obsidian.md/sync) and [Obsidian Publish](https://obsidian.md/publish).
Sync and publish your vaults from the command line without the desktop app.

Fork-specific changes in this repository are attributed to `B.Newbold`.

Requires Node.js 22 or later.

## Install

```bash
npm install -g obsidian-headless
```

Install from a local checkout:

```bash
cd /path/to/obsidian-headless/repo
npm install
npm pack --pack-destination /tmp
npm install -g /tmp/obsidian-headless-0.0.9-bnewbold.1.tgz
```

After installing, verify the CLI and available sync options:

```bash
ob sync --help
```

## Development

Local development workflow for this fork:

```bash
cd /path/to/obsidian-headless/repo
npm install
node cli.js sync --help
```

To package and install your local changes globally:

```bash
npm pack --pack-destination /tmp
npm install -g /tmp/obsidian-headless-0.0.9-bnewbold.1.tgz
```

To verify the installed CLI:

```bash
ob sync --help
```

This fork's local changes and packaging updates are attributed to `B.Newbold`.

## Authentication

Login interactively:

```bash
ob login
```

If already logged in, `ob login` displays your account info. To switch accounts, pass `--email` and/or `--password` to log in again.

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

# Sync only a single folder
ob sync --only-folder Claw
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
ob sync [--path <local-path>] [--continuous] [--only-folder <folder>]
```

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--continuous` | Run continuously, watching for changes |
| `--only-folder` | Only sync a single vault-relative folder and ignore everything else in the vault |

### `ob sync-config`

View or change sync settings for a vault.

```
ob sync-config [--path <local-path>] [options]
```

Run with no options to display the current configuration.

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--mode` | Sync mode: `bidirectional` (default), `pull-only` (only download, ignore local changes), or `mirror-remote` (only download, revert local changes) |
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

### `ob publish-list-sites`

List all publish sites available to your account, including shared sites.

### `ob publish-create-site`

Create a new publish site.

```
ob publish-create-site --slug <slug>
```

| Option | Description |
|---|---|
| `--slug` | Site slug used in the publish URL (required) |

### `ob publish-setup`

Connect a local vault to a publish site.

```
ob publish-setup --site <id-or-slug> [--path <local-path>]
```

| Option | Description |
|---|---|
| `--site` | Site ID or slug (required) |
| `--path` | Local vault path (default: current directory) |

### `ob publish`

Publish vault changes to a connected site. Scans for changes by comparing local file hashes against the remote site, then uploads new/changed files and removes deleted ones.

Files are selected for publishing based on: frontmatter `publish: true/false` flag (highest priority), excluded/included folders (configured via `publish-config`), and the `--all` flag for untagged files.

```
ob publish [--path <local-path>] [--dry-run] [--yes] [--all]
```

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--dry-run` | Show changes without publishing |
| `--yes` | Publish without prompting for confirmation |
| `--all` | Include files without a publish flag |

### `ob publish-config`

View or change publish settings for a vault.

```
ob publish-config [--path <local-path>] [--includes <folders>] [--excludes <folders>]
```

Run with no options to display the current configuration.

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--includes` | Folders to include, comma-separated (empty string to clear) |
| `--excludes` | Folders to exclude, comma-separated (empty string to clear) |

### `ob publish-site-options`

View or update remote site options (appearance, navigation, etc.). Run with no options to display the current settings.

```
ob publish-site-options [--path <local-path>] [options]
```

| Option | Description |
|---|---|
| `--path` | Local vault path (default: current directory) |
| `--site-name <name>` | Site name |
| `--index-file <path>` | Home page file path |
| `--logo <path>` | Logo file path (empty string to clear) |
| `--default-theme <theme>` | Default theme: `light` or `dark` |
| `--show-navigation <bool>` | Show navigation sidebar |
| `--show-graph <bool>` | Show graph view |
| `--show-outline <bool>` | Show table of contents |
| `--show-search <bool>` | Show search |
| `--show-backlinks <bool>` | Show backlinks |
| `--show-hover-preview <bool>` | Show hover preview |
| `--show-theme-toggle <bool>` | Show theme toggle |
| `--readable-line-length <bool>` | Readable line length |
| `--strict-line-breaks <bool>` | Strict line breaks |
| `--hide-title <bool>` | Hide inline title |
| `--sliding-window <bool>` | Sliding window mode |
| `--nav-order <paths>` | Navigation ordering, comma-separated paths in display order (empty string to clear) |
| `--nav-hidden <items>` | Navigation hidden items, comma-separated paths (empty string to clear) |

### `ob publish-unlink`

Disconnect a vault from a publish site.

```
ob publish-unlink [--path <local-path>]
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
