# life-after-life
Proof of Concept of longevity of Lambda functions execution

Getting Started
---------------

Create a Lambda function from the AWS Console UI. Name the function "life-after-life" (without quotes).

Change the the default execution role of the fuction, you need to capability of the function to execute itself:


```
{
  "Effect": "Allow",
  "Action": [
     "lambda:InvokeFunction"
  ],
  "Resource": [
    "arn:aws:lambda:eu-west-1:<your_aws_account_id>:function:life-after-life"
  ]
}
```
