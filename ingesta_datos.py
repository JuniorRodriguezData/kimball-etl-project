import pyodbc
from faker import Faker
import random

server = r'(localdb)\pruebaserver' 
database = 'demo_kimball'

conn_str = (
    f"Driver={{ODBC Driver 17 for SQL Server}};"
    f"Server={server};"
    f"Database={database};"
    f"Trusted_Connection=yes;"
)

fake = Faker()

try:
    print(f"Intentando conectar a: {server}...")
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    print("¡Conexión exitosa a SQL Server!")

    # 1. Generar y cargar 100 Clientes
    print("Cargando Dim_Cliente...")
    for i in range(1, 101):
        cursor.execute(
            "INSERT INTO Dim_Cliente (id_cliente, nombre, email, fecha_registro) VALUES (?, ?, ?, ?)",
            (i, fake.name(), fake.email(), fake.date_between(start_date='-2y', end_date='today'))
        )

    # 2. Generar y cargar 1000 Ventas
    print("Cargando Fact_Ventas...")
    for i in range(1, 1001):
        cursor.execute(
            "INSERT INTO Fact_Ventas (id_venta, id_cliente, cantidad, precio_unitario, fecha) VALUES (?, ?, ?, ?, ?)",
            (i, random.randint(1, 100), random.randint(1, 5), round(random.uniform(10.0, 500.0), 2), fake.date_this_year())
        )

    conn.commit()
    print("¡Datos cargados con éxito en la base de datos!")

except Exception as e:
    print(f"Error detectado: {e}")
    if 'conn' in locals():
        conn.rollback()
finally:
    if 'conn' in locals():
        conn.close()
        print("Conexión cerrada.")