FROM python:3.7-slim-buster
WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    gcc \
    g++ \
    clang \
    llvm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for catboost compilation
ENV CC=gcc
ENV CXX=g++

# Install packages without catboost first
RUN pip install --no-cache-dir numpy pandas scikit-learn matplotlib seaborn xgboost dill Flask

# Try to install the rest
RUN pip install --no-cache-dir -r requirements.txt || echo "Some packages couldn't be installed"

CMD ["python3", "app.py"]

