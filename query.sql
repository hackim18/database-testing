-- Membuat database
CREATE DATABASE school_management;

-- Membuat tabel teachers
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL
);

-- Menambahkan data ke tabel teachers
INSERT INTO teachers (name, subject) VALUES 
('Pak Anton', 'Matematika'),
('Bu Dina', 'Bahasa Indonesia'),
('Pak Eko', 'Biologi');

-- Membuat tabel classes
CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

-- Menambahkan data ke tabel classes
INSERT INTO classes (name, teacher_id) VALUES 
('Kelas 10A', 1),
('Kelas 11B', 2),
('Kelas 12C', 3);

-- Membuat tabel students
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- Menambahkan data ke tabel students
INSERT INTO students (name, age, class_id) VALUES 
('Budi', 16, 1),
('Ani', 17, 2),
('Candra', 18, 3);


-- 1. Tampilkan daftar siswa beserta kelas dan guru yang mengajar kelas tersebut.
SELECT 
    s.id AS student_id,
    s.name AS student_name,
    s.age AS student_age,
    c.name AS class_name,
    t.name AS teacher_name,
    t.subject AS teacher_subject
FROM 
    students s
JOIN 
    classes c ON s.class_id = c.id
JOIN 
    teachers t ON c.teacher_id = t.id;
   

-- 2. Tampilkan daftar kelas yang diajar oleh guru yang sama.
SELECT 
    t.name AS teacher_name,
    COUNT(c.id) AS number_of_classes
FROM 
    teachers t
JOIN 
    classes c ON t.id = c.teacher_id
GROUP BY 
    t.id, t.name;

   
-- 3. buat query view untuk siswa, kelas, dan guru yang mengajar
CREATE VIEW student_class_teacher_view AS
SELECT 
    s.id AS student_id,
    s.name AS student_name,
    s.age AS student_age,
    c.name AS class_name,
    t.name AS teacher_name,
    t.subject AS teacher_subject
FROM 
    students s
JOIN 
    classes c ON s.class_id = c.id
JOIN 
    teachers t ON c.teacher_id = t.id;
SELECT * FROM student_class_teacher_view;

-- 4. buat query yang sama tapi menggunakan store_procedure
CREATE OR REPLACE FUNCTION get_student_class_teacher()
RETURNS TABLE (
    student_id INT,
    student_name VARCHAR,
    student_age INT,
    class_name VARCHAR,
    teacher_name VARCHAR,
    teacher_subject VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.id AS student_id,
        s.name AS student_name,
        s.age AS student_age,
        c.name AS class_name,
        t.name AS teacher_name,
        t.subject AS teacher_subject
    FROM 
        students s
    JOIN 
        classes c ON s.class_id = c.id
    JOIN 
        teachers t ON c.teacher_id = t.id;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM get_student_class_teacher();

-- 5. buat query input, yang akan memberikan warning error jika ada data yang sama pernah masuk
ALTER TABLE students
ADD CONSTRAINT unique_student UNIQUE (name, age);

INSERT INTO students (name, age, class_id)
VALUES ('Budi', 16, 1)
ON CONFLICT (name, age) 
DO NOTHING;