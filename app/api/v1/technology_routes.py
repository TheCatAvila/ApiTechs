from fastapi import APIRouter
from app.schemas.technology_schema import Tech
from app.models.technologies import Technology

router = APIRouter()

@router.post("/test")
def list_tech_by_id(test: Tech):

    name = test.name
    tech = Technology(name=name).get_data_from_name()

    return {
        "message": "Tecnología recibida correctamente",
        "data": tech
    }

@router.get("/")
def list_technologies():
    techs = Technology().get_all()
    return {
        "message": "Tecnologías obtenidas correctamente",
        "data": techs
    }