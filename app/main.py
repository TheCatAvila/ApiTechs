from fastapi import FastAPI
from app.api.v1.technology_routes import router as technology_router

def create_app() -> FastAPI:
    app = FastAPI(
        title="Devle API",
        description="API para gestión de tecnologías en el proyecto Devle",
        version="1.0.0"
    )

    # Incluir rutas de tecnologías
    app.include_router(technology_router, prefix="/api/v1/technologies", tags=["Technologies"])

    return app

app = create_app()