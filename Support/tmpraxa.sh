#!/usr/bin/env bash

export SAVEHIST=999999

[[ -f "${TM_SUPPORT_PATH}/lib/bash_init.sh" ]] && \
    . "${TM_SUPPORT_PATH}/lib/bash_init.sh"

# SO MANY PAAAATHS GUYS DO WE REALLY NEED *ALL* OF THESE REALLY
ORIGINAL_PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin"

export PATH="\
/usr/local/bin:\
/usr/local/sbin:\
/usr/local/opt/ruby/bin:\
/usr/local/tm2/bin:\
${ORIGINAL_PATH}:\
/usr/local/texlive/2014/bin/x86_64-darwin:\
${PATH}"

export NODE_PATH="\
/usr/local/share/npm/lib/node_modules:\
/usr/local/lib/node_modules:\
${NODE_PATH}"

export EDITOR='/usr/local/bin/emacs --no-window-system'
export JANGY_ROOT='/Users/fish/Dropbox/local-instance-packages/Django-1.4-alpha-17129'
export PGDATA="/usr/local/var/postgres/ost2"
export SOLR_SCHEMA="/Users/fish/Dropbox/local-instance-packages/apache-solr-4.2.0/example/solr/collection1/conf/schema.xml"

_BASE_PYTHONPATH=".:/usr/local/lib/python2.7/site-packages"
export OST_SHELL_SETTINGS="/Users/fish/Dropbox/ost2/ost2-shell-settings.py"
export OST_SETTINGS_MODULE='ost2.settings'
export OST_PROJECT='/Users/fish/Dropbox/ost2/ost2'
export OST_BASE_PYTHONPATH=".:\
/Users/fish/Dropbox/ost2:\
${OST_PROJECT}:\
${OST_PROJECT}/lib:\
/Users/fish/Dropbox/imagekit/django-imagekit-f2k:\
/Users/fish/Dropbox/django-delegate:\
/Users/fish/Dropbox/django-signalqueue:\
/Users/fish/Dropbox/django-dajaxice"

export OST_PYTHONPATH="${_BASE_PYTHONPATH}:${OST_BASE_PYTHONPATH}"
export JANGY_PROJECT=$OST_PROJECT
export JANGY_SHELL_SETTINGS=$OST_SHELL_SETTINGS
export PYTHONPATH=$OST_PYTHONPATH
export DJANGO_SETTINGS_MODULE=$OST_SETTINGS_MODULE
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
export PKG_CONFIG_PATH="/opt/X11/lib/pkgconfig:/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}"
export CLASSPATH="\
/usr/local/opt/libreadline-java/share/libreadline-java/libreadline-java.jar:\
${LIRESOLR_DIST}/lire-request-handler.jar:\
${LIRESOLR_LIBS}/lire.jar:\
${LIRESOLR_LIBS}/commons-codec-1.9.jar"

# end-run into Praxa's master environmentolizer
[[ -f "${WORKON_HOME}/env.sh" ]] && \
    . "${WORKON_HOME}/env.sh"

# END OF ROUND 1, AND NOW
# Some stray utility shit from my personal bash_profile,
# because fuck you for asking, that's why --
# oh wait you weren't even talking to me OK

function echopath () {
    echo "${1:-${PATH}}" | /usr/bin/sed -E 'y/:/\n/'
}

function checkpath () {
    IFS=':' read -a pathparts <<< "${1:-${PATH}}"
    echo "Checking path variable with ${#pathparts[@]} elements..."
    echo ""
    for pth in "${pathparts[@]}"; do
        ([ -d "$pth" ] || [ -f "$pth" ]) && echo "    + valid: ${pth}" || echo "    -  VOID: ${pth}"
    done
    echo ""
}

alias pathvars="python -c '\
from __future__ import print_function;import os;\
[print(var) for var in sorted(os.environ.keys()) if var.endswith(\"PATH\")]\
'"

yoyo() {
    dogg="${1:?File argument expected}"
    if [[ -r $dogg ]]; then
        echo "+ \`file -z\` results for ${dogg}"
        file -z $dogg | sed -e "s/empty \(.*\)/\1/"
        echo ""
        if [[ ! -d $dogg ]]; then
            echo "+ \`otool -L\` results for ${dogg}"
            otool -L $dogg
            echo ""
            echo "+ \`ls -lshF\` results for ${dogg}"
            /usr/local/bin/gls --color=auto -lshF ${dogg}
            echo ""
        fi
    else
        echo "yo: Can't read from ${dogg}"
    fi
}
