#!/bin/bash

# Replace with your own JIRA URL and API token
JIRA_URL="https://your-jira-url.com"
API_TOKEN="your-api-token"

# Replace with your own JQL query to identify the issues to delete
JQL_QUERY="project = YOUR_PROJECT_NAME AND status = Open"

# Get the IDs of the issues to delete
ISSUE_IDS=$(curl -s -H "Authorization: Basic $(echo -n your-email:your-api-token | base64)" "$JIRA_URL/rest/api/2/search?jql=$JQL_QUERY" | jq -r '.issues[].id')

# Loop through the issue IDs and delete each issue
for issue_id in $ISSUE_IDS
do
  echo "Deleting issue $issue_id"
  curl -s -X DELETE -H "Authorization: Basic $(echo -n your-email:your-api-token | base64)" "$JIRA_URL/rest/api/2/issue/$issue_id"
done
