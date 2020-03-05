# Buổi 9: Giới thiệu module C - Controller trong MVC

## Nội dung cần học
 - Cấu trúc của Controller
 - Cấu hình cho Rails Router
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


### II. Cấu hình cho Rails Router
  1. #### Router có tác dụng gì?
      - Trong Rails app, router có 2 tác dụng chính
          - Kết nối URLs tới code (cự thể ở đây là 1 action của controller).
          - Hỗ trợ tạo ra URL và path bằng URL helper và path helper.
      - Việc định nghĩa các routes trong ứng dụng được thực hiện ở `config/routes.rb`. Ví dụ:
      ```ruby
      Rails.application.routes.draw do
        resources :brands, only: [:index, :show] do
          resources :products, only: [:index, :show]
        end

        resource :basket, only: [:show, :update, :destroy]

        resolve("Basket") { route_for(:basket) }
      end
      ```
  2. #### Resource Routing là gì?
      -  Trong ví dụ ở trên các bạn có thể thấy ta sử dụng 2 methods `resources` và `resource`. Đây là methods rails support giúp ta nhanh chóng định nghĩa các route phổ biến cho một controller (`index`, `show`, `new`, `edit`, `create`, `update`, `destroy`) bằng 1 dòng code.
      - Để kiểm tra bạn có thể dễ dàng khai báo routes bằng resource trong `routes.rb` và dùng `rake routes` (hoặc `rails routes`) để xem các routes khai báo.
      ```ruby
      Rails.application.routes.draw do
        resource :home

        resources :news

        resources :users, only: [:index]
      end
      ```

      **1. CRUD, Verbs and Actions**
      - Khi bạn check `rake routes` bạn sẽ thấy sẽ có việc mapping kết hợp **HTTP Verbs** (GET, POST, PUT, PATCH, DELETE) và **URL** để dẫn đến một **action** cụ thể của một **controller** nào đó. Ví dụ:
        ```ruby
          resources :photos
        ```

        | **HTTP Verb** | **Path**         | **Controller#Action** | **Used for**                        |
        |---------------|------------------|-----------------------|-------------------------------------|
        | GET           | /photos          | photos#index          | hiển thị danh sách các photos       |
        | GET           | /photos/new      | photos#new            | trả về một html form để tạo photo   |
        | POST          | /photos          | photos#create         | nhận request chứa data để tạo photo |
        | GET           | /photos/:id      | photos#show           | hiển thị một photo                  |
        | GET           | /photos/:id/edit | photos#edit           | trả về một html form để edit photo  |
        | PATCH/PUT     | /photos/:id      | photos#update         | cập nhật một photo nào đó           |
        | DELETE        | /photos/:id      | photos#destroy        | xoá một photo                       |



      **2. Sử dụng Path and URL helpers**
      - Khi bạn sử dụng `resources` để tạo routes, thì rails cũng sẽ tự động sinh ra một vài helper tương ứng có bạn sử dụng. Trong trường hợp resources photos phía trên. ta sẽ có một số heplers:
          - `photos_path` trả về */photos*
          - `new_photo_path` trả về */photos/new*
          - `edit_photo_path(:id)` trả về */photos/:id/edit* (ví dụ, edit_photo_path(10) trả về */photos/10/edit*)
          - `photo_path(:id)` returns */photos/:id* (ví dụ), photo_path(10) trả về */photos/10*)
          - `photos_url`, `new_photo_url` ...
          - ...

      **3. Singular Resources**

      **4. Controller Namespaces và Routing**
          - Thay vì để toàn bộ các controllers của mình trong một thư mục `app/controllers`. Ta có thể tạo các thư mục con trong thư mục `controllers` và chia các controllers của chúng ta theo các cụm tương ứng, có chức năng liên quan tới nhau. Việc phân chia cấu trúc như vậy cần có một sự điều chỉnh ở `routes.rb` người ta gọi đó là **`namespace`**. Ví dụ: chúng ta bỏ 2 controlers articles và comment trong thư mục admin. Ta phải có sự khai báo phù hợp trong `routes.rb`. Việc khai báo này sẽ ảnh hưởng route được tạo ra và nơi để chỉ định action của controller.
            ```ruby
            # app/controllers/admin/articles_controller.rb
            module Admin
              class ArticlesController < ApplicationController
                def index
                end

                def create
                end
                # other actions ...
              end
            end

            # app/controllers/admin/comments_controller.rb
            module Admin
              class CommentsController < ApplicationController
                def index
                end

                def create
                end
                # other actions ...
              end
            end


            # config/routes.rb
            namespace :admin do
              resources :articles, :comments
            end
            ```

          - Lưu ý, option `module` sẽ ảnh hưởng nơi lấy controller và option `scope` sẽ ảnh hưởng path của route. Chỉnh sửa `routes.rb` để xem lại. Kiểm tra lại bằng `rake routes`
            ```ruby
            scope '/admin' do
              resources :articles
            end

            scope module: 'admin' do
              resources :comments
            end
            ```

      **5. Nested Resources**

      **6. Thêm các actions tuỳ chỉnh**

  3. #### Non-Resource Routing là gì?

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

      - View `app/views/example/test.html.erb` bạn có thể cập nhật thoải mái bằng HTML thuần. Nếu bạn muốn bạn có thể dùng CSS inline.
      - Làm sao để sử dụng CSS external ?
