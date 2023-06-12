<p align="center">
 <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDQ1NjI2NDY0MWJiOGE1NWMwMWI2OTFkY2U0ZDgwNmFmZGI5ZmM3YyZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/Bzzb92NKwUOj0FjQOd/giphy.gif" title="Cool Cat!"
</p>

# 🤖 Dotfiles  
  
<div style="display: flex; justify-content: space-between; align-items: center;">
   <img src="https://img.shields.io/badge/Dotfiles%3A-Version%201.0-blue">  
   <img src="https://img.shields.io/badge/Author%3A-Luke%20Aimson-blue">  
   <img src="https://img.shields.io/badge/License%3A-MIT-blue">
</div>  

<br />
👋 **Welcome to my personal dotfiles repository!**  

**These dotfiles are my ongoing project, carefully crafted to enhance and personalize my macOS development environment. While I've aimed to make them compatible with Unix-based systems, please note that there are some macOS-specific scripts and settings. Feel free to dive in, explore, and make use of any parts that catch your interest. Your feedback and suggestions are always welcome as I continue to refine and improve these dotfiles. Enjoy the customization journey!.**  

**This repository includes configuration files for both Z Shell (zsh) and Bash. While I mainly utilize the zsh shell as of 2018, there are instances where I still resort to bash. Rest assured that both the bash and zsh configurations are diligently maintained to ensure optimal performance.**
  
<br>

***Warning: If you're interested in trying out these dotfiles, I recommend forking this repository, carefully reviewing the code, and removing any elements that don't align with your preferences. It's important not to blindly adopt my settings unless you fully understand their implications. Please use them at your own risk! This script will facilitate the installation of Homebrew, Zsh, and some of my preferred applications. It will also create symbolic links to the dotfiles in your home directory (~/) and configure everything accordingly."***

**TODO - Upload bash configureation files**  
**TODO - Add description of what files and settings are added or changed**

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

**Overview of files**

This repository includes the following dotfiles:

**Shell environment**  

[`.aliases`](.dotfiles/zsh/.aliases) [`.zshrc`](.dotfiles/zsh/zshrc) [`.zshenv`](.dotfiles/zsh/zshenv) [`.zprofile`](.dotfiles/zsh/zprofile) [`.zlogout`](.dotfiles/zsh/zlogout) [`.bash_profile`](.dotfiles/bash/.bash_profile) [`.bash_prompt,`](.dotfiles/bash/.bash_prompt) [`.bashrc,`](.dotfiles/bash/.bashrc) [`functions`](.dotfiles/zsh/functions)  

**Git, Configuration** 🤩  

- gitconfig  
- gitignore_global

**Customization**

Feel free to modify these dotfiles according to your preferences. You can add or remove configurations, aliases, or scripts as needed. Remember to update the
repository if you make any significant changes that you'd like to keep.

**Credits**

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
