# QuickFeed Index Optimization

Bài thực hành phân tích và tối ưu chỉ mục MySQL cho bảng `quickfeed_db.Posts`.

## Tệp nộp bài

- `quickfeed_index_optimization.sql`: đo `DATA_LENGTH`/`INDEX_LENGTH` trước và sau tối ưu, drop đúng ba index dư thừa và lưu log đối chiếu.
- `storage_performance_report.md`: phân tích cardinality, storage overhead và đánh đổi Read/Write.
- `ai_prompt_log.md`: nhật ký dùng AI để tìm hiểu `information_schema`, cardinality, B-Tree và FULLTEXT.

## Cách chạy

1. Chạy Legacy SQL Script trong đề bài để tạo `quickfeed_db.Posts` và năm index ban đầu.
2. Chạy toàn bộ `quickfeed_index_optimization.sql` bằng MySQL Workbench hoặc MySQL CLI.
3. Đọc kết quả `BEFORE`/`AFTER` và truy vấn đối chiếu cuối script.

Script giữ lại `idx_user_id` và `idx_created_at`, đồng thời loại bỏ `idx_content`, `idx_post_type` và `idx_is_visible`.
