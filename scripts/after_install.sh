#!/bin/bash


cd   /home/ubuntu/recipe_BE


echo ">>> pip install ----------------------"
pip install -r requirements.txt


echo ">>> remove template files ------------"
rm -rf appspec.yml requirements.txt


echo ">>> change owner to ubuntu -----------"
chown -R ubuntu /home/ubuntu/recipe_BE

echo ">>> set env --------------------------"
chmod +x /home/ubuntu/recipe_BE/scripts/env.sh
cd /home/ubuntu/recipe_BE/scripts
source ./env.sh

cd   /home/ubuntu/recipe_BE

flask db init
flask db migrate
flask db upgrade

echo ">>> start server ---------------------"
nohup flask run --host=0.0.0.0 > log.txt 2>&1 &
