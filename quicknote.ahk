#SingleInstance Force
#Persistent

; Définir le chemin du fichier de sauvegarde dans le dossier AppData
global saveFile := A_AppData . "\QuickNote\saved_note.txt"
global savedText := ""
global isVisible := false

; Créer le dossier de sauvegarde s'il n'existe pas
FileCreateDir, %A_AppData%\QuickNote

; Charger le contenu sauvegardé au démarrage
FileRead, savedText, %saveFile%

!+v::
    if (isVisible) {
        ; Si la fenêtre est visible, la cacher
        Gui, QuickNote:Submit
        savedText := NoteEdit
        Gui, QuickNote:Hide
        isVisible := false
        ; Sauvegarder dans le fichier
        FileDelete, %saveFile%
        FileAppend, %savedText%, %saveFile%
    } else {
        ; Si la fenêtre est cachée, l'afficher
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

CheckFocus:
    IfWinNotActive, QuickNote
    {
        SetTimer, CheckFocus, Off
        Gui, QuickNote:Submit
        savedText := NoteEdit
        Gui, QuickNote:Hide
        isVisible := false
        ; Sauvegarder dans le fichier
        FileDelete, %saveFile%
        FileAppend, %savedText%, %saveFile%
    }
    return

QuickNoteGuiEscape:
QuickNoteGuiClose:
    Gui, QuickNote:Submit
    savedText := NoteEdit
    Gui, QuickNote:Hide
    isVisible := false
    ; Sauvegarder dans le fichier
    FileDelete, %saveFile%
    FileAppend, %savedText%, %saveFile%
    return