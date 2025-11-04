# ☕ Java Development Guide

Complete guide for Java development.

---

## Setup

### Language Server
**jdtls** (Eclipse JDT Language Server via Mason)

### Debugger
**java-debug-adapter** (via Mason)

### Java Installation
```bash
# Debian/Ubuntu
sudo apt-get install default-jdk

# Arch
sudo pacman -S jdk-openjdk
```

---

## Features

- Intelligent code completion
- Maven/Gradle support
- JUnit integration
- Refactoring tools
- Import organization

---

## Project Setup

### Maven Project
```bash
mvn archetype:generate \
    -DgroupId=com.example \
    -DartifactId=myapp \
    -DarchetypeArtifactId=maven-archetype-quickstart
cd myapp
nvim src/main/java/com/example/App.java
```

### Gradle Project
```bash
gradle init --type java-application
nvim app/src/main/java/App.java
```

---

## Debugging

**App.java**:
```java
package com.example;

public class App {
    public static int add(int a, int b) {
        int sum = a + b;  // Breakpoint (F9)
        return sum;
    }

    public static void main(String[] args) {
        int result = add(5, 3);
        System.out.println("Result: " + result);
    }
}
```

Steps:
1. Compile: `mvn compile`
2. Open: `nvim src/main/java/com/example/App.java`
3. Breakpoint: `F9`
4. Debug: `F5`
5. Select: "Debug (Launch)"

---

## Commands

```vim
:!mvn clean install    " Build with Maven
:!mvn test             " Run tests
:!gradle build         " Build with Gradle
```

---

## Resources

- [Java Documentation](https://docs.oracle.com/en/java/)
- [Eclipse JDT.LS](https://github.com/eclipse/eclipse.jdt.ls)
