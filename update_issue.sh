# This script sends a PUT request to the JIRA REST API's issue endpoint, with the issue key or ID specified in the URL. 
# The script also includes a JSON payload with the updated issue details, such as the new summary and description. 
# The JIRA URL and API token are passed as arguments to the script.

# You can customize the script by replacing the placeholders with your own values, such as the JIRA URL, API token, issue key or ID, and updated issue details.

#!/bin/bash

# Set JIRA URL and API token
JIRA_URL="$1"
API_TOKEN="$2"

# Set the issue key or ID to update
ISSUE_ID="YOUR_ISSUE_KEY_OR_ID"

# Set JSON payload with the updated issue details
ISSUE_JSON='{
    "fields": {
        "summary": "Updated issue summary",
        "description": "Updated issue description"
    }
}'

# Update the issue
curl -s -X PUT -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" -H "Content-Type: application/json" "$JIRA_URL/rest/api/2/issue/$ISSUE_ID" -d "$ISSUE_JSON"
