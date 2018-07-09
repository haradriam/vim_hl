# vim_hl

Vim HL plugin to be able to highlight regular expressions both for buffers (:HL) and windows (:HLW)

The idea behind the plugin is to easily highlight a set of regular expressions without worrying too
much for the color, without colliding with match 2match... and also friendly with the syntax of file 
types.

## usage

The usage is pretty simple (in command mode):

The plugin works both with buffers and with windows, when using the windows you can have different
highlight groups for the same buffer in different windows, but when switching buffers the highlight
will be maintained (even if the file type is not the same)

The command HL is for buffers and HLW is for windows, but they work exactly the same.

for buffers: 

```vi
" this will set a highlight on the index
:HL [0-7] <regexp>
" this will remove a given highlight
:HL [0-7]
" this will remove all the highlights
:HL
```

for windows (is the same but with HLW): 

```vi
" this will set a highlight on the index
:HLW [0-7] <regexp>
" this will remove a given highlight
:HLW [0-7]
" this will remove all the highlights from the window
:HLW
```

Colors (will make this configurable in the future):

|Number | Color |
|-------|-------|
|0 | Green  |
|1 | Red |
|2 | Cyan |
|3 | Purple |
|4 | Yellow |
|5 | Blue |
|6 | White |
|7 | Dark Gray |

### save buffer highlight

For now there is no window hightlight save option, but you can save the current
buffer's hightlight in a file that afterwards can be source'd.

```vi 
" first you save it
:HLSave "filename"

" then you can read it at any point
:source "filename"
```


## examples

```vi
" Highlight different things: the word "mikel", text starting with "TODO:"...
:HL 0 mikel
:HL 1 TODO:.*
:HL 2 rx:.*
:HL 3 tx:.*
" Highlight notes on the current window no matter the buffer
:HLW 0 NOTE:.*

" Remove highlight of the word mikel
:HL 0
" Remove all the highlights of the buffer (but the window still has the "NOTE:" one)
:HL
```

## installation

With vim-plug add this to your .vimrc:
```vi 
Plug 'mikelgarai/vim_hl'
```

For vim native package system, adding to the package vim_hl (you can decide any other package name):

```sh
$ mkdir -p ~/.vim/pack/vim_hl/start/
$ git clone https://github.com/mikelgarai/vim_hl.git ~/.vim/pack/vim_hl/start/vim_hl
```
## TODO

* Aside from window and buffer HL add a global HL (HLG or simply HL) for all the windows and buffers
* ~~Error messages when it is not correctly called~~
* Make :toHtml work with highlight.. or add this functionality by any other method.
* Add the option to automatically enumerate highlights with the first free slot
    * (or) Default highlight group "0" if none specified
* Save/Restore the current highlights to a file
  * ~~buffer hightlights~~
  * Add option to save window highlights
* Add more groups
* Allow configuration of the style of each group
* ¿ Temporary highlights ?
