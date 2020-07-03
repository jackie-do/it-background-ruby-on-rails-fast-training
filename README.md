# Mô tả Project

Giáo trình dạy Ruby on Rails cho sinh viên IT trong 48h (24 buổi, mỗi buổi 2h). Mục tiêu để các bạn học có thể hiểu và sử dụng Ruby on Rails ở mức cơ bản.

> * **Huy Đỗ** - *Người tạo giáo trình* - [huydo91@outlook.com](mailto:huydo91@outlook.com)


## I. Nội dung giáo trình

**Cơ bản**

- [Buổi 1: Giới thiệu về Web App. Giới thiệu về Ruby on Rails có thể làm gì.](./Lessons/Basic/lesson_01/lesson.md)
- [Buổi 2: Học về HTML và CSS.](./Lessons/Basic/lesson_02/lesson.md)
- [Buổi 3: Nói về SCSS (SASS), giới thiệu về các CSS Framework phổ biến.](./Lessons/Basic/lesson_03/lesson.md)
- [Buổi 4: Học về Javascript.](./Lessons/Basic/lesson_04/lesson.md)
- [Buổi 5: Tiếp tục học về Javascript. Bài tập làm 1 trang web tĩnh.](./Lessons/Basic/lesson_05/lesson.md)
- [Buỏi 6: Giới thiệu về ngôn ngữ Ruby. Cài đặt Ruby bằng RVM. Giới thiệu về Gem và cách sử dụng.](./Lessons/Basic/lesson_06/lesson.md)
- [Buổi 7: Làm bài tập về Ruby.](./Lessons/Basic/lesson_07/lesson.md)
- [Buổi 8: Giới thiệu về Ruby on Rails framework. Mô hình MVC và API. Các thành phần quan trọng trong Rails](./Lessons/Basic/lesson_08/lesson.md)
- [Buổi 9: Giới thiệu module C - Controller trong MVC.](./Lessons/Basic/lesson_09/lesson.md)
- [Buổi 10: Giới thiệu module V - View trong MVC.](./Lessons/Basic/lesson_10/lesson.md)
- [Buổi 11: Giới thiệu module M - Model trong MVC.](./Lessons/Basic/lesson_11/lesson.md)
- [Buổi 12: Bài tập lớn.](./Lessons/Basic/lesson_12/lesson.md)


- [Buổi 13: Bắt đầu xây dựng trang web bán hàng (chưa có layout)](./Lessons/Basic/lesson_13/lesson.md)
- [Buổi 14: Cập nhật view cho trang web bán hàng với CSS, cấu trúc lại các Views](./Lessons/Basic/lesson_14/lesson.md)
- [Buổi 15: Tiếp tục cập nhật Views, thêm Javascript để xử lý các actions.](./Lessons/Basic/lesson_15/lesson.md)
- [Buổi 16: Hoàn thiện giao diện. Thêm chức năng đăng nhập/đăng ký sử dụng gem `devise`.](./Lessons/Basic/lesson_16/lesson.md)
- [Buổi 17: Thêm chức năng giỏ hàng.](./Lessons/Basic/lesson_17/lesson.md)
- [Buổi 18: Thêm chức năng tính tiền thành toán đơn hàng.](./Lessons/Basic/lesson_18/lesson.md)
- [Buổi 19: Hoàn thiện các chức năng website. Tạo phần quản lý site cho admin dùng gem `activeadmin`](./Lessons/Basic/lesson_19/lesson.md)
- [Buổi 20: Hoàn thiện chức năng site Admin.](./Lessons/Basic/lesson_20/lesson.md)

**Nâng cao**

- Buổi 1: Deploy dự án dùng gem `capistrano`
- Buổi 2: Giới thiệu về các module khác trong Rails: Action Mailer, Active Storage, Active Job, Action Cable.
- Buổi 3: Làm việc với Action Mailer cho viêc gửi email.
- Buổi 4: Làm việc việc với Active Storage để lưu trữ: ảnh, document ...
- Buổi 5: Giới thiệu về Active Job.
- Buổi 6: Giới thiệu về Action Cable.

## II. Yêu cầu khi học

1. Sử dụng máy chạy trên Linux(Ubuntu) hoặc MacOS.
2. Có kiến thức cơ bản về thuật toán và cách xử lý các kiểu dữ liệu phổ biến (integer, string, array ...).
3. Có kiến thức cơ bản về SQL.


## III. Cách đặt câu hỏi

1. Vào tab `Issues` trên github. Bấm vào nút `New issue`.
2. Đặt title theo cú pháp bên dưới.
```
[Số khoá học][question] - Câu hỏi
Vi du
[K000][question] - Câu hỏi

```
3. Viết nội dung cần hỏi theo cú pháp markdown trong tab `Write`. Xem lại ở tab `Preview`
4. Nhấn `Submit new issues` để hoàn tất.


## IV. Nộp bài tập

1. Đứng từ nhánh `master` checkout ra nhánh `exercies/<tên học viên>_<tên bài tập>`
    - Ví dụ: cho một bài tập `exercies/khoa_nguyen_lesson_1_exercise_01`
    - Ví dụ: cho tất cả bài tập của một bài học `exercies/khoa_nguyen_lesson_1_all_exercises`
2. Vào trong thư mục `Submit_Exercies`, Chọn thư mục bài tập tương ứng ví dụ `lesson_02`
3. Tạo thư mục con tương ứng với tên của bạn `Khoa_Nguyen`
4. Làm bài tập trong thư mục mới, sau khi làm xong commit lại.
5. Vào tab `Pull request`. Bấm vào nút `New Pull Request`. Tạo pull request cho nhánh của mình với tiêu đề theo format bên dưới
```
[Số khoá học][submit_exercies] - <Tên Học Viên> - <Tên bài tập>

Vi du
[K000][submit_exercies] - Khoa Nguyễn - Lesson 01 - Exercise 01

```
6. Nhấn `Create pull request` để hoàn tất.


## . Sách tham khảo

1. Tìm hiểu về HTML/CSS
    - [Sách HTML and CSS workshop](./Books/html_css_book/html-css-workshop-interactive-approach.pdf) - [Code Demo](./Books/html_css_book/code_demo.zip)
2. Tìm hiểu về Javascript
    - [Sách Javascript workshop](./Books/javascript/javascript-workshop-interactive-approach.pdf) - [Code Demo](./Books/javascript/code_demo.zip)
2. Tìm hiểu về Ruby
    - [Sách Ruby workshop](./Books/ruby/ruby-workshop-practical-development.pdf) - [Code Demo](./Books/ruby/code_demo.zip)
