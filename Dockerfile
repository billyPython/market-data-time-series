# Build base
FROM rust:1 AS build

# Install packages
RUN apt-get update && apt-get install --no-install-recommends -y \
    libzmq3-dev

# Create new project
RUN USER=root cargo new mdts
WORKDIR /mdts

# Build and cache dependencies
COPY ./Cargo.* ./
RUN cargo build
# RUN cargo build --release
RUN rm -rfv ./src

# Build project
COPY ./src ./src
RUN rm -rfv ./target/debug/deps/main* ./target/release/deps/main*
RUN cargo build
# RUN cargo build --release

CMD cargo run

# # Final base
# FROM rust:1

# # Copy artifacts from build stage
# COPY --from=build /mdts/target/debug/main .
# # COPY --from=build /mdts/target/release/main .

# # Run project
# CMD ./main
