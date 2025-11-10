import:py from dotenv { load_dotenv }
import:py import os
# Load environment variables
load_dotenv();
# Access API key
api_key = os.getenv("OPENAI_API_KEY");