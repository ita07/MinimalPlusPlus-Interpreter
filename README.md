# MinimalPlusPlus-Interpreter
This is part of a school project for a toy C/Python-like language.


## Getting Started

### Prerequisites

* flex
* bison
* make

### Installation (Ubuntu 18+)

Run the following commands

```
sudo apt-get update
sudo apt-get install flex
sudo make install
sudo apt-get install -y bison
```

## Build

* Navigate to project's root directory
* Run `make` to build
* Run `make clean` to remove the build files

## Usage

* Navigate to project's bin directory
* Run `./minimalplusplus ../examples/filename.min`