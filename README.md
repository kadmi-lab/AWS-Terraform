# AWS - Build an End-to-End AWS Web Application

1. Host web app via AWS Amplify with a name math-webapp
1.1. Start a manual deployment and choose a zip file index-ORIGINAL.html
1.2. Deploy

2. Create function via AWS Lambda with python
2.1. Add Source code math-webapp-Lambda-ORIGINAL.txt
2.2. Deploy
2.3. Configure test event and create new event math-webapp-testevent
2.4. Edit Event Json with the following(as an example):
{
  "base": 2,
  "exponent": 3
}
2.5. Run test and you should have response, so function is working:
{
  "statusCode": 200,
  "body": "\"Your result is 8.0\""
}

3. Invoke the math functionality via API Gateway
3.1. Create REST API with name math-webapp-api
3.2. Create method - POST (as we are going to send data)
3.3. Provide Lambda function and choose function:math-webapp-function
3.4. Enable CORS and mark POST in Access-Control-Allow-Methods
(Enable CORS configuring the function to handle requests from different origins,so we should be able to work across those domains or origins)
3.5. Deploy API with Stage "dev"
-Save API Gateway URL
3.6. Make a test call:
{
  "base": 2,
  "exponent": 3
}
if response is correct, its working 
{
  "statusCode": 200,
  "body": "\"Your result is 8.0\""
}

4. Store the math result via DynamoDB
Firstly need to give our Lambda function permission to write to the database
4.1. Create Table: math-webapp-dynamotable in DynamoDB with Partition key: ID
-Save Database ARN
4.2. Open Lambda math-webapp-function Permissions tab
4.3. Open Execution role and Add Permissions - Create inline Policy
4.4. Change to Policy editor JSON and replace code from file: 
Execution Role Policy JSON.txt
4.5. Update code "Resource" with your saved table ARN
4.6. Review and create policy - math-webapp-policy
4.7. Copy upgraded code to Lambda function from file math-webapp-Lambda-FINAL.txt
4.8. Deploy and Test
-Check in DynamoDB if result appeared clicking on "Explore table items"

5. Add a connector between Amplify and API Gateway
5.1. Edit index.html file and add to "YOUR API GATEWAY ENDPOINT" saved API Gateway URL
5.2. Redeploy new index.html zip file in AWS Amplify
