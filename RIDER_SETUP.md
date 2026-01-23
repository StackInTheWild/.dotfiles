# Rider Configuration Guide - Matching Neovim Setup

This guide will help you configure JetBrains Rider to match your Neovim configuration as closely as possible.

## Quick Start

1. **Copy the IdeaVim configuration:**
   ```bash
   ln -sf ~/.dotfiles/.ideavimrc ~/.ideavimrc
   ```

2. **Install and enable IdeaVim plugin in Rider**
   - Go to `File > Settings > Plugins`
   - Search for "IdeaVim"
   - Click Install and restart Rider

3. **Follow the detailed setup below**

---

## 1. IdeaVim Plugin Setup

### Install IdeaVim
- `File > Settings > Plugins`
- Search for "IdeaVim"
- Install and restart Rider

### Configure IdeaVim
The `.ideavimrc` file has been created at `~/.ideavimrc` with all your Neovim keybindings.

**Key mappings from your Neovim config:**
- **Leader key:** `Space` (same as Neovim)
- **File navigation:** `<leader>pf` (find files), `<C-p>` (git files), `<leader>ps` (search)
- **LSP actions:** `gd` (definition), `K` (hover), `<leader>vca` (code actions), `<leader>vrn` (rename)
- **Git:** `<leader>gg` (git status), `<leader>gb` (blame), `<leader>gl` (log)
- **Window:** `<leader>wq` (close), `<C-h/j/k/l>` (navigate splits)
- **Clipboard:** `<leader>y` (yank to system), `<leader>p` (paste without yank)

---

## 2. Editor Settings

### General Appearance
`File > Settings > Editor > General > Appearance`

- ☑ **Show line numbers**
- ☑ **Show method separators**
- ☑ **Show whitespaces** (optional, matches your attention to detail)
- **Caret blinking:** Off (for vim-like experience)

### Line Numbers
`File > Settings > Editor > General > Appearance`

Unfortunately, JetBrains IDEs don't have a built-in relative line numbers option. However:
- Install the **"Relative Line Numbers"** plugin
- Or use IdeaVim's `:set relativenumber` (works within IdeaVim)

### Scrolling
`File > Settings > Editor > General`

- Under "Scrolling":
  - **Vertical scroll offset:** 8 (matches `scrolloff=8` in Neovim)
  - **Horizontal scroll offset:** 5

### Code Style (Indentation)
`File > Settings > Editor > Code Style`

**For C#:**
- `File > Settings > Editor > Code Style > C#`
- **Tab size:** 4
- **Indent:** 4
- **Continuation indent:** 4
- ☑ **Use tab character:** OFF (use spaces - matches `expandtab=true`)

**For other languages:**
- Repeat for: JavaScript, TypeScript, JSON, XML, etc.
- Set consistent **4-space** tabs across all file types

### Right Margin (Color Column)
`File > Settings > Editor > Code Style`

- **Hard wrap at:** 120 (matches `colorcolumn=120` in Neovim)
- **Visual guides:** 120

### Search Settings
`File > Settings > Editor > General`

- Under "Editor Tabs":
  - ☐ **Highlight usages on Caret** (matches `hlsearch=false`)

---

## 3. Color Scheme (Rose Pine Theme)

Your Neovim uses the **Rose Pine** color scheme.

### Option 1: Install Rose Pine for JetBrains
Unfortunately, there's no official Rose Pine theme for JetBrains. However:

1. Download a community port if available from:
   - [JetBrains Marketplace](https://plugins.jetbrains.com/)
   - Search for "Rose Pine" or "Rosé Pine"

### Option 2: Use Similar Dark Themes
`File > Settings > Editor > Color Scheme`

Choose a theme with similar aesthetics:
- **Dracula** (popular dark theme)
- **One Dark** (dark with good contrast)
- **Night Owl** (dark with warm tones)
- **Material Theme UI** plugin > "Palenight" variant

### Option 3: Import Custom Theme
You can create/import a custom theme:
1. Go to `File > Settings > Editor > Color Scheme`
2. Click the gear icon > "Import Scheme"
3. Import an `.icls` file (JetBrains color scheme format)

---

## 4. File Tree / Project Explorer

`File > Settings > Appearance & Behavior > System Settings`

### Project Tool Window
- **Default project directory:** Set your preferred workspace
- **Reopen projects on startup:** Configure as needed

`File > Settings > Project > Project Structure`

- Configure to auto-expand like nvim-tree if desired

### Keybindings (already in .ideavimrc)
- `<leader>pv` - Open project explorer
- `<leader>e` - Toggle project tool window

---

## 5. Terminal Configuration

`File > Settings > Tools > Terminal`

- **Shell path:** Use your preferred shell (matches your system)
  - Linux: `/bin/zsh` or `/bin/bash`
- **Tab name:** "Terminal"
- **Audible bell:** Off

### Terminal Keybinding (already in .ideavimrc)
- `<leader>tt` - Open terminal

---

## 6. Git Integration

Rider has excellent built-in Git support (better than vim-fugitive in many ways).

### Git Configuration
`File > Settings > Version Control > Git`

- **Path to Git executable:** Auto-detected
- ☑ **Use credential helper**

### Git Tool Windows
- **Git tool window:** Bottom panel (like vim-fugitive)
- **Commit tool window:** Left panel

### Keybindings (already in .ideavimrc)
- `<leader>gg` - Git commit tool window
- `<leader>gb` - Git blame
- `<leader>gd` - Git diff
- `<leader>gl` - Git log

### Alternative: LazyGit Integration
If you prefer LazyGit (like in your Neovim setup):

1. Install the **"LazyGit"** plugin from JetBrains Marketplace
2. Configure: `File > Settings > Tools > LazyGit`
3. Add custom keybinding or use from terminal

---

## 7. Code Intelligence (LSP Equivalent)

Rider has superior C# language support built-in (better than any LSP).

### Code Analysis Settings
`File > Settings > Editor > Inspections`

- **Profile:** "Default" or create custom
- ☑ Enable all C# inspections
- Configure severity as needed

### Keybindings (already in .ideavimrc)
All LSP-like features are mapped:
- `gd` - Go to definition
- `gi` - Go to implementation
- `gy` - Go to type definition
- `K` - Show documentation (hover)
- `gr` / `<leader>vrr` - Find usages/references
- `<leader>vrn` - Rename
- `<leader>vca` - Code actions
- `[d` / `]d` - Next/previous error

---

## 8. Buffer/Tab Management

`File > Settings > Editor > General > Editor Tabs`

### Tab Settings (similar to bufferline)
- **Tab placement:** Top
- **Tab limit:** 10-15 (or unlimited)
- ☑ **Show tabs in one row** (or multiple rows based on preference)
- **Closing policy:** "Close non-modified files first"

### Keybindings (already in .ideavimrc)
- `<leader>bn` - Next tab
- `<leader>bp` - Previous tab
- `<leader>bd` - Close buffer/tab
- `<leader>wq` - Close window

---

## 9. Which-Key Equivalent

Your Neovim uses which-key for command discovery.

### Option 1: Which-Key for IdeaVim
The `.ideavimrc` includes `set which-key` which provides basic key binding hints.

### Option 2: Key Promoter X Plugin
Install **"Key Promoter X"** for learning IDE shortcuts:
- `File > Settings > Plugins`
- Search "Key Promoter X"
- Install and restart

### Option 3: Find Action
- Press `Ctrl+Shift+A` to search for any action
- Or use `<leader>pa` (mapped in .ideavimrc)

---

## 10. Additional Recommended Plugins

Install these plugins to enhance the Neovim-like experience:

### Essential Plugins
1. **IdeaVim** - Vim emulation (required)
2. **IdeaVim-EasyMotion** - Quick navigation
3. **IdeaVim-Quickscope** - Highlight unique characters for f/F/t/T
4. **Relative Line Numbers** - Show relative line numbers

### Productivity Plugins
5. **Key Promoter X** - Learn shortcuts (which-key alternative)
6. **String Manipulation** - Advanced text manipulation
7. **Rainbow Brackets** - Colorize matching brackets
8. **GitToolBox** - Enhanced git integration
9. **Presentation Assistant** - Show shortcuts in presentations

### Theme Plugins
10. **Material Theme UI** - Multiple dark themes
11. **Atom Material Icons** - Better file icons
12. **Extra Icons** - More file type icons

---

## 11. Disable Conflicting IDE Features

To get a more "pure" vim experience:

### Disable IDE shortcuts that conflict with Vim
`File > Settings > Editor > Vim Emulation`

- Review the list of shortcuts
- Set conflicting ones to "Vim" mode
- Examples:
  - `Ctrl+C` → Vim (mapped to Esc in your config)
  - `Ctrl+V` → Vim (block visual mode)
  - `Ctrl+D` → Vim (half-page down)

### Disable Hints/Popups (if desired)
`File > Settings > Editor > Inlay Hints`

- Configure or disable parameter hints
- Configure or disable type hints

---

## 12. Keyboard Shortcuts Quick Reference

### File Navigation
| Neovim | Rider | Action |
|--------|-------|--------|
| `<leader>pf` | `<leader>pf` | Find files |
| `<C-p>` | `<C-p>` | Git files |
| `<leader>ps` | `<leader>ps` | Search in project |
| `<leader>pv` | `<leader>pv` | File explorer |

### LSP/Code Intelligence
| Neovim | Rider | Action |
|--------|-------|--------|
| `gd` | `gd` | Go to definition |
| `K` | `K` | Hover documentation |
| `<leader>vca` | `<leader>vca` | Code actions |
| `<leader>vrr` | `<leader>vrr` | Find references |
| `<leader>vrn` | `<leader>vrn` | Rename |
| `<leader>f` | `<leader>f` | Format code |
| `[d` / `]d` | `[d` / `]d` | Next/prev error |

### Git
| Neovim | Rider | Action |
|--------|-------|--------|
| (lazygit) | `<leader>gg` | Git commit window |
| - | `<leader>gb` | Git blame |
| - | `<leader>gl` | Git log |

### Window Management
| Neovim | Rider | Action |
|--------|-------|--------|
| `<leader>wq` | `<leader>wq` | Close window |
| `<C-h/j/k/l>` | `<C-h/j/k/l>` | Navigate splits |

### Editing
| Neovim | Rider | Action |
|--------|-------|--------|
| `<leader>y` | `<leader>y` | Yank to clipboard |
| `<leader>p` | `<leader>p` | Paste (no yank) |
| `<leader>d` | `<leader>d` | Delete (no yank) |
| Visual `J/K` | Visual `J/K` | Move lines up/down |

---

## 13. Workflow Tips

### Switching from Neovim to Rider

1. **Trust the IDE features:**
   - Rider's refactoring tools are more powerful than LSP
   - Use `Alt+Enter` for quick fixes (in addition to vim bindings)
   - Use `Ctrl+Shift+A` to discover actions

2. **Hybrid approach:**
   - Use vim keybindings for text editing and navigation
   - Use IDE features for complex refactoring
   - Use mouse when it's genuinely faster (debugging, etc.)

3. **Learn Rider-specific features:**
   - Debugger integration (`<leader>dd`)
   - Built-in database tools
   - Decompiler for viewing library source
   - Solution-wide analysis

4. **Customize further:**
   - Add your own keybindings to `.ideavimrc`
   - Export settings: `File > Manage IDE Settings > Export Settings`
   - Share settings across machines

---

## 14. Troubleshooting

### IdeaVim not working
- Ensure IdeaVim plugin is enabled: `File > Settings > Plugins`
- Reload config: `:source ~/.ideavimrc` in any editor

### Keybindings not working
- Check conflicts: `File > Settings > Editor > Vim Emulation`
- Test specific binding: `:map <leader>pf` in editor
- Check IDE keymap doesn't override

### Performance issues
- Disable unused plugins
- Exclude build directories from indexing
- Increase IDE memory: `Help > Change Memory Settings`

---

## 15. File Structure Summary

```
~/.dotfiles/
├── .ideavimrc          # IdeaVim configuration (this file)
├── RIDER_SETUP.md      # This setup guide
└── nvim/               # Your Neovim configuration
    ├── init.lua
    ├── lua/dlacasse/
    │   ├── remap.lua
    │   ├── set.lua
    │   └── packer.lua
    └── after/plugin/
```

---

## Further Customization

To add more keybindings or customize further, edit `~/.ideavimrc` and reload with `<leader><leader>`.

### Useful IdeaVim commands:
```vim
:actionlist           " List all available IDE actions
:map                  " Show all mappings
:source ~/.ideavimrc  " Reload configuration
```

### Finding action names:
1. Press `Ctrl+Shift+A` in Rider
2. Search for the action
3. Note the action name
4. Add to `.ideavimrc` as `:action ActionName`

---

## Resources

- [IdeaVim Documentation](https://github.com/JetBrains/ideavim)
- [JetBrains Plugins](https://plugins.jetbrains.com/)
- [Rider Documentation](https://www.jetbrains.com/rider/documentation/)

---

**Enjoy your Neovim-like experience in Rider! 🚀**
