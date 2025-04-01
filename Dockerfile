# Use the official Rust image as the base image
FROM rust:latest

# Set the working directory in the container
WORKDIR /usr/src/test-ci-rust

# Copy the entire project into the container
COPY . .

# Build the Rust project
RUN cargo build --release

# Expose the port (adjust as per your app)
EXPOSE 8080

# Run the built binary
CMD ["./target/release/test-ci-rust"]
