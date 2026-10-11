-- QUICKFEED: INDEX OPTIMIZATION
-- Chay legacy script de tao quickfeed_db.Posts va 5 index truoc khi chay file nay.

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- Kiem tra hien trang va cardinality truoc khi toi uu.
ANALYZE TABLE Posts;
SHOW TABLE STATUS LIKE 'Posts';
SHOW INDEX FROM Posts;

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

-- Luu lai so lieu truoc toi uu de doi chieu trong cung mot lan chay.
CREATE TABLE IF NOT EXISTS storage_optimization_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    measured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    stage_name VARCHAR(20) NOT NULL,
    data_mb DECIMAL(14, 4) NOT NULL,
    index_mb DECIMAL(14, 4) NOT NULL,
    total_mb DECIMAL(14, 4) NOT NULL
);

INSERT INTO storage_optimization_log (stage_name, data_mb, index_mb, total_mb)
SELECT
    'BEFORE',
    DATA_LENGTH / 1024 / 1024,
    INDEX_LENGTH / 1024 / 1024,
    (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

-- Quyet dinh: giu idx_user_id va idx_created_at vi co gia tri cho loc theo
-- user va newsfeed theo thoi gian. Hai index nay khong bi drop.
-- Xoa index content vi B-Tree prefix khong phu hop cho tim kiem van ban dai.
ALTER TABLE Posts DROP INDEX idx_content;
-- Xoa index post_type vi chi co 3 gia tri (cardinality thap).
ALTER TABLE Posts DROP INDEX idx_post_type;
-- Xoa index is_visible vi chi co 2 gia tri va thuong loc phan lon bang ghi.
ALTER TABLE Posts DROP INDEX idx_is_visible;

-- Kiem tra lai sau khi drop 3 index.
ANALYZE TABLE Posts;
SHOW TABLE STATUS LIKE 'Posts';
SHOW INDEX FROM Posts;

SELECT
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 4) AS data_mb,
    ROUND(INDEX_LENGTH / 1024 / 1024, 4) AS index_mb,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 4) AS total_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

INSERT INTO storage_optimization_log (stage_name, data_mb, index_mb, total_mb)
SELECT
    'AFTER',
    DATA_LENGTH / 1024 / 1024,
    INDEX_LENGTH / 1024 / 1024,
    (DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Posts';

-- Bang doi chieu ket qua va phan tram thay doi cua Index Length.
SELECT
    before_log.data_mb AS data_before_mb,
    before_log.index_mb AS index_before_mb,
    after_log.data_mb AS data_after_mb,
    after_log.index_mb AS index_after_mb,
    ROUND(before_log.index_mb - after_log.index_mb, 4) AS index_reduced_mb,
    ROUND(
        (before_log.index_mb - after_log.index_mb)
        / NULLIF(before_log.index_mb, 0) * 100,
        2
    ) AS index_reduction_percent
FROM (
    SELECT data_mb, index_mb
    FROM storage_optimization_log
    WHERE stage_name = 'BEFORE'
    ORDER BY log_id DESC
    LIMIT 1
) AS before_log
CROSS JOIN (
    SELECT data_mb, index_mb
    FROM storage_optimization_log
    WHERE stage_name = 'AFTER'
    ORDER BY log_id DESC
    LIMIT 1
) AS after_log;

-- Neu can tim kiem noi dung, can danh gia FULLTEXT thay cho B-Tree prefix.
-- Vi du tham khao, khong tu dong tao trong bai toi uu nay:
-- ALTER TABLE Posts ADD FULLTEXT INDEX ft_posts_content (content);
