# リソースグループ名と作成する Custom Vision サービスの名前を引数から取得する
region="japaneast"
resourceGroup=$1
accountName=$2

# リソースグループを作成する
az group create \
    --name $resourceGroup \
    --location $region

# Azure Custom Vision のアカウント(トレーニング用)を作成する
endpoint=`az cognitiveservices account create \
    --name $accountName \
    --resource-group $resourceGroup \
    --location $region \
    --sku F0 \
    --kind CustomVision.Training \
    --yes \
    --query 'properties.endpoint' \
    --output tsv`

# 作成した Azure Custom Vision アカウントのキーを取得する
key=`az cognitiveservices account keys list \
    --name $accountName \
    --resource-group $resourceGroup \
    --query 'key1' \
    --output tsv`

# 作成した Azure Custom Vision アカウントへのアクセス情報をファイルに出力する
echo "{ \"endpoint\": \"$endpoint\", \"key\": \"$key\" }" > acv_config.json