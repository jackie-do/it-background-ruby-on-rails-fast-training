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
      - **`Filters`** "before", "after", "around" đây là các trigger sẽ gọi method chỉ định khi có một sự kiện phù hợp xảy ra.
      - **`Parameters`**
        - Làm thế nào để client gửi thông tin lên Rails app?
        - Các thông tin này được chứa ở đâu trong 1 HTTP request?
        - Rails nhận các thông tin này ở đâu?
        - Có các dạng data nào có thể truyền trong một HTTP request?
      - **`Strong Parameters`** được sử dụng để lọc các parameters không được cho phép, chỉ xử lý một số paramaters nhất định.
      - **`Request and Response`** mọi controllers có 2 methods `request` and `response` chứa thông tin request từ client và response trả về tại thời điểm đó. [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_controller_overview.html#the-request-and-response-objects)
      - **`Sessions`**
        - Session được sử dụng để lưu một lượng nhỏ data và thống nhất giữa các requests cho mỗi user.
        - Data của Session thường được lưu trữ trên server. Có thể được lưu trong 4 dạng:
          - Cookie Session - `ActionDispatch::Session::CookieStore` lưu ở client (được mã hoá trong cookie)
          - Cache Session - `ActionDispatch::Session::CacheStore ` lưu ở Rails Cache
          - ActiveRecord Session - `ActionDispatch::Session::ActiveRecordStore` lưu ở Database (cần gem `activerecord-session_store`)
          - Memcached Session - `ActionDispatch::Session::MemCacheStore` tương tự như Cache Session, nhưng cách này không linh hoạt bằng (hết thời)
        - **Cookie Session** là default session trong Rails, thông tin session được mã hoá dựa trên secret_key_base ở `config/credentials.yml.enc` và lưu trữ ở cookie của browser.
        - Có thể thao tác với thông tin của session bằng instance method `session`. Thao tác như một biến bình thường.
          ```ruby
          # Đọc data từ session
          class ApplicationController < ActionController::Base
            private
            # Finds the User with the ID stored in the session with the key
            # :current_user_id This is a common way to handle user login in
            # a Rails application; logging in sets the session value and
            # logging out removes it.
            def current_user
              @_current_user ||= session[:current_user_id] &&
                User.find_by(id: session[:current_user_id])
            end
          end
          ```

          ```ruby
          # Lưu data vào session
          class LoginsController < ApplicationController
            # "Create" a login, aka "log the user in"
            def create
              if user = User.authenticate(params[:username], params[:password])
                # Save the user ID in the session so it can be used in
                # subsequent requests
                session[:current_user_id] = user.id
                redirect_to root_url
              end
            end
          end
          ```

          ```ruby
          # Xoá data từ session
          class LoginsController < ApplicationController
            # "Delete" a login, aka "log the user out"
            def destroy
              # Remove the user id from the session
              @_current_user = session[:current_user_id] = nil
              redirect_to root_url
            end
          end
          ```
        - `Flash` là gì? Là một phần data đặc biệt nằm trong session, sẽ được xoá đi sau mỗi request. Giá trị này chỉ tồn tại cho tới request tiếp theo, thường được dùng để báo lỗi, notification... Cách sử dụng tương tự session. Thông tin của flash thường được hiển thị trong view. [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_controller_overview.html#the-flash)
          ```ruby
          class LoginsController < ApplicationController
            def destroy
              session[:current_user_id] = nil
              flash[:notice] = "You have successfully logged out."
              redirect_to root_url
            end
          end
          ```

      - **`Cookies`**
        - Web app có thể lưu một lượng nhỏ data trên client thông qua cookies. Data này có thể sử dụng trên nhiều requests hoặc nhiều sessions khác nhau. Chúng ta có thể set expired, mã hoá ... cho cookie nếu cần. Cú pháp sử dụng tương tự session.
          ```ruby
          class CommentsController < ApplicationController
            def new
              # Auto-fill the commenter's name if it has been stored in a cookie
              @comment = Comment.new(author: cookies[:commenter_name])
            end

            def create
              @comment = Comment.new(params[:comment])
              if @comment.save
                flash[:notice] = "Thanks for your comment!"
                if params[:remember_name]
                  # Remember the commenter's name.
                  cookies[:commenter_name] = @comment.author
                else
                  # Delete cookie for the commenter's name cookie, if any.
                  cookies.delete(:commenter_name)
                end
                redirect_to @comment.article
              else
                render action: "new"
              end
            end
          end
          ```


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
          # Sử dụng resouces để tạo ra 7 routes
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
      - Ta sử dụng singular resource bằng method `resource` thay vì `resources`. Singular resource không sử dụng params `id` để lấy data. Chỉ sinh ra 6 routes thay vì 7 routes (do không có index)
        ```ruby
          resources :profile
        ```

        | **HTTP Verb** | **Path**         | **Controller#Action** | **Used for**                          |
        |---------------|------------------|-----------------------|---------------------------------------|
        | GET           | /profile/new     | profile#new           | trả về một html form để tạo profile   |
        | POST          | /profile         | profile#create        | nhận request chứa data để tạo profile |
        | GET           | /profile/        | profile#show          | hiển thị một profile                  |
        | GET           | /profile/edit    | profile#edit          | trả về một html form để edit profile  |
        | PATCH/PUT     | /profile         | profile#update        | cập nhật một profile nào đó           |
        | DELETE        | /profile         | profile#destroy       | xoá một profile                       |


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
        - Chúng ta cũng có thể sử dụng các resouces lồng nhau để thể hiện mối quan hệ cha con giữa các resources.
        ```ruby
        # Giả sử chúng ta có 2 models tương ứng 2 tables.
        # Một magazine (tạp chí) sẽ có nhiều trang ads (quảng cáo)
        class Magazine < ApplicationRecord
          has_many :ads
        end

        class Ad < ApplicationRecord
          belongs_to :magazine
        end
        ```

        ```ruby
        # Ta có cấu trúc khai báo lồng bên dưới
        # Chạy rake routes để kiểm tra các routes
        resources :magazines do
          resources :ads
        end
        ```

        | **HTTP Verb** | **Path**                            | **Controller#Action** | **Used for**                                   |
        |---------------|-------------------------------------|-----------------------|------------------------------------------------|
        | GET           | /magazines/:magazine_id/ads	        | ads#index	            | hiển thị danh sách các ad của một magazine     |
        | GET           | /magazines/:magazine_id/ads/new	    | ads#new	              | trả về một html form để tạo ad cho một magazine|
        | POST          | /magazines/:magazine_id/ads	        | ads#create	          | tạo một ad cho một manazine                    |
        | GET           | /magazines/:magazine_id/ads/:id	    | ads#show	            | hiển thị một ad cụ thể trong một magazine      |
        | GET           | /magazines/:magazine_id/ads/:id/edit| ads#edit	            | trả về một html form để edit ads               |
        | PATCH/PUT     | /magazines/:magazine_id/ads/:id	    | ads#update	          | cập nhật một ad của một magazine               |
        | DELETE        | /magazines/:magazine_id/ads/:id	    | ads#destroy           | xoá một ads của một managezine                 |

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
      - Đây là cách phổ biến nhất để truyền giá trị bằng URL. Tất cả các query string sẽ được tính sau dấu `?` theo cấu trúc key `=` value và phân cách nhau bằng dấu `=`. Chúng ra không cần khai báo route mới mà có thể sử dụng route cũ với cú pháp của query string.
        ```ruby
        get 'photos/:id', to: 'photos#show'

        # Example URL: /photos/101?user_id=10 hoặc /photos/101?user_id=10&second_user_id=11
        ```
        > Với ví dụ trên ngoài `params[:id]` ta còn có params[:user_id] và params[:second_user_id] được truyền trong Query String.
      - Làm sao để truyền một mảng trong query string? Làm sao để truyền 1 hash (object lồng)? Độ dài giới hạn của 1 URL là bao nhiêu?

      **5. Defining Defaults**
      - Định nghĩa đuôi file trả về của 1 action (phổ biến nhất là `html` và `json`). Giá trị này sẽ giúp chọn loại format và logic xử lý riêng (nếu có)
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
      - Kiểm tra lại `config/routes.rb` (lúc này bạn sẽ thấy method `resources`). Cập nhật để thêm 1 route mới (Bound Parameters)
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

  4. Làm quen với Cookies [(Tham khảo)](./exercises/04)
      - Tạo project
        ```bash
        rails new cookie_jar
        cd cookie_jar

        rails db:migrate

        # Tạo ra home controller và 3 actions để làm việc với cookies
        rails generate controller home set_cookies show_cookies delete_cookies

        # Kiểm tra các routes hiện có
        rails routes
        ```
      - Cập nhật home controller
        ```ruby
        # app/controllers/home_controller.rb
        class HomeController < ApplicationController
          def set_cookies
            cookies[:user_name]       = "Smith"
            cookies[:customer_number] = "1234567890"
          end

          def show_cookies
            @user_name = cookies[:user_name]
            @customer_number = cookies[:customer_number]
          end

          def delete_cookies
            cookies.delete :user_name
            cookies.delete :customer_number
          end
        end
        ```
      - Cập nhật view cho `show_cookies` action ở app/views/home/show_cookies.html.erb
        ```HTML
        <table>
          <tr>
            <td>User Name:</td>
            <td><%= @user_name %></td>
          </tr>
          <tr>
            <td>Customer Number:</td>
            <td><%= @customer_number %></td>
          </tr>
        </table>
        ```
      - Start server bằng `rails s`. Vào kiểm tra http://localhost:3000/home/show_cookies lúc này chưa có gì. Bạn có thể chi tiết trong browser để kiểm tra cookie có tồn tại hay không (google để biết cách xem cookie trong browser)
      - Vào http://localhost:3000/home/set_cookies để lưu giá trị vào cookies.
      - Vào lại http://localhost:3000/home/show_cookies để xem thay đổi (và vào browser check giá trị trong cookies)
      - Vào http://localhost:3000/home/delete_cookies để xoá giá trị ở cookies.
      - Vào lại http://localhost:3000/home/show_cookies để xem thay đổi (và vào browser check giá trị trong cookies)
      - Phải hiểu được cookie lưu data ở đâu? Làm sao lấy data của cookie trên server? Các options khi set một cookies trên server?

  5. Làm quen với session [(Tham khảo)](./exercises/05)
      - Tạo project mới, track lại 3 request trước đó đã truy cập
        ```bash
        rails new breadcrumbs
        cd breadcrumbs

        rails db:migrate

        # Tạo ra home controller và 3 actions để làm việc với sesion
        rails generate controller Home ping pong index
        ```
      - Cập nhật home controller
        ```ruby
        # app/controllers/home_controller.rb
        class HomeController < ApplicationController
          before_action :set_breadcrumbs

          def ping
          end

          def pong
          end

          def index
          end

          private

          def set_breadcrumbs
            if session[:breadcrumbs]
              @breadcrumbs = session[:breadcrumbs]
            else
              @breadcrumbs = Array.new
            end

            @breadcrumbs.push(request.url)
            if @breadcrumbs.count > 4
              # shift removes the first element
              @breadcrumbs.shift
            end

            session[:breadcrumbs] = @breadcrumbs end
          end
        ```

      - Cập nhật view layout `app/views/layouts/application.html.erb`
        ```html
        <!DOCTYPE html>
        <html>
          <head>
            <title>Breadcrumbs</title>
            <%= csrf_meta_tags %>
            <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
            <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
          </head>
          <body>
            <% if @breadcrumbs && @breadcrumbs.any? %>
              <h3>Surf History</h3>
              <ul>
                <% @breadcrumbs[0..2].each do |breadcrumb| %>
                  <li><%= link_to breadcrumb, breadcrumb %></li>
                <% end %>
              </ul>
            <% end %>
            <%= yield %>
          </body>
        </html>
        ```