# Dotfiles

## These are my personal dotfiles and are a work in progress, they include various configuration files and scripts that I use to customize my macOS development environment. I have tried to keep them compatible with all Unix biased systems but there will be some macOS specific scripts and settings. Feel free to explore and use any parts that you find useful.  

### Warning: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need.  Don’t blindly use my settings unless you know what that entails. Use at your own risk! This script will install hombrew, zsh and some of my applications. As well as create symbolic links to the dotfiles in your home directory (~/) and set up the necessary configurations.
 
#### shell

This repo contains config for Z Shell (zsh) and bash. As of 2018, I primarily use zsh shell, but occasionally fall back to bash.
The bash and zsh configs are both well maintained.

#### Installation Instructions

To install these dotfiles on your system, follow these steps:

##### Clone this repository

```
git clone https://github.com/your-username/dotfiles.git
Change into the dotfiles directory:
```

##### Change into dotfiles directory

```
cd dotfiles
```

##### Run the installation scripts:  
  
```
(./master-install.sh)
```  

##### Overview of files

This repository includes the following dotfiles:

**Shell environment**  

[`.aliases`](.dotfiles/zsh/.aliases) [`.zshrc`](.dotfiles/zsh/zshrc) [`.zshenv`](.dotfiles/zsh/zshenv) [`.zprofile`](.dotfiles/zsh/zprofile) [`.zlogout`](.dotfiles/zsh/zlogout) [`.bash_profile`](.dotfiles/bash/.bash_profile) [`.bash_prompt,`](.dotfiles/bash/.bash_prompt) [`.bashrc,`](.dotfiles/bash/.bashrc) [`functions`](.dotfiles/zsh/functions)  

**Git, Configuration** 🤩

- gitconfig
- gitignore_global

#### * TODO - Add description of what files and settings are added or changed

#### Customization

Feel free to modify these dotfiles according to your preferences. You can add or remove configurations, aliases, or scripts as needed. Remember to update the
repository if you make any significant changes that you'd like to keep.

#### Credits

These dotfiles are inspired by various sources and the work of many talented developers. I'd like to acknowledge their contributions and thank them for sharing
their knowledge.

Some notable inspirations include:

- <https://github.com/mathiasbynens/dotfiles>
- <https://github.com/holman/dotfiles>
- <https://github.com/alrra/dotfiles>
- <https://github.com/thoughtbot/dotfiles>
- <https://github.com/paulirish/dotfiles>

#### License

This project is licensed under the MIT License. Feel free to use and modify these dotfiles as you see fit.

If you have any questions or suggestions, please feel free to open an issue or contact me. Enjoy! 👌🏻
