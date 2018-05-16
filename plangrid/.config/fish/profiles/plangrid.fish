
set -gx AWS_PROFILE 'plangrid'
set -gx PGW_DOCK_REG 723151894364.dkr.ecr.us-east-1.amazonaws.com/pgdevenv:dev_1.1 
set -gx PATH $PATH $GOPATH/bin

function docker_login
    eval (aws ecr get-login --no-include-email)
end

function refresh_pg_ina_dock
    docker pull $PGW_DOCK_REG
end

function psql_prod_read_slave --description "Connect to the production read slave"
    command ssh postgres-read-replica.dev.planfront.net -t 'sudo -u postgres psql' 
end
