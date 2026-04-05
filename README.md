# Stassh Website

Marketing site for Stassh, a local-first SSH TUI.

![Website overview](/image.png)

## What It Includes

- Hero section with install options
- Feature and security highlights
- Screenshot gallery
- Sitemap generation via Astro

## Install Flow

- `curl -fsSL https://getstassh.dev/install.sh | sh`
- `cargo install --git https://github.com/getstassh/stassh stassh --locked`

The hosted `install.sh` proxies to the current GitHub raw installer.

## Development

```bash
bun install
bun run dev
```

## Build

```bash
bun run build
```

## Stack

- Astro
- `@astrojs/sitemap`
- TypeScript
