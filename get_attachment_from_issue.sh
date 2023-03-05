# This script sets the JIRA URL and API token, as well as the issue key and attachment ID.

# The script then sends a GET request to the JIRA REST API's attachments endpoint with the specified issue key and attachment ID. 
# The -o option is used to save the attachment to a file with the same name as the attachment ID.

# You can customize the script by replacing the placeholders with your own values, such as the JIRA URL, API token, issue key, and attachment ID.

#!/bin/bash

# Set JIRA URL and API token
JIRA_URL="$1"
API_TOKEN="$2"

# Set issue key and attachment ID
ISSUE_KEY="$3"
ATTACHMENT_ID="$4"

# Download attachment
curl -s -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" "$JIRA_URL/rest/api/2/issue/$ISSUE_KEY/attachments/$ATTACHMENT_ID" -o "$ATTACHMENT_ID"
