from app.database.db_connection import Database

class Technology:
    def __init__(self, id: int = None, name: str = None):
        self.id = id
        self.name = name

    def get_all(self):
        """Obtiene todos los datos de la tecnología."""
        query = "SELECT * FROM technologies"
        
        with Database() as db:
            db.execute(query)
            tech_data = db.fetchall()
            return tech_data

    def test(self):
        """Método de prueba para verificar la base de datos."""
        query = "SELECT DATABASE();"
        with Database() as db:
            db.execute(query)
            result = db.fetchone()
            return result
