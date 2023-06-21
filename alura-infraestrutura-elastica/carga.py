from locust import FastHttpUser, task

class WebsiteUser(FastHttpUser):
    host = "http://localhost:8080"

    @task
    def index(self):
        self.client.get("/")