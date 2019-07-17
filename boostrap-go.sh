#!bin/shell


# Install Go
wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.12.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
rm -rf go1.12.6.linux-amd64.tar.gz

# Go vim
# https://github.com/fatih/vim-go
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

echo "let g:go_version_warning = 0" >> ~/.vimrc
