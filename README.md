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
    -t, --tunnelling_wall [NO]       Enable the tunnelling wall mode
```

### Normal Mode

```bash
./bin/zombieland -i example-data/input.txt
```

### Tunnelling Wall Mode

```bash
./bin/zombieland -i example-data/input.txt -t yes
```

## Application Architecture

        +----------------------------+
        |             CLI            |
        +--------------+-------------+
                       |
    +------------------v-----------------+
    |              Workflow              |
    +------------------------------------+
    |   +----------------------------+   |
    |   |         Transformer        |   | <- Transforms CSV input for consumption.
    |   +--------------+-------------+   |
    |                  |                 |
    |   +--------------v-------------+   |
    |   |            Game            |   | <- Runs the game logic.
    |   +----------------------------+   |
    |   |  +----------------------+  |   |
    |   |  |        Models        |  |   | <- Domain models.
    |   |  +----------------------+  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  |       Map      |  |  |   |
    |   |  |  | +------------+ |  |  |   |
    |   |  |  | | Coordinate | |  |  |   |
    |   |  |  | +------------+ |  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  |     Object     |  |  |   | <- Zombie or creature.
    |   |  |  | +------------+ |  |  |   |
    |   |  |  | |  Movement  | |  |  |   |
    |   |  |  | +------------+ |  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  +----------------------+  |   |
    |   +--------------+-------------+   |
    |                  |                 |
    |   +--------------v-------------+   |
    |   |          Presenter         |   | <- Presents the game output to CLI.
    |   +----------------------------+   |
    +------------------------------------+

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
