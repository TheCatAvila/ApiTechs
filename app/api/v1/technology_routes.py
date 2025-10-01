from fastapi import APIRouter
from app.schemas.technology_schema import TechTest  # 👈 importamos el schema

router = APIRouter()

@router.post("/test")
async def create_technology(test: TechTest):
    return {
        "message": "Tecnología recibida correctamente",
        "data": test.dict()
    }

# Endpoint GET de prueba para devolver datos
@router.get("/test-data")
async def get_test_data():
    # Simulamos datos que podrían venir de la base de datos
    sample_data = [
        {"name": "Python", "description": "Lenguaje de programación muy popular"},
        {"name": "FastAPI", "description": "Framework para APIs en Python"},
        {"name": "MySQL", "description": "Base de datos relacional"}
    ]
    return {
        "message": "Datos de prueba obtenidos correctamente",
        "data": sample_data
    }