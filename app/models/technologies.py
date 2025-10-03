from app.database.db_connection import Database
import json

class Technology:
    def __init__(self, id: int = None, name: str = None):
        self.id = id
        self.name = name

    def get_all(self):
        """Obtiene todos los datos de la tecnología."""
        query = """SELECT 
                    t.id,
                    t.name,
                    t.release_year,
                    JSON_OBJECT('id', c.id, 'name', c.name) AS category,
                    JSON_OBJECT('id', ty.id, 'name', ty.name) AS type,
                    JSON_OBJECT('id', p.id, 'name', p.name) AS paradigm,
                    JSON_OBJECT('id', co.id, 'name', co.name) AS company,
                    JSON_OBJECT('id', l.id, 'name', l.name) AS license,
                    (
                        SELECT JSON_ARRAYAGG(
                                JSON_OBJECT('id', u.id, 'name', u.name)
                            )
                        FROM technology_uses tu
                        JOIN common_use u ON u.id = tu.use_id
                        WHERE tu.technology_id = t.id
                    ) AS uses,
                    (
                        SELECT JSON_ARRAYAGG(
                                JSON_OBJECT('id', t2.id, 'name', t2.name)
                            )
                        FROM influenced_by ib
                        JOIN technologies t2 ON t2.id = ib.influenced_by_id
                        WHERE ib.technology_id = t.id
                    ) AS influenced_by
                FROM technologies t
                LEFT JOIN category c ON t.category_id = c.id
                LEFT JOIN type ty ON t.type_id = ty.id
                LEFT JOIN paradigm p ON t.paradigm_id = p.id
                LEFT JOIN company co ON t.company_id = co.id
                LEFT JOIN license l ON t.license_id = l.id;
                """
        
        with Database() as db:
            db.execute(query)
            tech_data = db.fetchall()

            # Convertir strings JSON a objetos Python
            for row in tech_data:
                for key in ["category", "type", "paradigm", "company", "license", "uses", "influenced_by"]:
                    if row[key]:
                        try:
                            row[key] = json.loads(row[key])
                        except Exception:
                            # si ya viene como dict/list no hace nada
                            pass

            return tech_data
    
    def get_data_from_name(self):
        """Obtiene los datos de una tecnología por su nombre."""
        query = """SELECT 
                    t.id,
                    t.name,
                    t.release_year,
                    JSON_OBJECT('id', c.id, 'name', c.name) AS category,
                    JSON_OBJECT('id', ty.id, 'name', ty.name) AS type,
                    JSON_OBJECT('id', p.id, 'name', p.name) AS paradigm,
                    JSON_OBJECT('id', co.id, 'name', co.name) AS company,
                    JSON_OBJECT('id', l.id, 'name', l.name) AS license,
                    (
                        SELECT JSON_ARRAYAGG(
                                JSON_OBJECT('id', u.id, 'name', u.name)
                            )
                        FROM technology_uses tu
                        JOIN common_use u ON u.id = tu.use_id
                        WHERE tu.technology_id = t.id
                    ) AS uses
                FROM technologies t
                LEFT JOIN category c ON t.category_id = c.id
                LEFT JOIN type ty ON t.type_id = ty.id
                LEFT JOIN paradigm p ON t.paradigm_id = p.id
                LEFT JOIN company co ON t.company_id = co.id
                LEFT JOIN license l ON t.license_id = l.id
                WHERE t.name = %s;
        """
        with Database() as db:
            db.execute(query, (self.name,))
            result = db.fetchone()
            return result

    def test(self):
        """Método de prueba para verificar la base de datos."""
        query = "SELECT * FROM technologies;"
        with Database() as db:
            db.execute(query)
            result = db.fetchall()
            return result
