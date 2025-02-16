
# Running the Node.js App in Docker

Follow these steps to run the Node.js application using Docker:

1. **Build the Docker image:**

   Open a terminal and navigate to the directory containing the `Dockerfile`. Then run the following command to build the Docker image:

   ```sh
   docker build -t my-node-app .
   ```

2. **Run the Docker container:**

   After the image is built, run the container using the following command:

   ```sh
   docker run -p 3000:3000 my-node-app
   ```

   This will start the application and map port 3000 of the container to port 3000 on your host machine.

3. **Access the application:**

   Open your web browser and go to `http://localhost:3000` to access the running Node.js application.
