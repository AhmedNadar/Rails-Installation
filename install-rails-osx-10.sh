set -e

echo "Installs Homebrew for installing other software"
/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
brew update

#echo "install GIT, wget, ack, imagemagick and any other mighty software tools for daily use"
#brew install git ack wget redis memcached libmemcached colordiff imagemagick nginx sqlite libxml2 libxslt readline v8 sphinx geoip lzo
printf "Ensuring that git is installed...\n"
  if command -v git
  then
    printf "Found git! Moving right along.\n"
  else
    printf "=> Installing Git (git command not found)"
    if curl -s -L -B https://rvm.io/install/git -o gitinstall
    then
      chmod +x "$PWD/gitinstall"
      sudo bash "$PWD/gitinstall"
      if [[ -f gitinstall ]]
      then
        rm -f gitinstall
      fi
    else
      printf "ERROR: There was an error while attempting to install git."
      exit 1
    fi
  fi
  
echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Install Ruby version[1.9.3-p194]"
rvm install 1.9.3-p194
rvm use 1.9.3-p194 --default

gem install bundler --no-rdoc --no-ri

echo "Install Rails"
gem install rails --no-rdoc --no-ri

echo "Install Heroku"
gem install heroku

echo -e "\n- - - - - -\n"
echo -e "Now we are going to print some information to check that everything is done:\n"

echo -n "Should be brew 0.8 or higher: brew "
brew -v
echo -n "Should be sqlite 3.7.3 or higher: sqlite "
sqlite3 --version
echo -n "Should be rvm 1.6.32 or higher: "
rvm --version | sed '/^.*$/N;s/\n//g' | cut -c 1-10
echo -n "Should be ruby 1.9.3-p194: "
ruby -v | cut -d " " -f 2
echo -n "Should be Rails 3.2.2 or higher: "
rails -v
echo -e "\n- - - - - -\n"

echo "If the versions match, everything is installed correctly. If the versions
don't match or errors are shown, something went wrong with the automated process
and we will help you do the installation the manual way at the event.

Congrats!"