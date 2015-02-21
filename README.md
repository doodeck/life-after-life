# life-after-life
Proof of Concept of longevity of Lambda functions execution

Getting Started
---------------

Create a Lambda function from the AWS Console UI in the Ireland region. Name the function "life-after-life" (without quotes).

Change the the default execution role of the fuction, you need to capability of the function to execute itself. Add the following Statement:


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

Increase the timeout of the function to more than 5 seconds, e.g. 15 seconds.

Copy/paste the content of the index.js file into the source code of the function.

Execute the function. The first invocation from the console will be terminated after 5 seconds, but the subsequent ones ... will keep running ... Nice thing: those CPU cycles are free of charge, you are only billed for the original 5 seconds, or whatever you specify.

AWS Forum
---------

Let's see what the Gurus have to say:

https://forums.aws.amazon.com/thread.jspa?threadID=172171
