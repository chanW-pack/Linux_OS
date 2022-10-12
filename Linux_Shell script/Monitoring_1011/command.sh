#!/bin/bash

function nslookup() {

ansible all -i host -m command -a "nslookup www.google.com" -f 10
}

function route() {

ansible all -i host -m command -a "route" -f 10
}

function chrony() {

ansible all -i host -m command -a "chronyc sources -v" -f 10
