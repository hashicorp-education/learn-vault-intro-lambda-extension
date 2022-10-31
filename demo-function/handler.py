import json
import os

def lambda_handler(event, context):
    # the location of secret
    secret_file = os.environ['VAULT_SECRET_FILE']
    f = open(secret_file, "r")

    # put the json object into a python dictionary
    dct = json.loads(f.read())
    
    # print off your API Key
    print("API Key: ", dct["data"]["data"]["api-key"])