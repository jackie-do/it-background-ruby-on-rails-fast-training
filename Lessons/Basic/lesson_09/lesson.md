# Buổi 9: Giới thiệu module C - Controller trong MVC

## Nội dung cần học
 - Cấu trúc của Controller
 - Cấu hình cho Rails Router
 - Bài tập

-----

### I. Cấu trúc của Controllers [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/action_controller_overview.html)
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


### II. Cấu hình cho Rails Router [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/routing.html)
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
      **1. Bound Parameters**
      - Bạn có thể thêm optional parameters cho 1 route
        ```ruby
        get 'photos(/:id)', to: :display

        # Example URL: /photos hoặc /photos/101
        ```
        > Bất cứ URL nào map /photos/ hoặc /photos/101 đều sẽ được xử lý ở action display của PhotosController

      **2. Dynamic Segments**
      - Bạn có thể truyền các giá trị động - Dynamic Segment, bắt đầu bằng dấu `:` trong URL miễn là nó nằm đúng vị trí như bạn thiết kế.
        ```ruby
        get 'photos/:id/:user_id', to: 'photos#show'

        # Example URL: photos/101/10
        ```
        > Trong ví dụ trên bất cứ gía trị gì nằm ở vị trí của `:id` và `:user_id` sẽ được lấy bằng `params[:id]` và `params[:user_id]` ở PhotosController.

      **3. Static Segments**
      - Thiết kế bằng URL bằng cách thêm chữ thể tăng ngữ nghĩa miễn là nó không có dấu `:` đứng trước.
        ```ruby
        get 'photos/:id/with_user/:user_id', to: 'photos#show'

        # Example URL: photos/101/with_user/10
        ```
        > Trong ví dụ trên bất `with_user` được xem làm static segments

      **4. The Query String**
      - Đây là cách phổ biến nhất để truyền giá trị bằng URL. Tất cả các query string sẽ được tính sau dấu `?` theo cấu trúc key `=` value và phân cách nhau bằng dấu `=`
        ```ruby
        get 'photos/:id', to: 'photos#show'

        # Example URL: /photos/101?user_id=10 hoặc /photos/101?user_id=10&second_user_id=11
        ```
        > Với ví dụ trên ngoài `params[:id]` ta còn có params[:user_id] và params[:second_user_id] được truyền trong Query String.
      - Làm sao để truyền một mảng trong query string? Làm sao để truyền 1 hash (object lồng)? Độ dài giới hạn của 1 URL là bao nhiêu?

      **5. Defining Defaults**
      - Định nghĩa đuôi file trả về của 1 action (phổ biến nhất là `html` và `json`). Giá trị này sẽ giúp chọn loại format và logic xử lý riêng (nếu có)
      ```ruby
      get 'photos/:id', to: 'photos#show', defaults: { format: 'jpg' }

      # hoặc
      defaults format: :json do
        resources :photos
      end
      ```

      **6. Naming Routes**
      - Thay ví để Rails tự tạo ra URL và các helpers thì bạn có thể điều chỉnh bằng option `as`
        ```ruby
          get 'exit', to: 'sessions#destroy', as: :logout
        ```
      **7. HTTP Verb Constraints***
      - Có thể sử dụng nhiều HTTP method cho 1 route
        ```ruby
        match 'photos', to: 'photos#show', via: [:get, :post]

        # hoặc
        match 'photos', to: 'photos#show', via: :all
        ```
      **8. Segment Constraints**
      - Bạn có thể định dạng format của các dynamic segnment bằng cú pháp RegEx hoặc code ruby ở với option `constraints`
        ```ruby
        get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }
        ```
        > Với ví dụ trên chỉ có url /photos/A12345 sẽ vào action show còn url photos/893 thì không.


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
  2. Tạo Rails app để làm quen với một số option cơ bản của Router [(Tham khảo)](./exercises/02)
      - Tạo project cùng với controller và 3 actions
        ```bash
        # Tạo project tên "shop"
        rails new shop
        cd shop
        rails db:migrate

        # check available routes (bỏ qua các route của active_storage nếu có)
        rails routes

        # Tạo Controller đầu tiên cùng với 3 actions
        rails generate controller Home index ping pong

        # Kiểm tra lại routes, có thể kiểm tra bằng cách loc keyword "rails routes | grep home"
        rails routes

        rails s

        ```
      - Lúc này ta có 3 trang tương ứng với actions của HomeController. Bạn hãy vào từng URL để kiểm tra
      - Kiểm tra `config/routes.rb` ta sẽ thấy 3 routes tương ứng.
      - Đổi tên 1 route với option `as`. Kiểm tra kết quả bằng `rails routes` và sử dụng URL mới
        ```ruby
        # config/routes.rb
        get "home/pong", as: 'different_name'
        ```
      - Đổi tên 1 route với option `as`. Kiểm tra kết quả bằng `rails routes` và kiểm tra sự thay đổi của các helpers đi kèm trong rails console. Ví dụ: `app.different_name_path`
        ```ruby
        # config/routes.rb
        get "home/pong", as: 'different_name'
        ```
      - Thêm 1 route mới dùng lại action đã có option `to`.
        ```ruby
        # config/routes.rb
        get "home/applepie", to: "home#ping"
        ```
  3. Sử dụng Bound Parameters trong route [(Tham khảo)](./exercises/03)
      - Tạo project
        ```bash
        rails new blog

        cd blog

        # Sử dụng lệnh scaffold để build 1 combo gồm Controller/View/Model
        rails generate scaffold post subject content published_on:date
        rails db:migrate

        # Kiểm tra các routes hiện có
        rails routes
        ```
      - Tạo data ban đầu ở `db/seeds.rb`, sau đó chạy lệnh tạo data `rails db:seed`, sau đó start server `rails s`
        ```ruby
        # db/seeds.rb
        Post.create(subject: 'A test', published_on: '01.10.2011')
        Post.create(subject: 'Another test', published_on: '01.10.2011')
        Post.create(subject: 'And yet one more test', published_on: '02.10.2011')
        Post.create(subject: 'Last test', published_on: '01.11.2011')
        Post.create(subject: 'Very final test', published_on: '01.11.2012')
        ```
      - Vào lại trang index của PostController để kiểm tra. URL là .......
      - Kiểm tra lại `config/routes.rb` (lúc này bạn sẽ thấy method `resources`). Cập nhật để thêm 1 route mới (Bound Parameters)
        ```ruby
        Rails.application.routes.draw do
          resources :posts

          get ':year(/:month(/:day))', to: 'posts#index'
        end
        ```
      - Cập nhật action `index` để làm việc với route mới
        ```ruby
        # app/controllers/posts_controller.rb
        def index
          # Check if the URL requests a date.
          if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
            start_date = Date.parse("#{params[:day]}.#{params[:month]}.#{params[:year]}")
            end_date = start_date
          # Check if the URL requests a month
          elsif Date.valid_date?(params[:year].to_i, params[:month].to_i, 1)
            start_date = Date.parse("1.#{params[:month]}.#{params[:year]}")
            end_date = start_date.end_of_month
          # Check if the URL requests a year
          elsif params[:year] && Date.valid_date?(params[:year].to_i, 1, 1)
            start_date = Date.parse("1.1.#{params[:year]}")
            end_date = start_date.end_of_year
          end

          if start_date && end_date
            @posts = Post.where(published_on: start_date..end_date)
          else
            @posts = Post.all
          end
        end
        ```
      - Vào một số URL để kiểm tra kết quả:
          - http://localhost:3000/2011/10/01  (lưu ý kiểm tra giá trị params)
          - http://localhost:3000/2011/10  (lưu ý kiểm tra giá trị params)
          - http://localhost:3000/2011  (lưu ý kiểm tra giá trị params)
      - Bài tập: Comment route mới, thay vì dùng bound parameters thì hãy dùng query string để lọc ngày tháng tương tự ? (tái sử dụng các routes được tạo ra từ resources)
      - Bài tập: Bạn thử tạo 1 route khác, dùng lại action `index` bằng Dynamic Segmens.
