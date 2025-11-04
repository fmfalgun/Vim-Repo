# 🐹 Go Development Guide

Complete guide for Go (Golang) development with debugging.

---

## Setup

### Language Server
**gopls** (automatically installed via Mason)

### Debugger
**delve** via Mason

### Go Installation
```bash
# Debian/Ubuntu
sudo apt-get install golang-go

# Arch
sudo pacman -S go
```

Verify:
```bash
go version
```

---

## Features

### Auto-completion
- Package imports
- Function signatures
- Struct fields
- Interface methods

### Code Actions
- Add imports automatically
- Fill struct fields
- Extract to function
- Generate interface stubs

---

## Project Setup

### Initialize Module
```bash
mkdir myproject
cd myproject
go mod init github.com/username/myproject
nvim main.go
```

### Project Structure
```
myproject/
├── go.mod
├── go.sum
├── main.go
├── internal/
│   └── handlers/
└── pkg/
    └── utils/
```

---

## Debugging

### Quick Start

**main.go**:
```go
package main

import "fmt"

func add(a, b int) int {
    sum := a + b  // Set breakpoint here (F9)
    return sum
}

func main() {
    result := add(5, 3)
    fmt.Printf("Result: %d\n", result)
}
```

Debug steps:
1. Open: `nvim main.go`
2. Set breakpoint: `F9` on line 6
3. Press `F5`
4. Select: "Debug"
5. Debug UI opens
6. Press `F10` to step
7. Inspect `a`, `b`, `sum`

### Debug Tests

**calc_test.go**:
```go
package main

import "testing"

func TestAdd(t *testing.T) {
    result := add(2, 3)  // Breakpoint
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}
```

Debug:
1. Set breakpoint in test
2. `F5` → "Debug test"
3. Step through test execution

### Web Server Debugging

**server.go**:
```go
package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    message := "Hello, World!"  // Breakpoint
    fmt.Fprintf(w, message)
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
```

1. Set breakpoint in handler
2. `F5` → "Debug"
3. In browser: visit `localhost:8080`
4. Breakpoint hits!

---

## Code Actions

### Imports
```go
// Type: json.Marshal
// Press Space ca → "Add import"
// Automatically adds: import "encoding/json"
```

### Fill Struct
```go
type User struct {
    Name string
    Age  int
}

func main() {
    u := User{}  // Cursor here
    // Space ca → "Fill struct"
    // Becomes:
    u := User{
        Name: "",
        Age: 0,
    }
}
```

### Extract Function
1. Select code in visual mode
2. `Space ca` → "Extract to function"

### Generate Interface
```go
type Handler struct{}

func (h *Handler) Handle() {}
func (h *Handler) Close() {}

// Space ca → "Generate interface"
// Creates:
type HandlerInterface interface {
    Handle()
    Close()
}
```

---

## Formatting

Go files auto-format on save (via `gofmt`).

Manual format:
```vim
Space cf
```

---

## Testing

### Run Tests
```bash
# All tests
go test ./...

# Specific test
go test -run TestAdd

# With coverage
go test -cover ./...
```

In Neovim:
```vim
:!go test ./...
```

### Test Coverage
```bash
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

---

## Common Workflows

### REST API
```go
package main

import (
    "encoding/json"
    "net/http"
)

type User struct {
    Name string `json:"name"`
    Age  int    `json:"age"`
}

func createUser(w http.ResponseWriter, r *http.Request) {
    var user User
    json.NewDecoder(r.Body).Decode(&user)  // Breakpoint

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(user)
}

func main() {
    http.HandleFunc("/users", createUser)
    http.ListenAndServe(":8080", nil)
}
```

### Concurrency Debugging
```go
package main

import (
    "fmt"
    "time"
)

func worker(id int, jobs <-chan int, results chan<- int) {
    for j := range jobs {
        result := j * 2  // Breakpoint
        results <- result
    }
}

func main() {
    jobs := make(chan int, 100)
    results := make(chan int, 100)

    // Start workers
    for w := 1; w <= 3; w++ {
        go worker(w, jobs, results)
    }

    // Send jobs
    for j := 1; j <= 5; j++ {
        jobs <- j
    }
    close(jobs)

    // Collect results
    for a := 1; a <= 5; a++ {
        fmt.Println(<-results)
    }
}
```

Debug goroutines:
- Debug UI shows all goroutines
- Switch between goroutines in stack panel

---

## Pro Tips

### 1. Go Module Management
```bash
# Add dependency
go get package-name

# Tidy dependencies
go mod tidy

# Verify dependencies
go mod verify
```

### 2. Quick Run
```vim
:!go run %
```

### 3. Build Binary
```bash
go build -o myapp main.go
```

### 4. Cross-Compilation
```bash
GOOS=windows GOARCH=amd64 go build
GOOS=linux GOARCH=arm64 go build
```

### 5. Benchmark Tests
```go
func BenchmarkAdd(b *testing.B) {
    for i := 0; i < b.N; i++ {
        add(5, 3)
    }
}
```

Run:
```bash
go test -bench=.
```

---

## Resources

- [Go Documentation](https://go.dev/doc/)
- [Effective Go](https://go.dev/doc/effective_go)
- [gopls Settings](https://github.com/golang/tools/blob/master/gopls/doc/settings.md)
