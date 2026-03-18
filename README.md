# Salesforce Demo

A Salesforce DX project for demonstrating how to connect a Salesforce org in VS Code and push changes using the Salesforce CLI and MCP (Model Context Protocol).

## Prerequisites

Before getting started, make sure you have the following installed:

- [Salesforce CLI (`sf`)](https://developer.salesforce.com/tools/salesforcecli)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Salesforce Extension Pack for VS Code](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)
- A Salesforce org (Developer Edition, Sandbox, or Scratch Org)

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/krlojuarez/salesforce-demo.git
cd salesforce-demo
```

### 2. Open in VS Code

```bash
code .
```

VS Code will prompt you to install the **recommended extensions** (defined in `.vscode/extensions.json`). Accept the prompt to install the Salesforce Extension Pack.

### 3. Authorize Your Salesforce Org

Open the VS Code Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run:

```
SFDX: Authorize an Org
```

Or use the terminal:

```bash
# Authorize a Developer/Sandbox org
sf org login web --alias my-demo-org --set-default

# Authorize a scratch org (requires Dev Hub)
sf org login web --alias my-dev-hub --set-default-dev-hub
```

### 4. Verify the Connection

```bash
sf org display --target-org my-demo-org
```

---

## Project Structure

```
salesforce-demo/
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/
│           │   ├── AccountHelper.cls          # Sample Apex class
│           │   └── AccountHelperTest.cls      # Apex test class
│           └── lwc/
│               └── helloWorld/               # Sample Lightning Web Component
│                   ├── helloWorld.html
│                   ├── helloWorld.js
│                   └── helloWorld.js-meta.xml
├── .vscode/
│   ├── extensions.json   # Recommended VS Code extensions
│   ├── settings.json     # VS Code workspace settings
│   └── launch.json       # Apex Replay Debugger configuration
├── .forceignore          # Files excluded from SF CLI push/pull
├── .gitignore            # Files excluded from Git
├── sfdx-project.json     # Salesforce DX project configuration
└── README.md
```

---

## Pushing Changes to Your Org

### Deploy All Source

```bash
sf project deploy start --target-org my-demo-org
```

### Deploy a Specific File

```bash
sf project deploy start --source-file force-app/main/default/classes/AccountHelper.cls --target-org my-demo-org
```

### Pull Changes from Your Org

```bash
sf project retrieve start --target-org my-demo-org
```

---

## Running Apex Tests

```bash
sf apex run test --target-org my-demo-org --test-level RunLocalTests --output-dir test-results --result-format human
```

---

## Using MCP with GitHub Copilot

This project is set up to work with **GitHub Copilot** and the **Salesforce MCP server**, enabling AI-assisted Salesforce development directly in VS Code.

### Setup

1. Make sure [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) is installed and enabled in VS Code.
2. Use the **Copilot Chat** panel to ask questions about your Salesforce metadata, generate Apex code, or describe changes you want to push to your org.

### Example Prompts

- *"Create an Apex trigger on the Account object that sets the Description field when a new account is inserted."*
- *"Generate a Lightning Web Component that displays a list of open Opportunities."*
- *"Write an Apex test class for the AccountHelper class."*

After generating code with Copilot, deploy it to your org:

```bash
sf project deploy start --target-org my-demo-org
```

---

## Useful Salesforce CLI Commands

| Command | Description |
|---------|-------------|
| `sf org login web` | Authorize a Salesforce org |
| `sf org list` | List all authorized orgs |
| `sf org display` | Show details of the default org |
| `sf project deploy start` | Deploy source to org |
| `sf project retrieve start` | Retrieve source from org |
| `sf apex run test` | Run Apex tests |
| `sf apex run` | Execute anonymous Apex |
| `sf data query` | Run a SOQL query |

---

## Resources

- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/)
- [Salesforce CLI Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
- [Lightning Web Components Dev Guide](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)
- [Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/)
- [VS Code Salesforce Extension Pack](https://developer.salesforce.com/tools/vscode/)
