Things that aren't included in dotfiles:

# oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# vundle
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cd ~/.vim/bundle/vundle && git checkout -b v origin/v
vim # and run :BundleInstall

# vim thesaurus
zget http://www.gutenberg.org/dirs/etext02/mthes10.zip
mkdir ~/.vim && mv mthes10/mthesaur.txt ~/.vim
rm -fr mthes10

# rvm
bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
