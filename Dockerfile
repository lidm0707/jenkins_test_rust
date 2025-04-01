FROM rust:latest AS builder

WORKDIR /usr/src/jenkins_test_rust

COPY . .

RUN cargo install --path .

FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libpq-dev \
    libc6 \ 
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/jenkins_test_rust /usr/local/bin/jenkins_test_rust

EXPOSE 8080

CMD ["jenkins_test_rust"]

# docker run -d --name server_new_rust --network my_network -p 8080:8080 -e TOKEN_SECRET=mysecrettoken  tranfer_transaction-rust-app