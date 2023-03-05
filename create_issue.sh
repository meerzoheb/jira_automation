#!/bin/bash

# Set the JIRA URL, issue type, project key, and authentication token
JIRA_URL="https://your-jira-url.com/rest/api/2/issue/"
ISSUE_TYPE="Bug"
PROJECT_KEY="PROJ"
AUTH_TOKEN="your-jira-api-token"

# Parse the arguments
while getopts "s:d:t:p:" opt; do
  case $opt in
    s) SUMMARY="$OPTARG" ;;
    d) DESCRIPTION="$OPTARG" ;;
    t) ISSUE_TYPE="$OPTARG" ;;
    p) PROJECT_KEY="$OPTARG" ;;
    \?) echo "Invalid option -$OPTARG" >&2
        exit 1 ;;
    :) echo "Option -$OPTARG requires an argument" >&2
        exit 1 ;;
  esac
done

# Construct the JIRA issue data
JIRA_DATA=$(cat <<EOF
{
  "fields": {
    "summary": "$SUMMARY",
    "description": "$DESCRIPTION",
    "issuetype": {
      "name": "$ISSUE_TYPE"
    },
    "project": {
      "key": "$PROJECT_KEY"
    }
  }
}
EOF
)

# Create the JIRA issue
curl -s -u "$AUTH_TOKEN:x" \
     -X POST \
     --data "$JIRA_DATA" \
     -H "Content-Type: application/json" \
     "$JIRA_URL" > /dev/null

# Exit with the curl command's exit code
exit $?
