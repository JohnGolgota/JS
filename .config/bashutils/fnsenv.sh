#!/bin/bash

env_file=.env

get_my_env() {
	if env_file_exists; then
		echo "env file exists"
		env_fh=$(open $env_file)
		while read -r line; do
			echo "$line"
			key=$(echo "$line" | cut -d '=' -f 1)
			value=$(echo "$line" | cut -d '=' -f 2)

			export $key=$value
		done < $env_fh
		close $env_fh
	else
		echo "env file not exists"
	fi
}

env_file_exists() {
	if [ -f "$env_file" ]; then
		return 0
	else
		return 1
	fi
}
echo $JS