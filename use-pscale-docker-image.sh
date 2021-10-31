echo Using pscale CLI from latest docker image ...
mkdir -p $HOME/.config/planetscale

function pscale {
    local tty="-t"
    local non_interactive=""
    # if first arg equals shell, we have to turn of pseudo-tty and set PSCALE_ALLOW_NONINTERACTIVE_SHELL=true
    if [ "$1" = "shell" ]; then
        tty=""
        non_interactive="-e PSCALE_ALLOW_NONINTERACTIVE_SHELL=true"
    fi
    
    docker run -e PLANETSCALE_SERVICE_TOKEN=$PLANETSCALE_SERVICE_TOKEN -e PLANETSCALE_SERVICE_TOKEN_NAME=$PLANETSCALE_SERVICE_TOKEN_NAME  -e HOME=/tmp -v $HOME/.config/planetscale:/tmp/.config/planetscale -e PSCALE_ALLOW_NONINTERACTIVE_SHELL=true --user $(id -u):$(id -g) --rm -i $tty -p 3306:3306/tcp planetscale/pscale:latest $@
}