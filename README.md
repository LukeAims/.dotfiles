<p align="center">
<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDQ1NjI2NDY0MWJiOGE1NWMwMWI2OTFkY2U0ZDgwNmFmZGI5ZmM3YyZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/Bzzb92NKwUOj0FjQOd/giphy.gif">
</p>  

# 🤖 Dotfiles  
  
![Version](https://img.shields.io/badge/Dotfiles%3A-Version%202.5-blue) &nbsp;
![Author](https://img.shields.io/badge/Author%3A-Luke%20Aimson-blue) &nbsp;
![Licence](https://img.shields.io/badge/License%3A-MIT-blue) &nbsp;  

**Welcome to my personal dotfiles repository!**  

**These dotfiles are my ongoing project, carefully crafted to enhance and personalize my macOS development environment. While I've aimed to make them compatible with Unix-based systems, please note that there are some macOS-specific scripts and settings. Feel free to dive in, explore, and make use of any parts that catch your interest. Your feedback and suggestions are always welcome as I continue to refine and improve these dotfiles. Enjoy the customization journey!**

## What's new in 2025?

The latest refresh focuses on portability, performance, and modern tooling:

- ✅ **XDG-aware layout** – the shell now respects the XDG base directory spec, keeping caches and config tidier.
- ⚡ **Fast startup** – the configuration ships with [Antidote](https://github.com/mattmc3/antidote) bundles pre-cached and lazy loaded.
- 🛰️ **Future-proof prompt** – Starship is used when available, with a lightweight `vcs_info` fallback.
- 📦 **Toolchain aware** – first-class hooks for `mise`, `direnv`, `zoxide`, `fzf`, Docker, Kubernetes, and more.
- 🛡️ **Safer defaults** – saner history settings, improved completion styles, and guarded aliases for cross-platform use.


**This repository includes configuration files for both Z Shell (zsh) and Bash. While I mainly utilize the zsh shell as of 2018, there are instances where I still resort to bash. Rest assured that both the bash and zsh configurations are diligently maintained to ensure optimal performance.**

✋ ***Warning: If you're interested in trying out these dotfiles, I recommend forking this repository, carefully reviewing the code, and removing any elements that don't align with your preferences. It's important not to blindly adopt my settings unless you fully understand their implications. Please use them at your own risk! This script will facilitate the installation of Homebrew, Zsh, and some of my preferred applications. It will also create symbolic links to the dotfiles in your home directory (~/) and configure everything accordingly."***

**TODO - Upload bash configuration files**
**TODO - Add description of what files and settings are added or changed**

> **Tip:** symlink the `zsh` folder to `${XDG_CONFIG_HOME:-$HOME/.config}/zsh` to take advantage of the refreshed structure.

### Installation Instructions

To install these dotfiles on your system, follow these steps:

**Clone this repository**

```
git clone https://github.com/LukeAims/.dotfiles.git
```

**Change into the dotfiles directory:**

```
cd dotfiles
```

**Run the installation scripts:**

```
(./master-install.sh)
```

### Publishing the 2025 refresh to GitHub

If you would like to publish the refreshed configuration, create a topic branch and push it to your fork. You can either run the helper script or execute the commands manually.

#### Quick push helper

The repository now ships with `git/publish-refresh.sh`, which automates the push flow and performs a few safety checks before sending anything upstream.

```bash
git/publish-refresh.sh
```

By default the helper pushes `feature/publish-2025-update` to the `origin` remote. Pass a custom branch or remote if you need to override the defaults:

```bash
git/publish-refresh.sh feature/my-custom-branch upstream
```

The script ensures that the requested remote exists, creates the branch if it is missing, checks it out, and finally runs `git push -u <remote> <branch>`.

#### Manual steps

Prefer to push the branch yourself? Run the following commands instead:

1. Create the branch locally and switch to it:

   ```bash
   git checkout -b feature/publish-2025-update
   ```

2. Add your remote if it has not been configured yet:

   ```bash
   git remote add origin git@github.com:<your-user>/.dotfiles.git
   ```

3. Push the branch upstream:

   ```bash
   git push -u origin feature/publish-2025-update
   ```

Once the branch is available on GitHub you can open a pull request to review the 2025 refresh.

**Overview of files**

This repository includes the following dotfiles:

**Shell environment**  

[`aliases`](zsh/.aliases.zsh) [`zshrc`](zsh/.zshrc) [`zshenv`](zsh/.zshenv) [`zprofile`](zsh/.zprofile) [`zlogout`](zsh/.zlogout) [`bash_profile`](bash/.bash_profile) [`bash_prompt`](bash/.bash_prompt) [`bashrc`](bash/.bashrc) [`functions`](/functions)  

**Git, Configuration** 🤩  

- gitconfig  
- gitignore_global

**Customisation**

Feel free to modify these dotfiles according to your preferences. You can add or remove configurations, aliases, or scripts as needed. Remember to update the
repository if you make any significant changes that you'd like to keep.

**Credits** 👏🏼

These dotfiles are inspired by various sources and the work of many talented developers. I'd like to acknowledge their contributions and thank them for sharing
their knowledge.

Some notable inspirations include:

- <https://github.com/mathiasbynens/dotfiles>
- <https://github.com/holman/dotfiles>
- <https://github.com/alrra/dotfiles>
- <https://github.com/thoughtbot/dotfiles>
- <https://github.com/paulirish/dotfiles>

**License**

This project is licensed under the MIT License. Feel free to use and modify these dotfiles as you see fit.
