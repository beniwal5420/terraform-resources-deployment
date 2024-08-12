#!/bin/bash
cd ./ansible
echo "------------------------------------"
echo "Running ansible playbook"
echo "------------------------------------"


ansible-playbook  --verbose n01656206-playbook.yaml

echo "------------------------------------"
echo "Completed ansible playbook"
echo "------------------------------------"
