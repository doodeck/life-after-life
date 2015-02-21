console.log('Loading event');

var config = {
    functionName: "life-after-life",
    region: 'eu-west-1'
};
var AWS = require('aws-sdk');
AWS.config.update({region: config.region});

var lambda = new AWS.Lambda({});

exports.handler = function(event, context) {
    // start the long lasting "payload":
    var startingMoment = +new Date();
    var index = 0;
    setInterval(function() {
        var delta = +new Date() - startingMoment;
        console.log('index: ', index++, ' after ', delta / 1000 , ' seconds');
    }, (10 * 100));
    
    // wait for some period of time before telling AWS you are dome
    
    setTimeout(function() {
        var invokeSyncParams = {
          FunctionName: config.functionName,
          InvokeArgs: JSON.stringify({
              key1: event.key1 + 1
          })
        };
        console.log('Next gen: ', invokeSyncParams);           // successful response
        // params.ExpectedSeq++;
        lambda.invokeAsync(invokeSyncParams, function(err, data) {
            console.log('lambda.invokeAsync: ', err, data);
            console.log('value1 = ' + event.key1);
            context.done(null, 'Hello World');  // SUCCESS with message
        });
    }, 5000);
};