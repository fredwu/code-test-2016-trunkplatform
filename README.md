# Trunk Platform Code Test by Fred Wu

## Prerequisite

- ruby 2.2+
- bundler

```bash
bundle install
```

## Usage

```bash
./bin/zombieland --help

Example usage:
    -i, --input FILE                 Path to the zombie game input file
```

```bash
./bin/zombieland -i example-data/input.txt
```

## Application Architecture

## Test Suite

### Run all the tests

```bash
bundle exec rake
```

### Run only Rubocop

```bash
bundle exec rake rubocop
```

### Run only spec

```bash
bundle exec rake spec
```

## Author

- Fred Wu <ifredwu@gmail.com>
- 2016-05-14
