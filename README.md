CodeBase Genius – Complete Guide
1. Introduction
AI-powered code documentation generator built with JacLang backend and Streamlit frontend. It allows you to map a code repository, analyze code structure and quality, and generate AI-powered documentation.
Features
- Repository mapping
- Code analysis (functions, classes, complexity)
- AI-generated documentation using OpenAI
- Beautiful UI with Streamlit
- Easy-to-use workflow: Upload code → Analyze → Generate docs
2. Prerequisites & Installation
Python 3.10+, JacLang, Streamlit, OpenAI account & API key
3. Project Structure

CodebaseGenius/
├── frontend/
│   └── app.py          # Streamlit UI
├── backend/
│   ├── RepoMapper.jac
│   ├── CodeAnalyzer.jac
│   ├── DocGenie.jac
│   └── main.jac        # Pipeline orchestrator
├── requirements.txt
├── .env
└── README.md

4. Backend Development with Jac
RepoMapper.jac

walker repo_mapper {
    has repo_path: str;
    has file_list: list = [];
    can map_repository(path: str) -> list {
        self.repo_path = path
        print("Mapping repository structure...")
        return self.file_list
    }
}

CodeAnalyzer.jac

walker coode_analyzer {
    has file_path: str;
    has analysis_results: dict = {};
    can analyze_code(file_info: dict) -> dict {
        content = file_info["content"]
        file_name = file_info["file_name"]
        loc = py:eval(f"len('''{content}'''.split('\n'))")
        result = {"file_name": file_name, "content": content, "lines_of_code": loc}
        print(f"Analyzed {file_name}")
        return result
    }
}

DocGenie.jac

walker doc_genie {
    has code_content: str = "";
    has api_key: str = "";
    has documentation: str = "";
    can load_api_key() -> str {
        self.api_key = py:eval("import os; from dotenv import load_dotenv; load_dotenv(); os.getenv('OPENAI_API_KEY')")
        return self.api_key
    }
    can generate_docs(code_content: str) -> str {
        self.code_content = code_content
        if self.api_key == "":
            self.load_api_key()
        result = py:exec(f'''
import openai
openai.api_key = "{self.api_key}"
response = openai.Completion.create(
    model="text-davinci-003",
    prompt="Generate documentation for this code:\n{self.code_content}",
    max_tokens=500
)
print(response.choices[0].text)
''')
        self.documentation = result
        return self.documentation
    }
}

5. Frontend Development with Streamlit

# frontend/app.py
import streamlit as st
import requests

st.title("CodeBase Genius")
st.subheader("AI-Powered Code Documentation Generator")

uploaded_file = st.file_uploader("Upload your code file", type=['py', 'js', 'java'])

if uploaded_file:
    content = uploaded_file.read().decode()
    st.code(content, language='python')

    if st.button("Generate Documentation"):
        with st.spinner("Analyzing code..."):
            response = requests.post(
                "http://localhost:8000/walker/run",
                json={"name": "TaskManager.run_pipeline", "ctx": {"path": "/tmp"}}
            )
            st.success("Documentation generated!")
            st.markdown(response.json().get("documentation", "No docs returned"))

6. Running the Application

1. Start backend:
cd backend
jac serve main.jac

2. Start frontend (new terminal):
cd frontend
source ../venv/bin/activate
streamlit run app.py

3. Open browser at http://localhost:8501

7. Best Practices
- Keep frontend and backend separate
- Always use a virtual environment
- Add .env and venv/ to .gitignore
- Never commit API keys
- Keep documentation updated
- Use descriptive file names and PascalCase for classes
8. Troubleshooting
- jac: command not found: Reinstall JacLang & ensure in PATH
- Port already in use: lsof -i :8000 → kill -9 <PID>
- Module not found: Activate virtual environment & reinstall requirements
- OpenAI API Error: Verify .env API key & account credits
9. Resources
- JacLang: https://docs.jac-lang.org
- Streamlit: https://docs.streamlit.io
- OpenAI API: https://platform.openai.com/docs
- Python venv: https://docs.python.org/3/tutorial/venv.html



