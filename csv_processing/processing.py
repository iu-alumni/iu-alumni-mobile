import sqlite3
import csv
from pathlib import Path

def transform_csv_to_sqlite(csv_path, db_path):
    # Connect to SQLite database (will be created if it doesn't exist)
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    # Create regular table for cities
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS cities (
        city TEXT,
        lat REAL,
        lng REAL,
        country TEXT
    )
    ''')
    
    # Create FTS virtual table for fast text search
    cursor.execute('''
    CREATE VIRTUAL TABLE IF NOT EXISTS cities_fts 
    USING fts4(city, country, content='cities')
    ''')
    
    # Create triggers to keep FTS table in sync with the main table
    cursor.execute('''
    CREATE TRIGGER IF NOT EXISTS cities_ai AFTER INSERT ON cities
    BEGIN
        INSERT INTO cities_fts(rowid, city, country) VALUES (new.rowid, new.city, new.country);
    END;
    ''')
    
    cursor.execute('''
    CREATE TRIGGER IF NOT EXISTS cities_ad AFTER DELETE ON cities
    BEGIN
        INSERT INTO cities_fts(cities_fts, rowid, city, country) VALUES('delete', old.rowid, old.city, old.country);
    END;
    ''')
    
    cursor.execute('''
    CREATE TRIGGER IF NOT EXISTS cities_au AFTER UPDATE ON cities
    BEGIN
        INSERT INTO cities_fts(cities_fts, rowid, city, country) VALUES('delete', old.rowid, old.city, old.country);
        INSERT INTO cities_fts(rowid, city, country) VALUES (new.rowid, new.city, new.country);
    END;
    ''')
    
    # Read CSV and insert data
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            cursor.execute('''
            INSERT INTO cities (city, lat, lng, country)
            VALUES (?, ?, ?, ?)
            ''', (row['city'], float(row['lat']), float(row['lng']), row['country']))
    
    # Add Innopolis, Russia entry
    cursor.execute('''
    INSERT INTO cities (city, lat, lng, country)
    VALUES (?, ?, ?, ?)
    ''', ('Innopolis', 55.752117, 48.744552, 'Russia'))
    
    # Small optimization: create index for faster lookups
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_city_country ON cities(city, country)')
    
    # Commit changes and close connection
    conn.commit()
    conn.close()

if __name__ == '__main__':
    csv_file = 'worldcities.csv'
    db_file = 'world_cities.db'
    
    # Check if CSV file exists
    if not Path(csv_file).exists():
        print(f"Error: CSV file '{csv_file}' not found.")
        exit(1)
    
    # Transform the CSV to SQLite
    transform_csv_to_sqlite(csv_file, db_file)
    print(f"Successfully created SQLite database '{db_file}' from '{csv_file}'")