from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os

app = FastAPI(
    title="MoodFood AI Backend",
    description="Foundational backend for MoodFood AI restaurant recommendation app.",
    version="0.1.0"
)

# Root route to serve the SPA frontend index.html
@app.get("/")
async def read_root():
    return FileResponse(os.path.join("static", "index.html"))

# Mount static folder for app.js and styles.css
app.mount("/static", StaticFiles(directory="static"), name="static")
