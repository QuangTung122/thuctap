# Nhật ký tương tác AI

## Mục 1: Đo dung lượng bằng `information_schema.TABLES`

**Prompt đã dùng:**

> Trong MySQL, hãy viết truy vấn chỉ đọc dùng `information_schema.TABLES` để xem `DATA_LENGTH` và `INDEX_LENGTH` của bảng `Posts` trong database hiện tại, đổi sang MB.

**Tóm tắt kết quả:**

Sử dụng `DATA_LENGTH / 1024 / 1024` và `INDEX_LENGTH / 1024 / 1024`. Cần lọc cả `TABLE_SCHEMA = DATABASE()` và `TABLE_NAME = 'Posts'` để không lấy nhầm bảng cùng tên ở schema khác.

## Mục 2: Cardinality và index Boolean

**Prompt đã dùng:**

> Cardinality của index MySQL là gì? Vì sao cột Boolean chỉ có 0 và 1 thường là ứng viên kém cho B-Tree index, đặc biệt khi 99% dòng có cùng giá trị?

**Tóm tắt kết quả:**

Cardinality là số lượng giá trị khác nhau mà index phân biệt được. Cardinality càng thấp thì mỗi khóa trỏ tới càng nhiều dòng. Với dữ liệu mất cân bằng, optimizer có thể chọn full table scan vì đọc toàn bộ trang dữ liệu rẻ hơn đọc index rồi truy cập lại quá nhiều dòng.

## Mục 3: TEXT và chi phí ghi

**Prompt đã dùng:**

> Index prefix B-Tree trên cột `TEXT` dài ảnh hưởng thế nào đến storage, RAM và thao tác INSERT? Khi nào nên cân nhắc FULLTEXT?

**Tóm tắt kết quả:**

Prefix index vẫn tạo thêm các entry cho mọi dòng, làm tăng Index Pages, buffer pool và chi phí duy trì khi INSERT/UPDATE. Nó không thay thế tìm kiếm toàn văn. `FULLTEXT` là hướng cần đánh giá riêng khi yêu cầu là tìm từ khóa trong nội dung.

## Mục 4: Phản biện quyết định tối ưu

**Prompt đã dùng:**

> Với `Posts`, hãy lập ma trận quyết định giữ hoặc xóa từng index dựa trên cardinality, workload đọc/ghi và mục đích truy vấn; không viết lệnh xóa index thay tôi.

**Tóm tắt quyết định của học viên:**

- Giữ `idx_user_id`: phục vụ truy vấn bài viết theo người dùng.
- Xóa `idx_content`: B-Tree prefix không phù hợp cho full-text search và tốn storage.
- Xóa `idx_post_type`: chỉ có ba loại bài viết.
- Xóa `idx_is_visible`: chỉ có hai trạng thái, độ phân biệt thấp.
- Giữ `idx_created_at`: phục vụ newsfeed theo thời gian.

AI chỉ hỗ trợ phân tích khái niệm và truy vấn đo lường. Các lệnh `DROP INDEX` trong script được lựa chọn theo decision matrix của bài thực hành, không yêu cầu AI xóa toàn bộ index.
