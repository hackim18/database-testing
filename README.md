# database-testing

Berikut adalah contoh structure database dan data menggunakan SQL untuk studi kasus baru:

```
CREATE TABLE teachers ( id INT AUTO_INCREMENT, name VARCHAR(100), subject VARCHAR(50), PRIMARY KEY(id) );
INSERT INTO teachers (name, subject) VALUES ('Pak Anton', 'Matematika');
INSERT INTO teachers (name, subject) VALUES ('Bu Dina', 'Bahasa Indonesia');
INSERT INTO teachers (name, subject) VALUES ('Pak Eko', 'Biologi');
CREATE TABLE classes ( id INT AUTO_INCREMENT, name VARCHAR(50), teacher_id INT, PRIMARY KEY(id), FOREIGN KEY (teacher_id) REFERENCES teachers(id) );
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 10A', 1);
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 11B', 2);
INSERT INTO classes (name, teacher_id) VALUES ('Kelas 12C', 3);
CREATE TABLE students ( id INT AUTO_INCREMENT, name VARCHAR(100), age INT, class_id INT, PRIMARY KEY(id), FOREIGN KEY (class_id) REFERENCES classes(id) );
INSERT INTO students (name, age, class_id) VALUES ('Budi', 16, 1);
INSERT INTO students (name, age, class_id) VALUES ('Ani', 17, 2);
INSERT INTO students (name, age, class_id) VALUES ('Candra', 18, 3);
```

1. Tampilkan daftar siswa beserta kelas dan guru yang mengajar kelas tersebut.
2. Tampilkan daftar kelas yang diajar oleh guru yang sama.
3. buat query view untuk siswa, kelas, dan guru yang mengajar
4. buat query yang sama tapi menggunakan store_procedure
5. buat query input, yang akan memberikan warning error jika ada data yang sama pernah masuk

semua query dikumpulkan pada git melalui github/gitlab kalian
