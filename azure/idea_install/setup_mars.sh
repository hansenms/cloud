#!/bin/bash

package_list_file=$1

apt-get update
export DEBIAN_FRONTEND=noninteractive


apt-get install -y $(cat ${package_list_file})
