# Lulu-Engine

Welcome to Lulu! A 3D rendering engine for easily creating a digital twins app to manage your foods. This engine focuses on food rendering and it can help to manage your foods, recipes or diet with a decent performance on Windows.

### Why

There are a lot of mature graphics engines for people to select for 3D rendering, but many of them have relatively high learning costs and many redundant features that it is not critical for food rendering. So that is why I want to make a graphics engine of my own.  

### 🚀 Quick Start

#### Clone this repository to local;

```bash
go install github.com/xyz/zipzod@latest
```

#### Run "GenerateProjects.bat" to build the Lulu engine.

```bash
zipzod -i ./input -o ./output.zip
```

### 📖 Usage

Available flags:

* `-i` - The input file or directory
* `-o` - The output file or directory
* `-v` - Verbose output
* `-h` - Show help
* `-p` - The number of parallel workers to use (default 4)
* `-d` - The maximum depth to traverse (default 1)
* `-f` - The file extensions to include (default .txt, .md)

### Examples

Unzip a file

```bash
zipzod -i ./input.zip -o ./output
```

Zip with a different number of workers

```bash
zipzod -i ./input -o ./output.zip -p 8
```
