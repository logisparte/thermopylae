# thermopylae

Project template

## Overview

The Battle of Thermopylae took place in 480 BC. between the Persian Achaemenid Empire under
Xerxes I and an alliance of Greek city-states led by Sparta under Leonidas I. For three days,
about 7,000 Greek hoplites led by 300 Spartans held the narrow pass of Thermopylae against
120,000 to 300,000 Persian invaders. On the last day of the battle, the Persians finally managed
to outflank the defenders through a narrow pass in the mountains. All the Greek forces then
retreated, except for the 300 Spartans, who remained and sacrificed their lives to obey the
famous laws of their state against retreat or surrender.

Although it ended in a tactical defeat, the battle later turned out to be a resounding strategic
victory for the Greeks. Indeed, the sacrifice of Leonidas and his Brave Three Hundred inspired
all the Greek city-states to unite and repel the Persians. In their honor, at Thermopylae today,
travelers can read the Epitaph of Simonides:

_Go tell the Spartans, passerby: That here, by Spartan law, we lie._

## License

`thermopylae` is distributed under the terms of the [Apache 2.0 license](/LICENSE)

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop)

## Virtual development environment

This project's development environment was designed to be completely encapsulated in a
[Docker](https://github.com/docker) container. Such an approach provides many benefits,
including:

- Minimizing the project's footprint on developer machines
- Deterministic program executions, both locally and on the CI/CD server (~~_It Works On My
  Machine™_~~)
- Cross-platform portability
- Fast onboarding of new developers

## Tasks

A number of tasks (shell script modules) are available to help automate the development
workflow. They are defined in `dev/tasks`. They also all share the environment variables defined
in `dev/environment.sh`. A number of shell script helper modules are also available in
`dev/helpers` to help write these tasks.

To run any task, do:

```shell
./dev/task.sh format
./dev/task.sh lint

# OR

alias task="./dev/task.sh" # Add this line to your shell profile
task format
task lint
```

### Install

`git` hooks are used to ensure commit integrity.

- The `commit-msg` hook uses `commitlint` to lint commit messages
- The `pre-commit` hook uses the [format](#format) and [lint](#lint) tasks to ensure commited
  code is formatted and linted

To install `git` hooks:

```shell
task install
```

### Uninstall

To uninstall all `git` hooks:

```shell
task uninstall
```

### Format

[shfmt](https://github.com/mvdan/sh) is used to format shell files.

[Prettier](https://github.com/prettier/prettier) is used to format markdown and yaml files.

To format dirty files:

```shell
task format
```

To format all files:

```shell
task format all
```

> The `pre-commit` git hook will automatically format staged files on commit

### Lint

[MarkdownLint](https://github.com/igorshubovych/markdownlint-cli) is used to analyze markdown
code.

To analyze dirty files:

```shell
task lint
```

To analyze all files:

```shell
task lint all
```

> The `pre-commit` git hook will automatically lint staged files on commit
