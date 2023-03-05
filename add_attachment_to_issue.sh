# This script first sets the JIRA URL and API token, as well as the issue key and path to the attachment file.

# Next, the script sets the boundary string for the multipart/form-data request and the Content-Type header. 
# It also sets the JSON payload with the attachment details and the Content-Disposition header for the attachment request.

# The script then combines the headers and payload into the request body using a heredoc. 
# It uses the file command to determine the MIME type of the attachment file.

# Finally, the script sends a POST request to the JIRA REST API's attachments endpoint with the specified issue key and request body to add the attachment to the issue.

# You can customize the script by replacing the placeholders with your own values, such as the JIRA URL, API token, issue key, and path to the attachment file.

#!/bin/bash

# Set JIRA URL and API token
JIRA_URL="$1"
API_TOKEN="$2"

# Set issue key and path to attachment file
ISSUE_KEY="$3"
FILE_PATH="$4"

# Set boundary string for multipart/form-data request
BOUNDARY="---------------------------$(date +%s)"

# Set Content-Type header for request
CONTENT_TYPE="Content-Type: multipart/form-data; boundary=$BOUNDARY"

# Set JSON payload with attachment details
ATTACHMENT_JSON='{
    "filename": "'$(basename "$FILE_PATH")'"
}'

# Set Content-Disposition header for attachment request
DISPOSITION="Content-Disposition: form-data; name=\"file\"; filename=\"$(basename "$FILE_PATH")\""

# Combine headers and payload into request body
BODY=$(cat <<EOF
--$BOUNDARY
$CONTENT_TYPE
$(echo "$ATTACHMENT_JSON" | jq -r '. | @sh "Content-Disposition: form-data; name=\"metadata\"; \(.key)=\(.value)"')
$DISPOSITION
Content-Type: $(file -b --mime-type "$FILE_PATH")

$(cat "$FILE_PATH")
--$BOUNDARY--
EOF
)

# Add attachment to the issue
curl -s -X POST -H "Authorization: Basic $(echo -n your-email:$API_TOKEN | base64)" -H "$CONTENT_TYPE" "$JIRA_URL/rest/api/2/issue/$ISSUE_KEY/attachments" -d "$BODY"
