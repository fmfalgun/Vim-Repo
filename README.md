# My Vim Configuration

> "In a world where you can be anything, be a terminal wizard."

Welcome to my Vim configuration! 🎉 This setup is designed to make Vim not just powerful, but a joy to use. Let's dive into what makes this configuration special.

## Key Features

- 📜 **Line Numbers:** Always know where you are in your code.
- 🖱️ **Mouse Support:** Scroll, click, and drag with ease.
- 🎨 **Beautiful Colorscheme:** Enjoy the dark and pleasant Jellybeans theme.
- ⚡ **Autocompletion:** Code faster with intelligent suggestions.
- 🔍 **File Autocomplete:** Quickly find and import/export files.
- 🌐 **Language Support:** Seamless coding in C, C++, Python, JavaScript, Django, .NET Core, ReactJS, AngularJS, and VueJS.
- 💻 **Full-Stack Development:** Perfect for full-stack web development.
- 🗃️ **Database Integration:** Work effortlessly with databases.
- 🐞 **Debugging:** Powerful debugging tools for multiple languages.
- 📂 **Multiple File Handling:** Open and manage multiple files like a pro.
- 📁 **Collapsible File Tree:** Keep your workspace organized with a file stack view.

## Plugins Overview

| Plugin                                   | Purpose                                                                                                       | Related Commands                                               |
|------------------------------------------|---------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| ryanoasis/vim-devicons                   | Provides file type icons for NERDTree and other plugins                                                       | -                                                             |
| preservim/nerdtree                       | A file system explorer for Vim                                                                                | `:NERDTreeToggle` to toggle NERDTree                           |
| vim-airline/vim-airline                  | A lightweight status/tabline plugin that displays useful information about the current buffer                  | -                                                             |
| ctrlpvim/ctrlp.vim                       | A fuzzy file finder that makes it easy to navigate and open files in your project                             | `:CtrlP` to open CtrlP file finder                            |
| powerline/powerline                      | A statusline plugin that provides a customizable and informative status line for Vim                          | -                                                             |
| Shougo/denite.nvim                       | A versatile asynchronous fuzzy finder and many-to-many text filter engine                                     | `:Denite` to start Denite fuzzy finder                         |
| Shougo/unite.vim                         | A plugin that provides a framework for searching and working with lists of items (files, buffers, tags, etc.) | `:Unite` to start Unite list view                              |
| itchyny/lightline.vim                    | A light and configurable statusline/tabline for Vim                                                           | -                                                             |
| mhinz/vim-startify                       | A plugin that provides a start screen for Vim with a list of recently opened files, bookmarks, and project files | -                                                             |
| Shougo/vimfiler.vim                      | A file explorer plugin similar to NERDTree                                                                    | `:VimFilerToggle` to toggle VimFiler                           |
| wsdjeg/vim-buffet                        | Provides improved buffer management and workspace control                                                     | -                                                             |
| vim-scripts/flagship                     | Enhances the Vim statusline with additional context                                                           | -                                                             |
| puremourning/vimspector                  | A multi-language debugging system for Vim                                                                     | `<F5>` to continue, `<F3>` to stop, `<F9>` to toggle breakpoint, `<F10>` to step over, `<F11>` to step into, `<F12>` to step out |
| neoclide/coc.nvim                        | Intellisense engine for Vim8 & Neovim, supports multiple languages                                            | -                                                             |
| dense-analysis/ale                       | A linter and fixer for various languages                                                                      | -                                                             |

## Areas for Improvement and Future Work

- 🛠️ **Custom Keybindings:** Enhance productivity with more custom keybindings.
- 🌍 **Better Internationalization:** Improve support for non-English languages.
- 📈 **Performance Optimization:** Speed up the loading and execution time.
- 📦 **New Plugins:** Continuously add and configure new plugins to stay up-to-date.
- 🧩 **Plugin Integration:** Ensure seamless integration and compatibility among all plugins.
- 📚 **Documentation:** Create detailed documentation and tutorials for newcomers.
- 🧪 **Testing Configurations:** Test configurations for different development environments.

## Vim Configuration

### `.vimrc` File

```vim
" ~/.vimrc

" Basic settings
set number
set mouse=a
colorscheme jellybeans
let g:jellybeans_use_term_italics = 1
set guifont=Monaco:h10 noanti
set encoding=UTF-8

" Load Pathogen
execute pathogen#infect()
execute pathogen#helptags()

" Use Vim-Plug to manage plugins
call plug#begin('~/.vim/plugged')

" List of plugins managed by Vim-Plug
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'powerline/powerline'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'Shougo/vimfiler.vim'
Plug 'wsdjeg/vim-buffet'
Plug 'vim-scripts/flagship'

" Debugger plugins
Plug 'puremourning/vimspector'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()

" Enable Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" CoC (Conquer of Completion) configuration for language servers and debuggers
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-tsserver',
    \ 'coc-clangd',
    \ 'coc-omnisharp'
\]

" ALE (Asynchronous Lint Engine) configuration
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\   'cpp': ['clang'],
\   'c': ['clang'],
\   'cs': ['omnisharp']
\}

" NERDTree settings
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Airline settings
let g:airline_powerline_fonts = 1

" Startify settings
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_lists = [
    \ { 'type': 'files', 'header': ['   Recent Files'] },
    \ { 'type': 'sessions', 'header': ['   Sessions'] }
\]

" Lightline settings
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename'
    \ }
\}

" Vimspector mappings
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut

" Other useful mappings
nnoremap <silent> <leader>d :Denite file_rec<CR>
nnoremap <silent> <leader>u :Unite file_rec<CR>

" Autocommands to auto-load sessions
augroup vimrc_autoload
    autocmd!
    autocmd VimEnter * if argc() == 0 | silent! source ~/.vim/sessions/default.vim | endif
augroup END


```
## How to Contribute

If you have any recommendations or suggestions for improving my Vim configuration, feel free to open an issue or submit a pull request.

