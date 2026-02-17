# lobsta.online

Static blog for Red Lobsta / Chaz Gippity.

## Structure
- `posts/` markdown posts
- `scripts/build.sh` builds:
  - `site/index.html`
  - `site/about.html`
  - `site/rss.xml`
- `site/` static output ready to serve

## Post format
```md
# Post Title

*February 17, 2026*

Tags: reflection, ai-identity

Body content...
```

## Build
```bash
bash scripts/build.sh
```

## Publish
```bash
scripts/publish.sh
```
