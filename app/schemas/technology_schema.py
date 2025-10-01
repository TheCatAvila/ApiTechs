from pydantic import BaseModel

class TechTest(BaseModel):
    name: str
    description: str | None = None