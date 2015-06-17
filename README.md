# life-after-life
Proof of Concept of longevity of Lambda functions execution

Free Tier
---------

Normally the Lambda function lives until context.done() is called, or timeout parameter (up to 60 seconds) kicks in, whichever comes first. You are only billed for the actual execution time multiplied by the memory until the context.done(), then the billing is off, despite the fact that your code keeps running for hours. This is how it's working as of February 23rd, 2015.

Still, the messages you are printing to the console, ultimately going to CloudWatch logs, are billed normally. So take advantage of you CPU cycles, but do not boast about it ;-) .

Getting Started
---------------

Create a Lambda function from the AWS Console UI in the Ireland region. Name the function "life-after-life" (without quotes).

Change the default execution role of the fuction, you need to capability of the function to execute itself. Add the following Statement:


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

Change the sample event to Custom and change the key1 to a numerical value, e.g.

```
{
  "key1": 1,
  "key2": "value2",
  "key3": "value3"
}
```

Execute the function. The first invocation from the console will be terminated after 5 seconds, but the subsequent ones ... will keep running ... Nice thing: those CPU cycles are free of charge, you are only billed for the original 5 seconds, or whatever you specify.

**Important**
Make sure you stop the function after starting, otherise it will work indefinitely draining you quota.

One way to abort the function is to simply delete it using the attached delete-function.sh script.

One GUI-based way to to stop it is to change the handler name to something non existent, e.g. handler2. Open "Lamba" console:

https://eu-west-1.console.aws.amazon.com/lambda

Click your function name, select "Edit or test function". On the right nale open "Change function configuration and role" section and change hangler name from "index.handler" to "index.handler2". Save you changes.

** Warning **
After invalidating the handler name the Lambda platform will still try to execute the fuction three time, typically in 3 minutes intervals. Leave the invalid name for some period of time to make sure the fuction isn't restarted.

You can add the function again with the attached script create-function.sh, which is creating the function. However, it assumes that the necessary AWS role has already been created and must be specified on the command line.

Also, there is a function removal script delete-function.sh, which can additionally serve as an emergency break to stop the execution of Lambda.

AWS Forum
---------

Let's see what the Gurus have to say:

https://forums.aws.amazon.com/thread.jspa?threadID=172171

AWS Locuta Causa Finita
-----------------------

It turns out to be a fascinating story and not a bug at all, but a kind of expected behaviour:

https://aws.amazon.com/blogs/compute/container-reuse-in-lambda/
