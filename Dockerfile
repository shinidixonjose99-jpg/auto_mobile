FROM gcc:13 AS build

WORKDIR /app

RUN apt-get update && apt-get install -y cmake

COPY . .

RUN rm -rf build
RUN cmake -S . -B build
RUN cmake --build build

FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=build /app/build/cpp-demo-app .

RUN useradd -m appuser
USER appuser

CMD ["./cpp-demo-app"]