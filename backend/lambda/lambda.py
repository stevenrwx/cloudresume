import json
import boto3

client = boto3.client('dynamodb')

def lambda_handler(event, context):

    Update = client.update_item(
        TableName='VistorCount',
        Key={"count_id": { "N" : "0" }},
        UpdateExpression='ADD vistor :incr',
        ExpressionAttributeValues={
            ':incr': {"N": "1"}
            },
        ReturnValues= "UPDATED_NEW",
        )
    response = client.get_item(
        TableName='VistorCount',
        Key={"count_id": { "N" : "0" }})

    return {
            'statusCode': 200,
            'body': response
            }
