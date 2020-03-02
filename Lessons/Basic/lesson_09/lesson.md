# Buổi 9: Giới thiệu module C - Controller trong MVC

## Nội dung cần học
 - Cấu trúc của Controller
 - Cấu hình cho Router
 - Bài tập

-----

### I. Cấu trúc của Controllers
  1. #### Controller có tác dụng gì?
      - Khi một request của người dùng đến Rail app, thì nó sẽ được Router điều hướng đến một `controller` và được xử lý bởi một `action` phù hợp. Trong action đó thì dựa trên thông tin trong request mà ta sẽ có logic và tạo ra output trả về phù hợp.
  2. #### Cấu trúc Controller
      - **`Naming Convention`**  Khi một controller được tạo mới, ta sẽ đặt tên class controller thế nào và đặt tên file của controller đó thế nào?
      - **`Action`** trong controller là gì? Về cơ bản một controller chỉ là một Ruby class được kế thừa từ class `ApplicationController`. Trong một class có rất nhiều public methods, nếu một public method được cấu hình (trong file `route.rb`) để Router trỏ đến, thì method này được xem là action.
      - **`Filters`** "before", "after", "around"
      - **`Parameters`**
        - Làm thế nào để client gửi thông tin lên Rails app?
        - Các thông tin này được chứa ở đâu trong 1 HTTP request?
        - Rails nhận các thông tin này ở đâu?
        - Có các dạng data nào có thể truyền trong một HTTP request?
      - **`Strong Parameters`** được sử dụng để lọc các parameters không được cho phép, chỉ xử lý một số paramaters nhất định.
      - **`Request and Response`** mọi controllers có 2 methods `request` and `response` chứa thông tin request từ client và response trả về tại thời điểm đó. [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_controller_overview.html#the-request-and-response-objects)
      - **`Sessions`**
        - Có bao nhiêu loại Session trong Rails?
        - `Flash` là gì?
      - **`Cookies`**


### II. Cấu hình cho Router

### III. Bài tập
  1. Tạo Rails app với controller đầu tiên. [(Tham khảo)](./exercises/01)
      - Tạo controller đầu tiên
      ```bash
      rails new first_controller
      cd first_controller

      # Tạo controller đầu tiên với name là Example và action là test
      rails generate controller Example test

      #
      rails s
      ```
      - Kiểm tra lại một số file tự sinh ra và được cập nhật
          - bạn vào lại route.rb (config/routes.rb) để xem sự thay đổi
          - Kiểm tra controller đã tạo ở (app/controllers/example_controller.rb)
          - Kiểm tra view tự động sinh ra ở (app/views/example/test.html.erb)
      - Vào url tương ứng với action `test` của controller `Example`. Lưu ý kiểm tra log để thấy cách rails hoạt động.
      > http://localhost:3000/example/test

      - View `app/views/example/test.html.erb` bạn có thể cập nhập thoải mái bằng HTML thuần. Nếu bạn muốn bạn có thể dùng CSS inline.
      - Làm sao để sử dụng CSS external ?
