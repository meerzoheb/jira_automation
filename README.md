# JIRA Automation
This is a simple bash script that creates a JIRA issue on a specific project board using the JIRA REST API.

## Prerequisites
Before using this script, please make sure you have the following:

A JIRA instance with an API token that has permission to create issues on the target project board.
curl installed on your system. You can install it with your package manager, e.g., apt-get install curl on Ubuntu/Debian or brew install curl on macOS.
## Usage
To use the script, follow these steps:

Download the script to your computer or clone this repository.

Open the terminal and navigate to the directory where the script is located.

Make the script executable by running the following command:

```bash
chmod +x create-jira-issue.sh
```


Run the script and provide the required arguments:
```bash
./create-jira-issue.sh -s "SUMMARY" [-d "DESCRIPTION"] [-t "ISSUE_TYPE"] [-p "PROJECT_KEY"]
```

-s: The summary of the JIRA issue. This is a required argument.
-d: The description of the JIRA issue. This is an optional argument.
-t: The issue type of the JIRA issue. This is an optional argument, and it defaults to "Bug".
-p: The project key of the JIRA project. This is an optional argument, and it defaults to "PROJ".
For example, to create a JIRA issue with the summary "Fix a bug" and description "The login page is not working" on project board "PROJ", run the following command:
```bash
./create-jira-issue.sh -s "Fix a bug" -d "The login page is not working"
```

The script will create a JIRA issue with the given summary and description, using the specified issue type and project key. If successful, it will return a JSON response with the details of the created issue. If there's an error, the script will exit with an error message.