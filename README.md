# Digital Garden & Logbook

A minimalist, text-focused digital garden built with Jekyll and typeset for readability on the small web. 

## Licensing
* **Code & Infrastructure:** [GPLv3](LICENSE)
* **Written Content:** [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Project Structure
```text
rudraasthana.github.io/
├── _layouts/
│   └── default.html         # Master template with theme toggle & footer
├── _posts/
│   ├── blog/
│   │   └── YYYY-MM-DD-title.md
│   └── guide/
│       └── YYYY-MM-DD-title.md
├── _config.yml              # Jekyll settings & timezone enforcement
├── favicon.svg              # 16x16 Pixel Art
├── index.html               # Homepage with dynamic category routing
├── LICENSE                  # GPLv3 text
├── README.md                # This file
└── styles.css               # Catppuccin theme & typography limits
```

## Publishing Workflow

### 1. Create a Post
Create a new Markdown file inside either `_posts/blog/` or `_posts/guide/`. The filename **must** follow the `YYYY-MM-DD-title.md` format.

At the very top of the file, insert the YAML front matter:
```yaml
---
layout: default
title: "Your Post Title Here"
category: blog   # or "guide"
---
```

### 2. Adding Footnotes & Citations
Use Kramdown's native footnote syntax. Add `[^1]` inline where you want the number to appear. 
Then, at the very bottom of your markdown file, define the footnote content:

```markdown
Here is a factual claim.[^1]

[^1]: This is the citation or expanded thought.
```
The site will automatically generate a styled horizontal separator and two-way clickable links before the licensing footer.

### 3. Deploy to GitHub Pages
```bash
npx prettier --write "**/*.{html,css,md,yml}"
git add .
git commit -m "Publish: [Post Title]"
git push
```
