#!bin/bash

# NEDRTree
i=0
if [ ! -e ~/.vim ]; then
echo "mkdir ~/.vim"
mkdir ~/.vim
((i++))
else
echo "Already exists ~/.vim"
fi


if [ ! -d ~/.vim/autoload ]; then
echo "mkdir ~/.vim/autoload"
mkdir ~/.vim/autoload
((i++))
else
echo "Already exists ~/.vim/autoload"
fi

if [ ! -d ~/.vim/bundle ]; then
echo "mkdir ~/.vim/bundle"
mkdir ~/.vim/bundle
i = i+1
else
echo "Already exists ~/.vim/bundle"
fi


if [ ! -e ~/.vim/autoload/pathogen.vim ]; then
echo "mkdir ~/.vim/autoload/pathogen.vim"
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
((i++))
else
echo "Already exists ~/.vim/autoload/pathogen.vim"
fi

if [ ! -d ~/.vim/bundle/nerdtree ]; then
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
((i++))
else
echo "Already exists ~/.vim/bundle/nerdtree.git"
fi

if [ $i = 0 ]; then
echo "Maybe you already install NERDTree"
else
echo "execute pathogen#infect()
nnoremap <silent> <F5> :NERDTree<CR>
let NERDTreeShowHidden=1
" >> ~/.vimrc
fi

echo "Finished!"
