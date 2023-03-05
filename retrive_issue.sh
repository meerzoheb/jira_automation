# This script uses cURL to send a GET request to the JIRA REST API's search endpoint, with the JQL query specified in the URL. 
# The JQL query is first encoded using the jq utility's @uri function to ensure that it can be safely included in the URL. 
# The script then sends the request, passing in the JIRA URL and API token as arguments, and outputs the JSON response to the console.

# You can customize the script by replacing the placeholders with your own values, such as the JIRA URL, API token, and JQL query. 
# You can also modify the script to parse and process the response data as needed.

#!/bin/bash

# Set JIRA URL and API token
JIRA_URL="$1"
API_TOKEN="$2"

# Set JQL query
JQL_QUERY="YOUR_JQL_QUERY_HERE"

# Encode JQL query for use in URL
ENCODED_JQL_QUERY=$(echo "$JQL_QUERY" | jq -R -s @uri)

# Send GET request to JIRA REST API to retrieve issues based on JQL query
curl -s -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" "$JIRA_URL/rest/api/2/search?jql=$ENCODED_JQL_QUERY"
