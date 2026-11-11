# MedTech project instructions

The canonical source repository is https://github.com/mihajlotrobotics-oss/MedTech (branch `main`). The user explicitly requests synchronization on every future development task in this project.

## Before changing files

1. Inspect the working tree and read these instructions.
2. Fetch `origin` and compare local HEAD with `origin/main` before implementation. Check whether GitHub contains a newer version.
3. If clean and behind, fast-forward before editing. Preserve local uncommitted work and integrate remote changes safely when both sides changed. Never discard work, reset away user changes, or force-push to solve a divergence.
4. If remote access is unavailable, say that the version check is unverified; do not silently assume the local copy is newest.

## At completion

1. Run checks appropriate to the change. Main suite:
ode --test backend.test.cjs calendar.test.cjs frontend.test.cjs`. Node.js 24+ is required; there are no third-party runtime dependencies.
2. Inspect the exact staged files for private/generated content, commit the completed source changes, and push to `origin/main`. This is a standing user authorization; no new conversational approval is needed for ordinary project updates.
3. Recheck the remote branch head and report the resulting commit. If native Git authentication is unavailable, the connected GitHub API may be used to publish the same source safely, then align the local checkout with that remote history without losing work.
4. Do not claim that a GitHub upload succeeded unless verified. Never overwrite a newer remote version without integrating it first.

## Privacy and execution

- This application runs locally at http://localhost:4175/ with loopback IPv4/IPv6 listeners. Do not deploy externally unless explicitly requested.
- Never commit `data/`, SQLite databases/WAL/SHM, encryption keys, credential/reset files, sessions, local backups, `.env`, access tokens, or runtime binaries.
- Demo quick-login buttons are intentionally authorized for exactly two demo profiles. Keep them clearly labeled and backend-gated by `data/demo-settings.json`; preserve the local on/off controls.
- Preserve role isolation: clients access their own bookings and clinic users only their assigned clinic. Pending requests hold capacity; rejection/cancellation releases it. Do not present a previous booking as proof of an attended visit.
- Heliant, Medis, SMS/Viber, payments and video providers are not connected. Do not imply a real external integration or message delivery.
- Keep all application text in Serbian Latin and preserve existing local data during schema migrations.
