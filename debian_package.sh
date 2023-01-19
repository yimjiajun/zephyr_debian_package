#!/bin/bash

package_name="eczephyr"
prj_package_dir_name="zephyr_debian_package"
prj_path="$(dirname $(readlink -f "$0"))"
commands=('create' 'install' 'uninstall')
cmd_sel=

function debian_pacakge_actions_select {
	local max_cmd_sup=${#commands[*]}
	local max_cmd_idx="$(echo $(($max_cmd_sup - 1)))"
	while [[ -z "${cmd_sel}" ]]; do
		cat <<-EOF >&1

			+----------------------
			 Debian package control
			+----------------------
		EOF
		for((i = 0; i < ${max_cmd_sup}; i++)); do
			printf "%2d | %s \n" "$i" "${commands[$i]}"
		done
		read -t 20 -p "Select action or 'q' to quit [0-${max_cmd_idx}|q] : "
		if [ ! -z $REPLY ]; then
			[[ ($REPLY =~ ^[0-9]+$) ]] && [ $REPLY -lt ${max_cmd_sup} ] &&\
				cmd_sel="${commands[$REPLY]}"

			[ $REPLY = 'q' ] &&\
				exit 0
		fi
	done

	return 0
}

function debian_pacakge_cmd_process {
	case "${cmd_sel}" in
		'create')
			dpkg -b "${prj_path}/${prj_package_dir_name}" "${prj_path}/${prj_package_dir_name}.deb"
			;;
		'install')
			[ ! -f "${prj_path}/${prj_package_dir_name}.deb" ] &&\
				$(echo -e "\033[1;31m'$1' selected command is unrecognized\033[0m" >&2;\
				exit 1)
			sudo dpkg -i "${prj_path}/${prj_package_dir_name}.deb"
			;;
		'uninstall')
			sudo dpkg -P "${package_name}"
			;;
		*)
			echo -e "\033[1;31m'$1' selected command is unrecognized\033[0m" >&2
			exit 1
			;;
	esac

	return
}

while (true); do
	debian_pacakge_actions_select; [ "$?" -gt 0 ] && exit 1
	debian_pacakge_cmd_process; [ "$?" -gt 0 ] && exit 1
	cmd_sel=
	sleep 0.5
done
