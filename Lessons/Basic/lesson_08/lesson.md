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
1. #### Controllers
    1. Rails Routing [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/routing.html)
        - REST/RESTful là gì? Mối tương quan với CRUD trên một resource?
            - Có rất nhiều kiến trúc giao tiếp giữa các máy tính với nhau SOAP (format XML), REST (format Json), GraphQL (format Json). Ở đây chúng ta sẽ nói về REST.
            - REST là viết tắt của cụm từ Representational State Transfer. REST được sử dụng rất nhiều trong việc phát triển các ứng dụng Web Services sử dụng giao thức HTTP thông qua mạng internet. Các ứng dụng sử dụng kiến trúc REST này thì sẽ được gọi là ứng dụng phát triển theo kiểu RESTful.
            - Mối tương quan
                * Create (**C**RUD) - HTTP Post
                * Read (C**R**UD) - HTTP Get
                * Update (CR**U**D) - HTTP Put/Patch
                * Delete (CRU**D**) - HTTP Delete
        - Cấu trúc routing của Rails sử dụng cấu trúc REST.
        - Mục đích của routing là từ URL của request ta sẽ đến và thực thị action tương ứng trong Controller. Trong Rails routing sẽ có một số action build-in `index`, `create`, `show`, `update`, `destroy`
        - Mapping giữa HTTP Verb (Post, Get, Put ...) và URL tới controller action [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/routing.html#crud-verbs-and-actions)
        - Sử dụng heplers để tạo Part và URL trong Rails [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/routing.html#path-and-url-helpers)
        - Sử dụng `resource` và `resources`
        - Sử dụng `namespace`. Lưu ý sự thay đổi của url, path, helpers và cấu trúc module
        - Sử dụng Nested Resources.
        - Sử dụng `member` and `collection` trong Resouces
    2. Action Controller Overview [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/action_controller_overview.html)
        - Lưu ý name convention trong controller.
        - Cách tạo action trong controller và cách map action từ route. Ví dụ:
        ```ruby
        class ClientsController < ApplicationController
            def new
            end
        end
        # routes
        resouce :clients do
            collection do
                get :new
            end
        end
        ```
        - Data từ HTTP request được gửi tới action thông qua Parameters
            - Hash and Array parameters
            - JSON parameters
            - Routing paramters
        - Để lọc và chỉ xử lý các parameter cần thiết ta sử dụng Strong Parameters.
        - Sử dụng Session trong controller.
        - Sử dụng Flash trong controller.
        - Sử dụng cookies trong controller.
        - Response và render ra các loại data format khác nhau.
        - Sử dụng filter trong controller.
        - Bảo mật: Cross-site request forgery.
        - Streaming and File downloads.
2. #### Views
    1. Action View Overview [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html)
    2. Layouts and Rendering in Rails [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/layouts_and_rendering.html)
    3. Action View Form Helpers [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/form_helpers.html)
3. #### Models
    1. Active Record Basics [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/active_record_basics.html)
        - x
    2. Active Record Migrations [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/active_record_migrations.html)
        - Rails Data Migrations là gì? Dùng để làm gì?
        - Cách tạo migrations (`up`, `down`, `change`)
        - Run migrations `db:migrate`
        - Rollback migrations `db:rollback`
        - Những lưu ý cần nhớ (best practice khi tạo và chạy migration)
    3. Active Record Validations [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/active_record_validations.html) và Active Record Callbacks [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/active_record_callbacks.html)
        - Sử dụng các validation tạo sẳn.
        - Sử dụng kết hợp `if` và `unless`
        - Tạo một validation tuỳ chỉnh.
        - Sử dụng các Callback trong validation
        - Thứ tự ưu tiên của các Callbacks
    4. Active Record Associations [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/association_basics.html)
        - Có các loại Relation Types nào?
        - Cách khai báo và sử dụng?
    5. Active Record Query Interface [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html)
        - Đọc một record.
        - Đọc nhiều record.
        - Sử dụng điều kiện.
        - Sử dụng SQL thuần.
        - Sử dụng scope



4. #### Rails Internationalization (I18n) [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/i18n.html)
    1. Làm cách nào để xử lý việc hiển thị đa ngôn ngữ trên các trang web?

5. #### Rails Command Line [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/command_line.html)

### III. Bài tập
  1. Tạo Project đầu tiên theo [hướng dẫn](https://guides.rubyonrails.org/getting_started.html)
  2. Ghi nhớ cấu trúc folder của một dự án Rails
