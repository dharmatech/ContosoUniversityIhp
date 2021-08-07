-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE students (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    last_name TEXT NOT NULL,
    first_mid_name TEXT NOT NULL,
    enrollment_date DATE NOT NULL
);
