
randomNumber=$(shuf -i 1-10000 -n1)
bucket="tfstate-bucket-umbrella-"$randomNumber
DynamoDBName="tfstate-dynamodb-umbrella-"$randomNumber
echo $bucket
echo $DynamoDBName