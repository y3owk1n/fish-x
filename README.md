# Extra common utilities for Fish 🐟

Welcome to `fish-x`, a Fish shell plugin that enhances your shell experience with upgraded commands on top of regular commands.

- `mkdirx`
- `touchx`
- `gclx`

## Installation

### Using Nix's Home Manager (Recommended)

```fish
{
    programs.fish = {
        enable = true;
        plugins = [
            {
                name = "fish-x";
                src = pkgs.fetchFromGitHub {
                    owner = "y3owk1n";
                    repo = "fish-x";
                    rev = "d5488105456c087f449168c6d4df1cc7a092067e";
                    sha256 = "sha256-Oq0SsNdVrx7WpIuIdwpccQBK6JJuhLPS3Zj7J0nqA1s=";
                };
            }
        ];
    };
}
```

### Using Fisher

```fish
fisher install y3owk1n/fish-x
```

### Manually

1. Clone this repository:

```fish
git clone https://github.com/y3owk1n/fish-x.git
```

2. Source the all the functions/*.fish file in your Fish configuration:

```fish
source /path/to/gclx.fish
source /path/to/mkdirx.fish
source /path/to/touchx.fish
```

## Functions

### 1. `gclx` - Git Clone and Change Directory

The `gclx` function simplifies the process of cloning a Git repository and navigating into it with a single command.

#### Usage

```fish
gclx owner/repo
```

or

```fish
gclx https://github.com/owner/repo.git
```

### 2. `mkdirx` - Create Directory and Change Directory

The `mkdirx` function combines creating a directory and changing into it in a single command, streamlining your workflow.

#### Usage

```fish
mkdirx folder
```

### 3. `touchx` - Touch and Open in Editor

The `touchx` function creates or updates a file and opens it in your preferred editor, ensuring a seamless editing experience.

#### Usage

```fish
touchx <file>
```

## Configuration

Before using `touchx`, ensure that your preferred editor is set in the **$EDITOR** environment variable. You can set it using:

```fish
set -Ux EDITOR nvim # vim, code, emacs, etc.
```

## Troubleshooting

If you encounter any issues or errors, please refer to the ~~troubleshooting section in the wiki~~ (Not ready yet).

## Contributions

Feel free to contribute by opening issues, suggesting enhancements, or submitting pull requests. We value your feedback and ideas to enhance the capabilities of `fish-x` further!

## License

This plugin is licensed under the MIT License. Feel free to use, modify, and distribute it as you see fit.

Happy fishing! 🐟
