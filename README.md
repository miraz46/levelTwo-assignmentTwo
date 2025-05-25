


# 1. Explain the Primary Key and Foreign Key concepts in PostgreSQL.


 **প্রাইমারি কী** : প্রাইমারি কী হলো একটি টেবিলের প্রতিটি রেকর্ডকে অন্য রেকর্ড থেকে আলাদা করার জন্য একটি ইউনিক আইডেন্টিফায়ার।

বৈশিষ্ট্য:
- এর মান অবশ্যই ইউনিক (অনন্য) হতে হবে।
- কখনো NULL হতে পারে না।
- প্রতিটি টেবিলে শুধুমাত্র একটি Primary Key থাকতে পারে।
- এটি একটি অথবা একাধিক কলাম নিয়ে গঠিত হতে পারে।

```markdown
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name TEXT,
    age INT
);
```
এখানে student_id প্রতিটি শিক্ষার্থীকে ইউনিকভাবে শনাক্ত করছে।

**ফরেন কী** : ফরেন কী হলো এমন একটি কলাম বা কলামগুলোর সমষ্টি যা একটি টেবিলকে অন্য একটি টেবিলের সাথে সংযুক্ত করে।

বৈশিষ্ট্য:
- এর মান অবশ্যই ইউনিক (অনন্য) হতে হবে।
- কখনো NULL হতে পারে না।
- প্রতিটি টেবিলে শুধুমাত্র একটি Primary Key থাকতে পারে।
- এটি একটি অথবা একাধিক কলাম নিয়ে গঠিত হতে পারে।

```markdown
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```
এখানে:

- student_id একটি Foreign Key যা students টেবিলের student_id কে রেফারেন্স করছে।
- course_id একটি Foreign Key যা courses টেবিলের course_id কে রেফারেন্স করছে।


# 2. What is the difference between the VARCHAR and CHAR data types?

**VARCHAR(n)** :
- এটি সর্বোচ্চ n সংখ্যক অক্ষর সংরক্ষণ করতে পারে, তবে অক্ষরের সংখ্যা পরিবর্তনশীল হতে পারে।
- অতিরিক্ত কোনো ফাঁকা জায়গা (space) যোগ করা হয় না।
- যেসব তথ্যের দৈর্ঘ্য বিভিন্ন হতে পারে, যেমন নাম, ইমেইল, ঠিকানা—তাতে এটি ভালোভাবে কাজ করে।

```markdown
VARCHAR(10)
-- 'Hi' সংরক্ষিত হবে 'Hi' হিসেবেই
-- 'Hello' সংরক্ষিত হবে 'Hello'
```

**VARCHAR(n)** :
- এটি সর্বদা ঠিক n সংখ্যক অক্ষর সংরক্ষণ করে।
- যদি কম অক্ষরের কোনো string দেওয়া হয়, তবে ফাঁকা জায়গা (space) দিয়ে পূরণ করে নেয়।
- যেসব ডেটা সবসময় নির্দিষ্ট দৈর্ঘ্যের হয়, যেমন কোড বা শর্ট ফ্ল্যাগ, সেখানে এটি ভালোভাবে ব্যবহৃত হয়।

```markdown
CHAR(5)
-- 'Hi' সংরক্ষিত হবে 'Hi   ' (৩টি ফাঁকা জায়গাসহ)

```
# 2. Explain the purpose of the WHERE clause in a SELECT statement.

**ব্যাখ্যা** : WHERE ক্লজ এর ব্যবহার SELECT স্টেটমেন্টে খুবই গুরুত্বপূর্ণ, কারণ এটি ডেটাবেজ থেকে নির্দিষ্ট শর্ত অনুযায়ী তথ্য (rows) বের করতে সাহায্য করে।
যেমনঃ
```markdown
SELECT কলাম_নাম
FROM টেবিল_নাম
WHERE শর্ত;


```
উদাহরণ: 
```markdown

নির্দিষ্ট মান ফিল্টার করতে	WHERE age = 20
তুলনা করতে	WHERE salary > 50000
টেক্সট মিলাতে	WHERE name = 'Rahim'
আংশিক মিল খুঁজতে	WHERE name LIKE 'R%'
একাধিক শর্ত	WHERE age > 18 AND gender = 'Male'
```

# 3. What are the LIMIT and OFFSET clauses used for?
 **লিমিট** : লিমিট ব্যবহার করে আমরা বলতে পারি, কত গোটা রেকর্ড (row) দেখাতে চাই।

**অফসেট** : অফসেট ব্যবহার করে আমরা বলতে পারি, কতগুলো রেকর্ড বাদ দিয়ে তারপর দেখানো শুরু করতে চাই।

উদাহরণ: একটি students টেবিল আছে এবং আমরা শুধু প্রথম ৫ জন ছাত্রের তথ্য দেখতে চাই:
 
```markdown
SELECT * FROM students
LIMIT 5;
```
এটি প্রথম ৫টি রেকর্ড দেখাবে।

এখন যদি আমরা প্রথম ৫ জন বাদ দিয়ে পরবর্তী ৫ জন ছাত্রের তথ্য দেখতে চাই,
```markdown
SELECT * FROM students
OFFSET 5
LIMIT 5;
```
এটি ৬ নম্বর থেকে ১০ নম্বর পর্যন্ত রেকর্ড দেখাবে।

# 4. How can you modify data using UPDATE statements?
**ব্যাখ্যা** : UPDATE স্টেটমেন্ট ব্যবহার করে আমরা বিদ্যমান ডেটা পরিবর্তন বা আপডেট করতে পারি।

 **UPDATE এর গঠন (Syntax)** :
 ```markdown
UPDATE students
SET score = 95
WHERE id = 3;
```
এতে শুধু ওই ছাত্রের score আপডেট হবে।

# 5. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
**ব্যাখ্যা** : SQL ডেটাবেজে ডেটা সাধারণত বিভিন্ন টেবিলে ভাগ করা থাকে। JOIN ব্যবহার করে আমরা:
- বিভিন্ন টেবিলের সম্পর্কযুক্ত ডেটা একত্রে দেখতে পারি।
- রিপোর্ট তৈরি বা ডেটা বিশ্লেষণের কাজ সহজ করতে পারি।
- ডেটা রিডান্ডেন্সি (একই ডেটা বারবার লেখা) কমাতে পারি।
JOIN মূলত একটি টেবিলের কলামকে অন্য একটি টেবিলের মিল থাকা কলামের সাথে মিলিয়ে রেকর্ড তৈরি করে।

উদাহরণ: ধরি দুইটি টেবিল আছে,

students টেবিল: student_id, name

marks টেবিল: student_id, score

আমরা যদি প্রতিটি ছাত্রের নামসহ তার স্কোর দেখতে চাই, তাহলে JOIN করতে হবে।

 ```markdown
SELECT students.name, marks.score
FROM students
JOIN marks ON students.student_id = marks.student_id;
```
এখানে:
- JOIN দুটি টেবিলকে যুক্ত করছে
- ON students.student_id = marks.student_id এই শর্ত অনুযায়ী মিল করা হচ্ছে
