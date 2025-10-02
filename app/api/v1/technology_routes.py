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
    
    from app.models.technologies import Technology
    tech = Technology()
    db_result = tech.test()
    if db_result:
        database_name = db_result['DATABASE()'] if db_result else 'Desconocida'
    else:
        database_name = 'Desconocida'

    sample_data = [
        {"name": "Python", "description": "Lenguaje de programación muy popular"},
        {"name": "FastAPI", "description": "Framework para APIs en Python"},
        {"name": "MySQL", "description": database_name}
    ]
    return {
        "message": "Datos de prueba obtenidos correctamente",
        "data": sample_data
    }