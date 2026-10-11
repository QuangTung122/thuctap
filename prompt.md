
Mục tiêu

Sau khi hoàn thành bài thực hành này, học viên có khả năng:

    Đánh giá tài nguyên (Evaluate Storage): Đo lường và so sánh kích thước của dữ liệu thực (Data Length) so với kích thước của cây chỉ mục (Index Length) trong hệ quản trị cơ sở dữ liệu.

    Đánh giá hiệu năng (Evaluate Performance): Phân tích được sự đánh đổi (Trade-off) giữa tốc độ Truy xuất (Read) và tốc độ Ghi/Cập nhật (Write).

    Tối ưu hóa (Optimize): Nhận diện và loại bỏ các Index vô giá trị dựa trên khái niệm "Độ phân giải dữ liệu" (Cardinality), từ đó giải phóng RAM và Disk Space cho máy chủ.

Mô tả

Bối cảnh dự án:

"QuickFeed" là một nền tảng mạng xã hội dạng vi blog (tương tự Twitter) đang phát triển nóng. Tháng trước, để giải quyết tình trạng ứng dụng tải bảng tin quá chậm, một lập trình viên tập sự đã quyết định tạo Index trên tất cả các cột của bảng Posts.

Hậu quả xảy ra ngay lập tức:

    Lỗi Timeout khi đăng bài: Người dùng phàn nàn rằng mỗi lần họ bấm nút "Đăng status" (lệnh INSERT), hệ thống quay vòng vòng mất 5-10 giây mới thành công.

    Cảnh báo hết dung lượng đĩa (Disk Full): Quản trị viên hệ thống (System Admin) hốt hoảng báo cáo rằng cơ sở dữ liệu phình to lên gấp 3 lần chỉ trong 1 tuần, dù lượng bài viết mới không tăng đột biến. Kiểm tra cho thấy dung lượng của Index đang lớn gấp đôi dung lượng của dữ liệu thực tế!

Vai trò trong dự án:

    Vai trò của bạn (Học viên): Database Administrator (DBA) - Người phải tiến hành "phẫu thuật cắt bỏ" những Index dư thừa, giải cứu hệ thống khỏi tình trạng kiệt quệ tài nguyên.

    Vai trò của Giảng viên: Tech Lead - Người sẽ yêu cầu bạn dùng lệnh kiểm tra hệ thống để chứng minh dung lượng ổ cứng đã được giải phóng sau khi bạn tối ưu.

    Vai trò của AI: Storage & Performance Profiler (Trợ lý phân tích tài nguyên).

Quy tắc sử dụng AI:

    Được dùng AI để tìm hiểu cách truy vấn bảng information_schema.TABLES để xem dung lượng tính bằng Megabyte (MB) của Data và Index.

    Được dùng AI để hiểu khái niệm Cardinality (Độ phân biệt dữ liệu) và tại sao tạo Index cho cột kiểu Boolean (chỉ có True/False) lại là vô nghĩa.

    Tuyệt đối không yêu cầu AI "viết luôn lệnh xóa toàn bộ Index của bảng này".

Hướng dẫn triển khai

Bước 1: Hình thành ý tưởng

    Thời gian: 15 phút.

    Nhiệm vụ của Học viên:

        Đọc đoạn Legacy SQL Script bên dưới.

        Chẩn đoán nguyên nhân gây chậm quá trình INSERT: Mỗi lần thêm 1 bài viết mới, MySQL phải thực hiện thêm bao nhiêu thao tác cập nhật cấu trúc cây B-Tree ngầm bên dưới?

        Xác định các Index "ngu ngốc" (Low Cardinality / Kích thước quá lớn): Ví dụ cột is_visible chỉ có 2 giá trị 0 và 1, cột content chứa văn bản dài dòng.

    Vai trò của AI (Đối tác Brainstorm):

        Gợi ý Prompt: "Trong MySQL, nếu tôi tạo Index trên một cột chứa văn bản dài (TEXT) và một cột kiểu BOOLEAN (0 và 1), thì điều này gây hại như thế nào đến bộ nhớ RAM, dung lượng Disk và bộ tối ưu hóa (Query Optimizer)?"

    Sản phẩm đầu ra: Báo cáo "Bắt bệnh" liệt kê danh sách các Index gây tốn tài nguyên và vô tác dụng trong việc tăng tốc tìm kiếm.

Đoạn mã nguồn mẫu để học viên thực hiện (Legacy SQL Script):

-- HỆ THỐNG QUICKFEED (LEGACY SCRIPT)
-- Vấn đề: Lạm dụng Index vô tội vạ gây sụp đổ tốc độ GHI (Write) và cạn kiệt ổ cứng.

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10), -- Chỉ chứa 3 giá trị: 'TEXT', 'IMAGE', 'VIDEO'
    is_visible BOOLEAN DEFAULT 1, -- Chỉ chứa 1 (Hiện) hoặc 0 (Ẩn)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================
-- THẢM HỌA OVER-INDEXING (Lập trình viên cũ đã chạy đoạn này)
-- ========================================================
CREATE INDEX idx_user_id ON Posts(user_id);
-- LỖI 1: Index cột TEXT gây phình to dung lượng ổ cứng khủng khiếp
CREATE INDEX idx_content ON Posts(content(255));
-- LỖI 2: Cardinality quá thấp (3 giá trị), MySQL Optimizer thường sẽ bỏ qua Index này
CREATE INDEX idx_post_type ON Posts(post_type);
-- LỖI 3: Cardinality cực thấp (2 giá trị), vô dụng và tốn chi phí bảo trì cây B-Tree
CREATE INDEX idx_is_visible ON Posts(is_visible);
CREATE INDEX idx_created_at ON Posts(created_at);

Bước 2: Thiết kế Giải pháp

    Thời gian: 10 phút.

    Nhiệm vụ của Học viên:

        Lập bảng quyết định (Decision Matrix) cho 5 Index hiện tại:

            idx_user_id: Giữ lại (Vì user_id có tính phân biệt cao, thường dùng để load trang cá nhân của 1 người).

            idx_content: Xóa (Tốn dung lượng, muốn tìm kiếm văn bản thì phải dùng Full-Text Search, không dùng B-Tree Index thường).

            idx_post_type: Xóa (Cardinality thấp).

            idx_is_visible: Xóa (Chỉ có 2 giá trị, quét toàn bảng đôi khi còn nhanh hơn dò Index).

            idx_created_at: Giữ lại (Cần thiết để load Newsfeed sắp xếp theo thời gian mới nhất).

    Vai trò của AI (Người phản biện logic):

        Gợi ý Prompt: "Tại sao khi tôi truy vấn SELECT * FROM Posts WHERE is_visible = 1 trên một bảng có hàng triệu dòng (trong đó 99% bài viết là visible = 1), MySQL lại quyết định quét toàn bảng (Full Table Scan) thay vì sử dụng Index idx_is_visible đã tạo?"

    Sản phẩm đầu ra: Kế hoạch Drop Index rõ ràng, đi kèm lý luận bảo vệ dựa trên khái niệm Cardinality và Storage overhead.

Bước 3: Triển khai

    Thời gian: 15 phút.

    Nhiệm vụ của Học viên:

        Viết câu lệnh SQL để xem thống kê dung lượng của bảng hiện tại (Dùng SHOW TABLE STATUS LIKE 'Posts';). Ghi nhận lại cột Index_length.

        Viết các lệnh ALTER TABLE Posts DROP INDEX <tên_index>; để loại bỏ 3 Index vô dụng đã phân tích ở Bước 2.

    Vai trò của AI (Mentor / Pair-Programming):

        Gợi ý Prompt: "Hãy cho tôi xem truy vấn SQL sử dụng bảng information_schema.TABLES để in ra kích thước Data và kích thước Index của bảng 'Posts' tính theo đơn vị Megabyte (MB)."

    Sản phẩm đầu ra: Script SQL quickfeed_index_optimization.sql chứa các lệnh dọn dẹp hệ thống.

Bước 4: Vận hành và Đối chiếu Hệ thống

    Thời gian: 10 phút.

    Nhiệm vụ của Học viên:

        Chạy toàn bộ Script dọn dẹp.

        Chạy lại câu lệnh SHOW TABLE STATUS LIKE 'Posts'; hoặc truy vấn từ information_schema.TABLES.

        Ghi nhận sự sụt giảm của cột Index_length (Trên hệ thống có dữ liệu thật, dung lượng này có thể giảm từ hàng Gigabyte xuống chỉ còn vài Megabyte).

        Viết một báo cáo ngắn gọn xác nhận việc cắt bỏ Index sẽ giúp thao tác INSERT bài viết mới giảm tải được 3 lần cập nhật cây B-Tree.

    Vai trò của AI (Tester):

        Gợi ý Prompt: "Nếu muốn tìm kiếm từ khóa bên trong cột content (kiểu TEXT) mà không bị tốn quá nhiều dung lượng như B-Tree Index, tôi nên sử dụng cơ chế nào của MySQL (Gợi ý: FULLTEXT Index)?"

    Sản phẩm đầu ra: Bảng log so sánh dung lượng lưu trữ trước và sau khi tối ưu.

Cơ chế đánh giá

Điểm bài thực hành (Thang 10) được đánh giá theo 3 tiêu chí:

1. Chất lượng Giải pháp Thực thi (40%):

   Xác định và DROP đúng 3 Index vi phạm (idx_content, idx_post_type, idx_is_visible).

   Giữ lại đúng các Index có giá trị cao (idx_user_id, idx_created_at).

   Chạy thành công câu lệnh truy vấn từ information_schema để chứng minh sự thay đổi về mặt Storage.
2. Bảo vệ Thiết kế - Vấn đáp (40%): Giảng viên (Tech Lead) sẽ hỏi:

   "Hãy giải thích chi tiết điều gì xảy ra ở tầng vật lý (ổ cứng) khi em chạy lệnh INSERT vào bảng có chứa 5 cái Index? Tại sao người dùng ứng dụng lại bị Timeout?"

   "Cardinality là gì? Tại sao cột Giới tính (Nam/Nữ) hoặc Trạng thái (Active/Inactive) lại là những ứng cử viên tồi tệ nhất để tạo Index B-Tree?"

   "Nếu bảng Posts này là một bảng lịch sử (Archive) chỉ lưu trữ dữ liệu cũ, không bao giờ có thao tác UPDATE hay DELETE, và hiếm khi INSERT, thì việc có nhiều Index có còn là một 'thảm họa' nữa không?"
3. Kỹ năng tương tác AI - Prompt Log (20%):

   Điểm tối đa khi học viên dùng AI để khám phá sâu về cấu trúc lưu trữ InnoDB và cách nó quản lý không gian của Data Pages so với Index Pages.

Hướng dẫn nộp bài:

Học viên đóng gói và nộp một file nén (.zip) bao gồm:

    quickfeed_index_optimization.sql: Chứa các lệnh truy vấn information_schema và lệnh DROP INDEX.

    storage_performance_report.md: Bản báo cáo dài khoảng 200 từ giải thích sự đánh đổi giữa Read và Write, kèm số liệu so sánh.

    ai_prompt_log.md: Nhật ký tra cứu khái niệm Cardinality và Storage với AI.
