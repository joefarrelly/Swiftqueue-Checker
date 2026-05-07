FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY swiftqueue_checker.py .

CMD ["python", "swiftqueue_checker.py"]
