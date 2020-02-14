# Buổi 8: Giới thiệu về Ruby on Rails framework

## Nội dung cần học
 - Tạo một project Rails đầu tiên
 - Mô hình MVC và API
 - Các module quan trọng trong Rails
 - Bài tập

-----

### I. Tạo một project Rails đầu tiên
  1. Cài đặt Ruby version 2.6.3
  ```bash
  # Ruby hiện tại
  ruby -v

  # Các bản Ruby đã có sẵn trong RVM
  rvm list

  # Nếu có rồi thì dùng
  rvm use 2.6.3

  # Nếu chưa có thì cài rồi dùng
  rvm install -v '2.6.3'
  rvm use 2.6.3
  ```

  2. Cài đặt Rails version 5.2.4
  ```bash
  # Cài đặt rails
  gem install rails -v '5.2.4'

  # Kiểm tra Rails version
  rails -v
  ```

  3. Tạo Rails project
  ```
  rails new hello_world
  ```

  4. Chạy Project
  ```
  rails s
  ```

  5. Vào localhost:3000 ở trên browser để xem kết quả
### II. Mô hình MVC và API
1. #### Mô hình MVC
    - Ứng dụng phần mềm có thể được thiết kế bằng các cấu trúc/mô hình khác nhau. Một trong những mô hình phổ biến đó là mô hình **MVC**
    - Thông thường một Rails app được tổ chức theo mô hình MVC:
        - M - Model: đây là phần tiếp xúc tương tác với database, đồng thời chứa các logic nghiệp vụ.
        - V - View: đây là phần hiển thị/trả về cho người dùng, thông thường là các HTML template, Text template, Excel template, JSON template ...
        - C - Controller: Đây là phần điều hướng, nhận các request từ người dùng và điều hướng chỉ định các logic để thực hiện request.
2. #### API only
    - Rails app thường dùng **Server Side Render**, việc render các file HTML rồi trả về cho người dùng được xử lý trên server. Nhưng hiện nay với sự phát triển mạnh mẽ về phần cứng cũng như sự hỗ trợ của Javascript thì phần render các file HTML này được xử lý ở chính trên máy của User, ta gọi đây là **Client Side Render**
    - Lúc này công việc của Rails chỉ còn là nhận request -> xử lý nghiệp vụ -> trả về data cần thiết (thường là dạng Json). Phần render và logic sau đó hoàn toàn được thực thi ở browser người dùng (chaỵ bằng các JS Framework như: ReactJS, VueJS, AngularJS)

### II. Các module quan trọng trong Rails
1. #### Models
    1. Active Record Basics
    2. Active Record Migrations
    3. Active Record Validations
    4. Active Record Callbacks
    5. Active Record Associations
    6. Active Record Query Interface
2. #### Views
    1. Action View Overview
    2. Layouts and Rendering in Rails
    3. Action View Form Helpers
3. #### Controllers
    1. Action Controller Overview
    2. Rails Routing
4. #### Rails Internationalization (I18n)
5. #### Rails Command Line

### III. Bài tập
  1. Tạo Project đầu tiên theo [hướng dẫn](https://guides.rubyonrails.org/getting_started.html)
