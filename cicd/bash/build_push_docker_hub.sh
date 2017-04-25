#!/usr/bin/env bash

export model_dir=../dronze-core/data/dronze/rasa/$1

rm -rvf ./data/dronze/rasa/model_*
cp -rvf ../dronze-core/dronzecore .
cp -rvf ${model_dir} ./data/dronze/rasa

rm env.sh
cat << EOF > env.sh
#!/usr/bin/env bash

export statements_file="./data/dronze/rasa/dronze-taxonomy-new.json"
export log_level="WARNING"
export RASA_METADATA_DIR="./data/dronze/rasa/$1"

EOF

docker build -t dronze-agent .
docker tag dronze-agent:latest dronze/dronze-agent:latest
#docker push dronze/dronze-agent:latest

rm -rvf dronzecore