# Use the official Python 3.7 image as a parent image
FROM python:3.7-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter
RUN pip install --no-cache-dir jupyter pytest

# Expose the port Jupyter will run on
EXPOSE 8888

# Create a non-root user and switch to it
RUN useradd -m jupyter
USER jupyter

# Set the working directory to the user's home
WORKDIR /home/jupyter

# Start Jupyter notebook
CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]