# ⚡ Dotfiles & Terminal Suite

Mi entorno de desarrollo en terminal personal: **Neovim (LazyVim)** + **Tmux** + herramientas TUI modernas (**Lazygit**, **Vi-SQL**, **Leaf**, **Lazydocker**).

Configurado para ser ultraligero, altamente estético y sin bloatware (cero servicios fantasma, cero motores de base de datos o Docker instalados por defecto).

---

## 🚀 Instalación en 1 Comando

En cualquier instalación limpia de **Debian**, **Ubuntu**, **Kali Linux** o máquina virtual:

```bash
git clone https://github.com/TU_USUARIO/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

El script se encarga de:
1. Instalar dependencias esenciales (`git`, `curl`, `build-essential`, `ripgrep`, `fd-find`, `fzf`, `tmux`).
2. Instalar **JetBrains Mono Nerd Font** para que los iconos de terminal se vean perfectos.
3. Instalar **Neovim v0.10+** y herramientas TUI (`lazygit`, `vi-sql`, `leaf`, `lazydocker`).
4. Enlazar tus configuraciones a `~/.config/nvim`, `~/.config/tmux` y `~/.tmux.conf`.
5. Descargar automáticamente todos los plugins de LazyVim.

---

## 🗂️ Estructura del Repositorio

```text
dotfiles/
├── install.sh             # Script instalador maestro y autónomo
├── tmux.conf              # Configuración de Tmux (~/.tmux.conf)
├── bin/                   # Scripts auxiliares para terminal y popups
│   ├── tmux-nota-rapida   # Popup flotante con Neovim (detección dinámica WSL/VM)
│   ├── tmux-scratch-terminal # Terminal flotante persistente
│   └── toggle-theme       # Alternador de tema claro/oscuro
└── config/
    ├── nvim/              # Configuración completa de LazyVim
    │   └── lua/plugins/   # Plugins personalizados (Markdown, Sqmeow/SQL, Obsidian, etc.)
    └── tmux/              # Temas para Tmux (dark, light, transparent)
```

---

## ⌨️ Atajos de Teclado Principales

### 🪟 Tmux (Prefix: `Ctrl + b`)
* `Prefix + n` ➔ **Nota Rápida:** Abre un popup flotante persistente con Neovim listo en tu bóveda de Obsidian (`~/Obsidian` en VM o en Windows si es WSL).
* `Prefix + t` ➔ **Terminal Flotante:** Terminal scratchpad persistente sobre el directorio actual.
* `Prefix + T` ➔ **Alternar Tema:** Cambia entre tema oscuro y tema claro en caliente.

### 📝 Neovim & Markdown
* `<leader>ml` ➔ **Abrir con Leaf:** Previsualiza el archivo Markdown actual en el lector TUI `leaf` a pantalla completa.
* `<leader>um` ➔ **Render Markdown:** Alterna el formateo enriquecido visual dentro del editor.
* `<leader>Dd` ➔ **Sqmeow / SQL:** Abre el gestor de base de datos interactivo conectado con `vi-sql`.
* `<leader>gg` ➔ **Lazygit:** Abre la interfaz TUI de control de versiones.
