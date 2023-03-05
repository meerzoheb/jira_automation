#!/bin/bash

# Set variables
JIRA_URL="https://your-jira-url.com"
JIRA_API_TOKEN="your-jira-api-token"
ISSUE_KEY="your-issue-key"

# Send GET request to issue changelog endpoint using cURL
curl -sS -H "Authorization: Bearer $JIRA_API_TOKEN" \
     -H "Content-Type: application/json" \
     -X GET \
     "$JIRA_URL/rest/api/2/issue/$ISSUE_KEY?expand=changelog" \
     | jq '.changelog'