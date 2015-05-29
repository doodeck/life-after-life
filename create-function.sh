#

mkdir -p tmp
zip -r tmp/index.zip *.js modules/ node_modules/
# As of CLI 1.7 upload-function option has been discontinued. Use update-function-code instead
# aws --profile lambda lambda upload-function --region eu-west-1 \
#  --function-name life-after-life \
#  --function-zip tmp/index.zip  \
#  --role 'arn:aws:iam::915133436062:role/lal_lambda_exec_role' --mode event \
#  --handler life-after-life.handler --runtime nodejs --timeout 15
aws --profile lambda lambda create-function --region eu-west-1 \
  --function-name life-after-life \
  --runtime nodejs \
  --role 'arn:aws:iam::915133436062:role/lal_lambda_exec_role' \
  --handler 'index.handler' \
  --timeout 15 \
  --memory-size 128 \
  --zip-file fileb://tmp/index.zip
