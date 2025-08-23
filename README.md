 **Eco AI Agent** 🤖🌿

A Ballerina-powered Slack bot that provides personalized, AI-generated eco-friendly advice and carbon footprint insights directly within your Slack workspace.

🚀 **Features**

- Get instant eco-friendly tips via a simple Slack slash command (`/eco-advice`).
- Leverages OpenAI's powerful AI to generate context-aware, practical suggestions.
- Built with Ballerina for robust and efficient integration handling.

📋 **Prerequisites**

Before you begin, ensure you have the following:

1.  Ballerina Swan Lake: Install the [Ballerina](https://ballerina.io/downloads/) programming language.
2.  A Slack Workspace: where you have permission to install apps.
3.  An OpenAI Account to generate an API key.

 ⚙️ **Setup Instructions**

1. **Configure Your Slack App**

1.  Go to [api.slack.com/apps](https://api.slack.com/apps) and click **"Create New App"**.
2.  Choose **"From scratch"**, give your app a name (e.g., `Eco AI Agent`), and select your development workspace.
3.  In the left sidebar, navigate to **"Slash Commands"** and click **"Create New Command"**.
4.  Fill out the form as follows:
    - **Command:** `/eco-advice`
    - **Request URL:** `https://your-server-url.xyz/slack/eco-advice` (We will update this later after deployment. For local testing, you can use a tool like [ngrok](https://ngrok.com/).)
    - **Short Description:** `Get AI-powered eco-friendly advice`
    - **Usage Hint:** `[Ask your question, e.g., how to reduce plastic?]`
5.  Click **"Save"**.

 2. **Get Your OpenAI API Key**

1.  Go to [platform.openai.com/api-keys](https://platform.openai.com/api-keys).
2.  Sign in to your account.
3.  Click **"Create new secret key"**.
4.  Give it a name (e.g., `Slack-Eco-Bot`) and click **"Create secret key"**.
5.  **Copy the key immediately** and store it securely. You won't be able to see it again.

 3. **Install and Configure the Project**

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/DilaknaH/Eco-Ai-Agent.git
    cd Eco-Ai-Agent
    ```

2.  **Install dependencies:**
    ```bash
    bal install
    ```

3.  **Configure environment variables:**
    - Locate the `Config.toml` file in the project root.
    - Open it and fill in the credentials you obtained from the previous steps:

    ```toml
    # Config.toml
    # Slack App Credentials (from "Basic Information" -> "App Credentials")
    SLACK_VERIFICATION_TOKEN = "your_slack_verification_token_here"

    # OpenAI API Key
    OPENAI_API_KEY = "sk-your_openai_secret_key_here"
    ```
    *Replace the values in quotes with your actual tokens.*

 🏃‍♂️**Running the Project**

1.  **Run the Ballerina service:**
    ```bash
    bal run
    ```
    You should see output indicating the service has started on a port (e.g., `localhost:9090`).

2.  **Set up the Request URL for Slack:**
    - For local development, you need to expose your `localhost` server to the internet. The easiest way is to use **ngrok**.
    - Install ngrok and run:
      ```bash
      ngrok http 9090
      ```
    - Copy the forwarding URL provided by ngrok (e.g., `https://abc123.ngrok.io`).
    - Go back to your Slack App settings (**Slash Commands** -> **Edit** your `/eco-advice` command).
    - Paste the ngrok URL into the **"Request URL"** field and append the endpoint path: `https://abc123.ngrok.io/slack/eco-advice`
    - Click **"Save"**.

3.  **Install the App to Your Workspace:**
    - In your Slack App settings, go to **"Install App"** in the left sidebar.
    - Click **"Install to Workspace"** and authorize the app.

## 💡 Usage

Go to any channel or DM in your Slack workspace. Simply type the command:

