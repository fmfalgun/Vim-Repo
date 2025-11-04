# 🌐 Web Development Guide (HTML/CSS/JavaScript)

Complete guide for web development.

---

## Setup

### Language Servers
- **html** - HTML
- **cssls** - CSS/SCSS
- **tsserver** - JavaScript

All installed automatically via Mason.

---

## Features

### HTML
- Tag completion
- Emmet abbreviations
- Attribute suggestions
- Link validation

### CSS
- Property completion
- Color previews
- Vendor prefix suggestions
- SCSS/SASS support

---

## Emmet

Type abbreviations and expand:
```html
<!-- Type: div.container>ul>li*3 -->
<!-- Press Tab to expand: -->
<div class="container">
    <ul>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
```

---

## Live Server

Install extension:
```bash
npm install -g live-server
```

Use:
```vim
:TermExec cmd="live-server"
```

Opens browser with auto-reload!

---

## Example Workflow

**index.html**:
```html
<!DOCTYPE html>
<html>
<head>
    <title>My Page</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Hello World</h1>
    <script src="script.js"></script>
</body>
</html>
```

**style.css**:
```css
body {
    font-family: Arial, sans-serif;
    background: #f0f0f0;
}

h1 {
    color: #333;
}
```

**script.js**:
```javascript
document.addEventListener('DOMContentLoaded', () => {
    console.log('Page loaded');
});
```

---

## Resources

- [MDN Web Docs](https://developer.mozilla.org/)
- [Emmet Documentation](https://docs.emmet.io/)
