# quicknote_ahk
Frictionless note taking with a global shortcut
---

# QuickNote

QuickNote is a frictionless note-taking tool designed for Windows users who want to capture thoughts instantly without any organizational overhead.

![image](https://github.com/user-attachments/assets/90712bb9-b092-4921-8fe4-1a02a3749a85)


## Features

- **Zero Friction**: Press Alt+Shift+V anywhere, type your note, click away. That's it.
- **Instant Access**: Window appears right at your cursor position
- **Persistent**: Your notes are automatically saved and persist between restarts
- **Distraction-Free**: No folders, no categories, no tags - just pure note-taking
- **Global Shortcut**: Access from anywhere in Windows
- **Memory Safe**: Automatically saves your content as you type

## Installation

1. Download [AutoHotkey](https://www.autohotkey.com/) if you don't have it installed
2. Download `quicknote.ahk` from this repository
3. Double-click the script to run it
4. (Optional) Put the script in your startup folder to run it automatically
   - Press `Win + R`
   - Type `shell:startup`
   - Copy or create a shortcut to `quicknote.ahk` in this folder

## Usage

1. Press `Alt + Shift + V` anywhere to open the note window
2. Type your notes
3. Click anywhere outside the window or press `Alt + Shift + V` again to close it
4. Your notes are automatically saved

That's it! No menus, no configuration, no complexity.

## Technical Details

QuickNote uses AutoHotkey to create a simple, persistent notepad that appears at your cursor position. Notes are automatically saved to `%AppData%\QuickNote\saved_note.txt`.

Here's the core script:

```autohotkey
#SingleInstance Force
#Persistent

global saveFile := A_AppData . "\QuickNote\saved_note.txt"
global savedText := ""
global isVisible := false

; Create save directory if it doesn't exist
FileCreateDir, %A_AppData%\QuickNote

; Load saved content on startup
FileRead, savedText, %saveFile%

!+v::
    if (isVisible) {
        Gui, QuickNote:Submit
        savedText := NoteEdit
        Gui, QuickNote:Hide
        isVisible := false
        FileDelete, %saveFile%
        FileAppend, %savedText%, %saveFile%
    } else {
        MouseGetPos, mouseX, mouseY
        Gui, QuickNote:New
        Gui, +AlwaysOnTop +ToolWindow
        Gui, Color, FFFFFF
        Gui, Margin, 5, 5
        Gui, Add, Edit, w400 h300 vNoteEdit, %savedText%
        Gui, Font, s10, Segoe UI
        Gui, Show, x%mouseX% y%mouseY%, QuickNote
        isVisible := true
        SetTimer, CheckFocus, 100
    }
    return
```

## Customization

You can easily customize QuickNote by modifying the script:

- Change the shortcut: Replace `!+v::` with your preferred [AutoHotkey key combination](https://www.autohotkey.com/docs/Hotkeys.htm)
- Adjust window size: Modify `w400 h300` in the GUI Add line
- Change font: Modify `s10, Segoe UI` in the Font line
- Change background color: Modify `FFFFFF` in the Color line

## Why QuickNote?

Most note-taking apps focus on organization, tags, and structure. QuickNote takes the opposite approach: it's a simple scratchpad that's always one keystroke away. Perfect for:

- Quick thoughts you don't want to forget
- Temporary clipboard content
- Draft messages
- Code snippets
- Todo items
- Any text you need to jot down quickly

## Contributing

Feel free to fork, submit PRs, or create issues if you have ideas for improvements!

## License

MIT License - feel free to use and modify as you like!
