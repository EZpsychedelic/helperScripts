#!/bin/bash
# example ---- This doesn't actually output in the expected format.
sites=("www.google.com" "www.duckduckgo.com" "www.kljsdfhsdfh.is")

get_res () {
        GET -d -s "$@"
}

echo -e "Site:\t\t\tStatus"
for site in "${sites[@]}"; do

        status_code=$(get_res $site)

        status_code=${status_code:0:3}
        if [[ $status_code == "200" ]]; then
                printf "$site:\t\t\tOnline\n"
        fi

        if [[ $status_code == "500" ]]; then
                printf "$site:\t\t\tOffline\n"
        fi
done
