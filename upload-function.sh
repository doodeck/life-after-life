#

zip -r tmp/index.zip *.js modules/ node_modules/ ; aws --profile lambda lambda upload-function --region eu-west-1 --function-name life-after-life --function-zip tmp/index.zip  --role 'arn:aws:iam::915133436062:role/lal_lambda_exec_role' --mode event --handler life-after-life.handler --runtime nodejs --timeout 15
