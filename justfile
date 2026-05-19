# tusd-custom
name := "tusd-custom"
remote := "r2d2@r2d2"
branch := `git rev-parse --abbrev-ref HEAD`
tag := replace(branch, "/", "-")
image := "ghcr.io/aerostacks/" + name

start_cmd := "echo 'no local run for tusd-custom'"
stop_cmd := "echo 'no local run for tusd-custom'"
lint_cmd := ""
needs_ssh_agent := "true"
build_cmd := "bash docker-build.sh " + branch
deploy_stop_cmd := "ssh " + remote + " \"cd ~/unified && docker compose -f docker-compose.data.yml stop tusd_missiondata\""
deploy_pull_cmd := "ssh " + remote + " \"docker pull " + image + ":" + tag + "\""
deploy_start_cmd := "ssh " + remote + " \"cd ~/unified && docker compose -f docker-compose.data.yml up -d tusd_missiondata\""
setup_extra_cmd := ""
format_cmd := ""

import '../common.just'
