FROM nginx:bookworm

RUN apt-get update && apt-get install -y curl git unzip && apt-get clean

# Install FVM
RUN curl -fsSL https://fvm.app/install.sh | bash

# Clone the app source code and set working directory
WORKDIR /app/

COPY . /app/

# Install Flutter version via FVM (defined in the app's .fvmrc file)
RUN fvm use -f

# Stage 2: Nginx server

EXPOSE 80

ENTRYPOINT [ "/app/start.sh" ]