-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE students (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    last_name TEXT NOT NULL,
    first_mid_name TEXT NOT NULL,
    enrollment_date DATE NOT NULL
);
CREATE TABLE instructors (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    last_name TEXT NOT NULL,
    first_mid_name TEXT NOT NULL,
    hire_date DATE NOT NULL
);
CREATE TABLE office_assignments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    instructor_id UUID NOT NULL,
    "location" TEXT NOT NULL
);
CREATE INDEX office_assignments_instructor_id_index ON office_assignments (instructor_id);
ALTER TABLE office_assignments ADD CONSTRAINT office_assignments_ref_instructor_id FOREIGN KEY (instructor_id) REFERENCES instructors (id) ON DELETE NO ACTION;
