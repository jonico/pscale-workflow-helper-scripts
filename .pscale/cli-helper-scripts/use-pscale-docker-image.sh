echo Using pscale CLI from latest docker image ...
mkdir -p $HOME/.config/planetscale

function pscale {
    local tty="-t"
    local non_interactive=""
    local command=""
    
    # if first arg equals shell, we have to turn off pseudo-tty and set PSCALE_ALLOW_NONINTERACTIVE_SHELL=true
    if [ "$1" = "shell" ]; then
        tty=""
        non_interactive="-e PSCALE_ALLOW_NONINTERACTIVE_SHELL=true"
    fi

    # if script is run in CI and it is not the auth command, we have to turn off pseudo-tty
    if [ -n "$CI" ] && [ "$1" != "auth" ]; then
        tty=""
    fi

    # if NO_DOCKER is set, we will use the natively installed commands
    if [ -n "$NO_DOCKER" ]; then
        command="pscale $@"
    else
        command="docker run -e PLANETSCALE_SERVICE_TOKEN=$PLANETSCALE_SERVICE_TOKEN -e PLANETSCALE_SERVICE_TOKEN_ID=$PLANETSCALE_SERVICE_TOKEN_ID -e PLANETSCALE_SERVICE_TOKEN_NAME=$PLANETSCALE_SERVICE_TOKEN_NAME -e HOME=/tmp -v $HOME/.config/planetscale:/tmp/.config/planetscale -e PSCALE_ALLOW_NONINTERACTIVE_SHELL=true --user $(id -u):$(id -g) --rm -i $tty planetscale/pscale:latest $@"
    fi

    # if command is auth and we are running in CI, we will use the script command to get a fake terminal
    if [ "$1" = "auth" ] && [ -n "$CI" ]; then
        echo "::notice ::Please visit the URL displayed in the line below in your browser to authenticate"
        command="script -q -f --return -c '$command' | perl -ne '\$| = 1; \$/ = \"\r\"; \$counter=0; while (<>) { \$url = \$1 if /(http.*)$/; print \"Please click on \" . \$url . \"\n\" if \$url && (\$counter++)%100==0; }'"
        eval $command
    else
        $command
    fi
    
}
