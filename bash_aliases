# general
alias med='~/Applications/medley-latest.AppImage &'
alias joplin='~/Applications/Joplin-1.0.114-x86_64.AppImage &'
alias ju='jupyter notebook'
alias ..='cd ../'
alias pgadmin4='pgadmin4 &'
alias no='fuck'
speak() { echo $@ | festival --tts; }


# python
alias py='python'
alias psbb='python setup.py --quiet build bdist_wheel; ls -A1 dist/'


# git
alias gs='git status'
alias gk='gitk --all &'
alias gc='git commit'
alias gf='git fetch --all --verbose; git fetch --tags --quiet'
alias gpt='git push --tags'
git_branch() {
    git checkout -b $1
    git push --set-upstream origin $1 --quiet
}


gb_purge() {
    git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`
    do git branch -D $branch
    done
}


# pip
alias pf='pip freeze'
alias hrpf='heroku run pip freeze'
alias pi='pip install --requirement requirements.txt --quiet'
alias p.='pip install . --quiet'
alias pip_uninstall_all='pip freeze | xargs pip uninstall -y'
pipdiff() {
    diff <(pip freeze) <(heroku run pip freeze --app $1)
}


# pytest
alias pycov='pytest --quiet --cov --cov-report term-missing'
alias hpycov='heroku local:run pycov'
alias hlrpst='heroku local:run python setup.py test'
alias pst='python setup.py test'


# heroku
alias lh='firefox localhost:5000'
alias hl='heroku local'
alias hlr='heroku local:run'
alias hrpm='heroku run python ./manage.py'
alias hlrpm='heroku local:run python ./manage.py'
alias show_migrations='heroku local:run python ./manage.py showmigrations'


# create a new virtual environment
mkvenv() {
    mkvirtualenv $1 --python=python3.6
    setvirtualenvproject
    echo Finished creating virtualenv $1
}

# recursively remove cache files/foldes from current directory
cache_purge() {
    remove_file_folder f .coverage $1
    remove_file_folder d __pycache__ $1
    remove_file_folder d .pytest_cache $1
    remove_file_folder d .eggs $1
    remove_file_folder d build $1
    remove_file_folder d dist $1
    remove_file_folder d *.egg-info $1
    echo Finished removing caches
}


# remove all files or folders with specified name then report how many removed
remove_file_folder() {
    count=0
    for file in $(find . -name $2 -type $1);
    do
        rm -rf $file $3
    let "count++"
    done

    if [ $count -gt 0 ]
    then
        echo "- Removed $count $2"
    fi
}


# print instructions to release a package and the related commands
release_package() {
    echo Steps to release a package:
    echo "  1. Tag commit on master (git tag -s <>)"
    echo "  2. Build binary distribution wheel (psbb)"
    echo "  3. Upload to yopy (twine_upload dist/<tab>)"
    echo "  4. Push tag to github (gpt)"
}
