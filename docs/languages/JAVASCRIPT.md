# ⚡ JavaScript/TypeScript/Node.js Development Guide

Complete guide for JavaScript, TypeScript, and Node.js development.

---

## Setup

### Language Server
**tsserver** (automatically installed via Mason)
- Supports JavaScript and TypeScript
- React (JSX/TSX) support included

### Debugger
**node-debug2** via Mason

### Node.js Installation
```bash
# Debian/Ubuntu
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Arch
sudo pacman -S nodejs npm
```

---

## Features

### Auto-completion
- ES6+ syntax
- Import suggestions
- Node.js built-ins
- npm package types

### TypeScript Support
- Full type checking
- Interface completion
- Type inference
- Refactoring tools

### React/Vue Support
- JSX/TSX syntax
- Component props completion
- Hook suggestions

---

## Project Setup

### Initialize Project
```bash
mkdir my-project
cd my-project
npm init -y
nvim package.json
```

### TypeScript Project
```bash
npm install --save-dev typescript @types/node
npx tsc --init
nvim tsconfig.json
```

---

## Debugging

### Node.js Application

**app.js**:
```javascript
function calculateTotal(items) {
    let total = 0;
    for (const item of items) {
        total += item.price;  // Breakpoint here
    }
    return total;
}

const items = [
    { name: 'Book', price: 10 },
    { name: 'Pen', price: 2 }
];

console.log(calculateTotal(items));
```

Debug steps:
1. Open: `nvim app.js`
2. Set breakpoint: `F9` on line 4
3. Press `F5`
4. Select: "Launch"
5. Debug UI opens
6. Inspect variables

### Express.js Application

**server.js**:
```javascript
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    const message = 'Hello World';  // Breakpoint
    res.send(message);
});

app.listen(3000, () => {
    console.log('Server on port 3000');
});
```

Debug:
1. Set breakpoint in route handler
2. `F5` → "Launch"
3. In another terminal: `curl localhost:3000`
4. Breakpoint hits!

### TypeScript Debugging

**app.ts**:
```typescript
interface User {
    name: string;
    age: number;
}

function greet(user: User): string {
    return `Hello, ${user.name}!`;  // Breakpoint
}

const user: User = { name: 'Alice', age: 30 };
console.log(greet(user));
```

1. Compile: `npx tsc`
2. Debug the compiled `.js` file
3. Or configure source maps in `tsconfig.json`:
```json
{
  "compilerOptions": {
    "sourceMap": true
  }
}
```

---

## Code Actions

### Available Actions
| Command | Action |
|---------|--------|
| `Space ca` | Show code actions |
| `Space rn` | Rename symbol |
| `Space cf` | Format code |
| `gd` | Go to definition |
| `gr` | Find references |

### Auto Import
Type a function → LSP suggests import:
```javascript
// Type: readFile
// Suggests: import { readFile } from 'fs'
```

Accept with `Space ca` → "Add import"

### Refactoring
- Extract to function
- Extract to constant
- Convert to arrow function

---

## Formatting

### Prettier Setup
```bash
npm install --save-dev prettier
```

Create `.prettierrc`:
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2
}
```

Format: `Space cf`

### ESLint Setup
```bash
npm install --save-dev eslint
npx eslint --init
```

Lint errors show automatically!

---

## React Development

### Setup
```bash
npx create-react-app my-app
cd my-app
nvim src/App.js
```

### Features
- JSX completion
- Component props
- Hook signatures
- Import suggestions

**Example**:
```jsx
import React, { useState } from 'react';

function Counter() {
    const [count, setCount] = useState(0);  // Type hints!

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={() => setCount(count + 1)}>
                Increment
            </button>
        </div>
    );
}

export default Counter;
```

### Debug React
1. Set breakpoint in component
2. `F5` → "Launch"
3. Opens in browser
4. Breakpoint hits on interaction

---

## Common Workflows

### Express API
```bash
mkdir api && cd api
npm init -y
npm install express
nvim index.js
```

```javascript
const express = require('express');
const app = express();

app.use(express.json());

app.post('/api/users', (req, res) => {
    const user = req.body;  // Breakpoint: inspect request
    res.json({ message: 'User created', user });
});

app.listen(3000);
```

### Async/Await Debugging
```javascript
async function fetchData() {
    const response = await fetch('https://api.example.com');
    const data = await response.json();  // Breakpoint
    return data;
}

fetchData().then(console.log);
```

---

## Testing

### Jest Setup
```bash
npm install --save-dev jest
```

**sum.test.js**:
```javascript
const sum = (a, b) => a + b;

test('adds 1 + 2 to equal 3', () => {
    expect(sum(1, 2)).toBe(3);
});
```

Run:
```bash
npm test
```

---

## Pro Tips

### 1. Node.js REPL
```vim
:TermExec cmd="node"
```

### 2. Quick Run
```vim
:!node %
```

### 3. Package.json Scripts
```json
{
  "scripts": {
    "dev": "nodemon index.js",
    "test": "jest",
    "lint": "eslint ."
  }
}
```

Run: `:!npm run dev`

### 4. Environment Variables
Create `.env`:
```
PORT=3000
DB_URL=mongodb://localhost
```

Load in code:
```javascript
require('dotenv').config();
console.log(process.env.PORT);
```

---

## Resources

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Node.js Docs](https://nodejs.org/docs/)
- [React Docs](https://react.dev/)
