-- MySQL 8.x - Generate bulk sample data for the last 36 months

-- Ensure users exist
INSERT IGNORE INTO tb_user (user_id, password, role) VALUES
('alice','pw','ADMIN'),
('bob','pw','USER'),
('charlie','pw','USER');

-- Generate 4 complaints per month: 대기, 진행, 완료 x2
WITH RECURSIVE months(n) AS (
  SELECT 0
  UNION ALL
  SELECT n + 1 FROM months WHERE n < 35
)
INSERT INTO tb_mnm (title, content, status, reg_user, reg_date, upd_date)
-- 대기 (5일)
SELECT 
  CONCAT('민원 ', DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m'), ' A') AS title,
  '내용' AS content,
  '대기' AS status,
  ELT((n % 3) + 1, 'alice','bob','charlie') AS reg_user,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 5 DAY) AS reg_date,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 5 DAY) AS upd_date
FROM months
UNION ALL
-- 진행 (10일)
SELECT 
  CONCAT('민원 ', DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m'), ' B') AS title,
  '내용' AS content,
  '진행' AS status,
  ELT(((n+1) % 3) + 1, 'alice','bob','charlie') AS reg_user,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 10 DAY) AS reg_date,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 10 DAY) AS upd_date
FROM months
UNION ALL
-- 완료 (8일 시작, 2~6일 소요)
SELECT 
  CONCAT('민원 ', DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m'), ' C') AS title,
  '내용' AS content,
  '완료' AS status,
  ELT(((n+2) % 3) + 1, 'alice','bob','charlie') AS reg_user,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 8 DAY) AS reg_date,
  DATE_ADD(
    DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 8 DAY),
    INTERVAL (2 + (n % 5)) DAY
  ) AS upd_date
FROM months
UNION ALL
-- 완료 (20일 시작, 3~9일 소요)
SELECT 
  CONCAT('민원 ', DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m'), ' D') AS title,
  '내용' AS content,
  '완료' AS status,
  ELT(((n+3) % 3) + 1, 'alice','bob','charlie') AS reg_user,
  DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 20 DAY) AS reg_date,
  DATE_ADD(
    DATE_ADD(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%Y-%m-01'), INTERVAL 20 DAY),
    INTERVAL (3 + (n % 7)) DAY
  ) AS upd_date
FROM months;


