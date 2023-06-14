--What grades are stored in the database?

SELECT * FROM Grade
--What emotions may be associated with a poem?

SELECT * FROM Emotion
--How many poems are in the database?

SELECT COUNT(*) FROM Poem

--Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP 76 * FROM Author ORDER BY [Name]

--Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 Author.*, Grade.Name
FROM Author
JOIN Grade ON Author.GradeId = Grade.Id
ORDER BY Author.Name

--Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 Author.*, Grade.Name AS GradeName, Gender.Name AS GenderName
FROM Author
JOIN Grade ON Author.GradeId = Grade.Id
JOIN Gender ON Author.GenderId = Gender.Id
ORDER BY Author.Name

--What is the total number of words in all poems in the database?

SELECT SUM(WordCount) FROM Poem

--Which poem has the fewest characters?

SELECT TOP 1 * FROM Poem ORDER BY WordCount

--How many authors are in the third grade?

SELECT * FROM Author JOIN Grade ON Author.GradeId = Grade.Id WHERE Grade.Name = '3rd Grade'

--How many total authors are in the first through third grades?

SELECT COUNT(*) FROM Author JOIN Grade ON Author.GradeId = Grade.Id WHERE Grade.Name = '3rd Grade'

--What is the total number of poems written by fourth graders?

SELECT COUNT(*) FROM Poem 
JOIN Author ON Poem.AuthorId = Author.Id
JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Name = '4th Grade'

--How many poems are there per grade?

SELECT Grade.Name, COUNT(*) FROM Poem
JOIN Author ON Poem.AuthorId = Author.Id
JOIN GRADE ON Author.GradeId = Grade.Id
GROUP BY Grade.Name

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)

SELECT Grade.Name, COUNT(Author.Id) FROM Author
JOIN Grade ON Author.GradeId = Grade.Id
GROUP BY Grade.Name
ORDER BY Grade.Name

--What is the title of the poem that has the most words?

SELECT Title FROM Poem WHERE WordCount = (SELECT MAX(WordCount) FROM Poem)

--Which author(s) have the most poems? (Remember authors can have the same name.)

SELECT TOP 1 Author.Name AS 'Author Name', COUNT(Poem.Id) AS 'Poem Count'
FROM Author
JOIN Poem ON Poem.AuthorId = Author.Id
GROUP BY Author.Name
ORDER BY COUNT(Poem.Id) DESC

--How many poems have an emotion of sadness?

SELECT COUNT(Poem.Id) AS '# of Sad Poems'
FROM Poem
JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
JOIN Emotion ON PoemEmotion.EmotionId = Emotion.Id
WHERE Emotion.Name = 'Sadness'

--How many poems are not associated with any emotion?

SELECT COUNT(Poem.Id) AS '# of Emotionless Poems'
FROM Poem
LEFT JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
WHERE PoemEmotion.PoemId IS NULL;

--Which emotion is associated with the least number of poems?

SELECT TOP 1 Emotion.Name, COUNT(Poem.Id) AS ' Least Associated Emotion'
FROM Poem
JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
JOIN Emotion ON  Emotion.Id  = PoemEmotion.EmotionId
GROUP BY Emotion.Name
ORDER BY COUNT(EmotionId)

--Which grade has the largest number of poems with an emotion of joy?

SELECT TOP 1 Grade.Name, COUNT(Poem.Id) AS '# of Joyous Poems'
FROM Grade
JOIN Author ON Grade.Id = Author.GradeId
JOIN Poem ON Author.Id = Poem.AuthorId
JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name = 'Joy'
GROUP BY Grade.Name
ORDER BY COUNT(Poem.Id) DESC

--Which gender has the least number of poems with an emotion of fear?

SELECT TOP 1 Gender.Name, COUNT(Poem.Id) AS 'Poem Count'
FROM Gender
JOIN Author ON Gender.Id = Author.GenderId
JOIN Poem ON Author.Id = Poem.AuthorId
JOIN PoemEmotion ON Poem.Id = PoemEmotion.PoemId
JOIN Emotion ON Emotion.Id = PoemEmotion.EmotionId
WHERE Emotion.Name = 'Fear'
GROUP BY Gender.Name
ORDER BY COUNT(Poem.Id) ASC