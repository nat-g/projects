#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  BASH CONFIRGURATIONS AND ALIASES
#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Sections:
#  1.  Environment Configuration
#  2.  Efficient Terminal
#  3.  System Operations & File and Folder Management
#  4.  Searching
#  5.  Process Management
#  6.  Networking
#  7.  Web Development
#
#
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   1. ENVIRONMENT CONFIGURATION
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#   Change Prompt
#   --------------
    export PS1="\033[02;37m\]~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\033[02;36m\]\u@\033[02;31m\]\w\\$\[\033[00m\] "
    export PS2="continue => "
#   export PS1="\e[02;37m~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\e[02;36m\u@\e[$
#   export PS2="continue => "


#   Set Paths
#   ----------
    export PATH="$PATH:/usr/local/bin/"
    export PATH="/Users/natalia/anaconda2/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

#   Add color to terminal
#   ---------------------
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad


#   ~~~~~~~~~~~~~~~~~~~~~~
#   2. EFFICIENT TERMINAL 
#   ~~~~~~~~~~~~~~~~~~~~~~

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths


#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   3. SYSTEMS OPERATIONS & FILE AND FOLDER MANAGEMENT
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash

#   screensaverDesktop: Run a screensaver on the Desktop
alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


#   ~~~~~~~~~~~~~~
#   4. SEARCHING
#   ~~~~~~~~~~~~~~

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string

#   ~~~~~~~~~~~~~~~~~~~~~~
#   5. PROCESS MANAGEMENT
#   ~~~~~~~~~~~~~~~~~~~~~~

#   findPid: find out the pid of a specified process
#   ------------------------------------------------
    findPid () { lsof -t -c "$@" ; }      

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -------------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   --------------------------------------------------------------
#   http://www.macosxhints.com/article.php?story=20060816123853639
#   --------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ---------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ~~~~~~~~~~~~~~
#   6. NETWORKING
#   ~~~~~~~~~~~~~~

alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#netinfo - shows network information for your system
netinfo ()
{
echo "~~~~~~~~~~~~~~~~~~~ Network Information ~~~~~~~~~~~~~~~~~~~"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

#   ~~~~~~~~~~~~~~~~~~~
#   7. WEB DEVELOPMENT
#   ~~~~~~~~~~~~~~~~~~~

httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }






