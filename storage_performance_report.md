# Báo cáo tối ưu chỉ mục QuickFeed

## Chẩn đoán

Bảng `Posts` ban đầu có năm index. `idx_user_id` hỗ trợ tải bài viết theo từng người dùng và `idx_created_at` hỗ trợ sắp xếp newsfeed theo thời gian, nên được giữ lại. Ngược lại, `idx_content` là B-Tree prefix trên cột `TEXT`: nó chiếm thêm dung lượng nhưng không phải cơ chế phù hợp để tìm kiếm toàn văn. `idx_post_type` chỉ có ba giá trị và `idx_is_visible` chỉ có hai giá trị, nên có cardinality thấp. Khi phần lớn bản ghi có cùng giá trị, quét bảng có thể rẻ hơn việc đọc index rồi quay lại các trang dữ liệu.

## Thực thi và đối chiếu

`quickfeed_index_optimization.sql` ghi nhận `DATA_LENGTH` và `INDEX_LENGTH` trước và sau tối ưu bằng `information_schema.TABLES`, đồng thời lưu kết quả vào `storage_optimization_log`. Script drop đúng ba index dư thừa: `idx_content`, `idx_post_type` và `idx_is_visible`. Kết quả thực tế cần được lấy từ hai dòng `BEFORE` và `AFTER` sau khi chạy trên dữ liệu QuickFeed; không tự bịa số liệu khi bảng chưa có dữ liệu thật.

## Đánh đổi hiệu năng

Mỗi lần `INSERT`, MySQL không chỉ ghi một bản ghi vào bảng mà còn phải chèn khóa vào từng B-Tree, có thể gây page split, ghi thêm dữ liệu và tranh chấp I/O. Bỏ ba index giúp giảm ba lần cập nhật cấu trúc index trên mỗi bài viết, giảm chi phí ghi và giải phóng Index Pages/RAM. Đổi lại, các truy vấn lọc theo `post_type`, `is_visible` hoặc tìm `content` có thể phải quét nhiều dòng; đây là lựa chọn hợp lý vì các index đó có độ phân biệt thấp hoặc sai loại truy vấn. Nếu cần tìm từ khóa, nên đánh giá `FULLTEXT` riêng.
