Q1.新たに部署のテーブルを追加してください。

  CREATE TABLE departments (
  department_id INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL, 
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP , 
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
  );

Q2.peopleテーブルに新しいカラムを追加して、誰がどこ所属しているかがわかるようにしましょう。

  ALTER TABLE people 
  ADD COLUMN department_id INT unsigned 
  AFTER email;

Q3.departments、people、reportsテーブルにある条件を満たすようなレコードを挿入してください。

 【department】

  INSERT INTO departments 
  (name) 
  VALUES 
  ('営業'), 
  ('開発'), 
  ('経理'), 
  ('人事'), 
  ('情報システム');

  【people】

  INSERT INTO people 
  (name, email, department_id, age, gender) 
  VALUES 
  ('山田 太郎', 'taro.yamada@example.com', 1, 35, 1), 
  ('佐藤 花子', 'hanako.sato@example.com', 1, 29, 2), 
  ('鈴木 一郎', 'ichiro.suzuki@example.com', 1, 41, 1), 
  ('田中 美咲', 'misaki.tanaka@example.com', 2, 33, 2), 
  ('高橋 健', 'ken.takahashi@example.com', 2, 27, 1), 
  ('伊藤 結衣', 'yui.ito@example.com', 2, 30, 2), 
  ('渡辺 直樹', 'naoki.watanabe@example.com', 2, 38, 1), 
  ('中村 彩', 'aya.nakamura@example.com', 3, 25, 2), 
  ('小林 大輔', 'daisuke.kobayashi@example.com', 4, 36, 1), 
  ('加藤 さくら', 'sakura.kato@example.com', 5, 31, 2);

  【reports】

  INSERT INTO reports(person_id, content)VALUES 
  (1, '会議資料をたくさん作成しました。 '), 
  (2, '午前より顧客対応を実施し、午後には契約できました。'), 
  (3, '午前は会議に参加しました。お昼ご飯はオムライスを食べました。'), 
  (4, '設計書を修正しました。再度レビュー依頼しました。'), 
  (5, '不具合を修正しました。お客様も満足されました。'), 
  (6, '朝会で進捗を共有しました。ペース配分は良い感じです。'), 
  (7, 'マクドナルドのコードを記述しました。'), 
  (8, '本日は、調査を実施しましたが、想定通りの結果は得られませんでした。'), 
  (9, 'コードレビューを行いました。反応は上々でした。'), 
  (10, '月報の提出を完了しました。来月も期間内に提出します。');

  Q4.department_idのNULLを、条件に当てはまる値で埋めるためのクエリを作成してください。

  UPDATE people SET department_id = 2 
  WHERE department_id IS NULL;

Q5.年齢の降順で男性の名前と年齢を取得してください。

  SELECT name, age FROM people 
  WHERE gender = 1 ORDER BY age DESC;

Q6.テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明してください。

  このSQLクエリは、peopleテーブルの中から、department_idカラムの値が1のレコードを対象に、name, email, ageカラムの値を取得し、created_atカラムの値を基準に古い順に並べるものです。

Q7.20代の女性と40代の男性の名前一覧を取得してください。

  SELECT name FROM people 
  WHERE ((gender = 2 AND age BETWEEN 20 and 29) 
  OR (gender = 1 AND age BETWEEN 40 and 49));

Q8.営業部に所属する人だけを年齢の昇順で取得してください。

  SELECT age FROM people 
  WHERE department_id = 1 ORDER BY age ASC;

Q9.開発部に所属している女性の平均年齢を取得してください。

  SELECT AVG(age) AS average_age 
  FROM people 
  WHERE gender = 2 AND department_id = 2;

Q10.名前と部署名とその人が提出した日報の内容を同時に取得してください。（日報を提出していない人は含めない）

  SELECT p.name AS person_name, d.name AS department_name, r.content 
  FROM people AS p 
  INNER JOIN departments AS d ON p.department_id = d.department_id 
  INNER JOIN reports AS r ON p.person_id = r.person_id;

Q11.日報を一つも提出していない人の名前一覧を取得してください。
  SELECT p.name 
  FROM people AS p 
  LEFT JOIN reports AS r ON p.person_id = r.person_id 
  WHERE r.person_id IS NULL;
