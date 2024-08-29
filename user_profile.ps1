$env:Path += ";C:\Users\Admin\AppData\Local\Programs\oh-my-posh\bin"
# Prompt
Import-Module posh-git
# Set-PoshPrompt Paradox
# Oh-my-posh
# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) "my.omp.json"
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Alias
Set-Alias cl clear
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep Select-String
Set-Alias tig "C:\Program Files\Git\usr\bin\tig.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"

Import-Module Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteCharOrExit
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key "Ctrl+k" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "Ctrl+j" -Function HistorySearchForward

# Use fzf for tab completion
Set-PSReadlineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function which($cmd) {
    Get-Command $cmd -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
}

# Use Ctrl-d to exit the shell
function DeleteCharOrExit {
    if ($null -eq $null) {
        [System.Management.Automation.PSToken]::Empty
    } else {
        [System.Management.Automation.PSToken]::Delete
    }
}

# Use Ctrl-k to quit the shell
# This is a workaround for the issue that Ctrl-c doesn't work in the powershell terminal
# stty intr \^k