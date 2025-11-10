import streamlit as st
import requests

st.title("Code Base Genious")
st.subheader("An AI-Powered Code Documentation Generator")

# File uploader
uploaded_file = st.file_uploader("Upload your code file", type=['py', 'js', 'java'])

if uploaded_file:
    # Read file content
    content = uploaded_file.read().decode()
    
    # Display code
    st.code(content, language='python')
    
    # Generate documentation button
    if st.button("Generate Documentation"):
        with st.spinner("Analyzing code..."):
            # Call backend API
            response = requests.post(
                "http://localhost:8000/generate-docs",
                json={"code": content}
            )
            # Display results
            st.success("Documentation generated!")
            st.markdown(response.json()["documentation"])

