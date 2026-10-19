# Base image
FROM python:3.12-slim

# Working directory inside the container
WORKDIR /app

# Copy the application code into the image
COPY app/ /app/

# Build-time check: the application must compile
RUN python -m py_compile /app/app.py && echo "Build check passed"

# Default values (can be overridden with: docker run -e STUDENT_NAME=...)
ENV PYTHONUNBUFFERED=1 \
    STUDENT_NAME="Abylai" \
    STUDENT_SURNAME="Asan" \
    STUDENT_GROUP="IT2-2301" \
    STUDENT_ID="37804"

# Port used by the application (documentation)
EXPOSE 8080

# Command executed when the container starts
CMD ["python", "app.py"]
