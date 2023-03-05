# This script first sends a GET request to the JIRA REST API's search endpoint with the specified JQL query to retrieve a list of issues that match the query.
# The script then uses jq to extract the issue keys from the JSON response.

# Next, the script loops through each issue key and sends a POST request to the JIRA REST API's comment endpoint to add a comment to the issue. 
# The comment text is specified in the script as a variable.

# You can customize the script by replacing the placeholders with your own values, such as the JIRA URL, API token, JQL query, and comment text.

#!/bin/bash

# Set JIRA URL and API token
JIRA_URL="$1"
API_TOKEN="$2"

# Set JQL query
JQL_QUERY="YOUR_JQL_QUERY_HERE"

# Set comment text
COMMENT_TEXT="YOUR_COMMENT_TEXT_HERE"

# Encode JQL query for use in URL
ENCODED_JQL_QUERY=$(echo "$JQL_QUERY" | jq -R -s @uri)

# Get issue keys from JIRA using JQL query
ISSUE_KEYS=$(curl -s -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" "$JIRA_URL/rest/api/2/search?jql=$ENCODED_JQL_QUERY" | jq -r '.issues[].key')

# Loop through issue keys and add comment to each issue
for KEY in $ISSUE_KEYS
do
    # Set JSON payload with comment text
    COMMENT_JSON='{
        "body": "'"$COMMENT_TEXT"'"
    }'

    # Add comment to the issue
    curl -s -X POST -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" -H "Content-Type: application/json" "$JIRA_URL/rest/api/2/issue/$KEY/comment" -d "$COMMENT_JSON"
done
