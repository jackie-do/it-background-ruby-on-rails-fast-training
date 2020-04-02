# Buổi 10: Giới thiệu module V - View trong MVC.

## Nội dung cần học
 - Cấu trúc của Action Views
 - Sử dụng Layout và Rendering trong Rails
 - Sử dụng các Form Helpers
 - Bài tập

-----

### I. Cấu trúc của Action Views [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html)
  1. #### Action Views  có tác dụng gì?
      - Với mỗi `controller` thì luôn có một `view` folder tương ứng ở `app/views` chứa các templates để tạo view cho các action tương ứng của controller đó. Tên file của view phải trùng với tên action trong controller.
      - Ví dụ:
        ```bash
        # Dùng scaffold để tạo MVC cho article
        rails generate scaffold article
          [...]
          invoke  scaffold_controller
          create    app/controllers/articles_controller.rb
          invoke    erb
          create      app/views/articles
          create      app/views/articles/index.html.erb
          create      app/views/articles/edit.html.erb
          create      app/views/articles/show.html.erb
          create      app/views/articles/new.html.erb
          create      app/views/articles/_form.html.erb
          [...]
        ```

  2. #### Cấu trúc chính của Action Views
      - Kết quả cuối cùng trả ra của một view là một trang HTML (phổ biến nhất), được tạo ra bởi kết hợp thành phần
          - **`Templates`** mỗi view sẽ có một template có extension thuộc loại `.html.erb`, `.html.slim`, `.html.haml`, `.xml.builder`... với mỗi loại extension sẽ có một template system tương ứng để xử lý. Template default của rails là `.erb`
          - **`Partials`** tên đầy đủ là partial template, là một template thu nhỏ cho việc tái sử dụng ở các view khác nhau.
          - **`Layout`** Thông thường các template sẽ được render trong một layout cụ thể.
  3. #### Templates
      - Rails hỗ trợ rất nhiều loại template và sử dụng file extension để phân biệt các loại template khác nhau. Ví dụ:
        - Một file HTML sử dụng ERB template system sẽ có file extension là `.html.erb`
        - Một file HTML sử dụng HAML template system sẽ có file extension là `.html.haml`
        - Một file HTML sử dụng SLIM template system sẽ có file extension là `.html.slim`
        - Một file XML sử dụng Builder template system sẽ có file extension là `.xml.builder`
        - Một file JSON sử dụng Jbuilder template system sẽ có file extension là `.json.jbuilder`
      - ERB template là template system render HTML. Có thể nhúng code ruby vào trong html thông qua 2 loại tags:
        - `<% %>` tag xử lý logic, thực thi ruby code. Không trả về gì.
        - `<%= %>` tag trả về giá trị trong file HTML.
          ```HTML
          <h1>Names of all the people</h1>
          <% @people.each do |person| %>
            Name: <%= person.name %><br>
          <% end %>
          ```

  4. #### Partials [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html#partials)
      - Là một mảnh nhỏ của template được tách ra để tiện cho việc quản lý và tái sử dụng. Có thể nhúng các partials này vào template bằng cú pháp:
        ```html
        <%= render "menu" %>
        ```
        > Ví dụ trên sẽ render một partial file ở *app/views/_menu.html.erb*
      - Partial giúp đơn giản hoá template bằng cách tách một template ra nhiều phần nhỏ có thể tái sử dụng. Bạn xem ví dụ bên dưới:
        ```html
        <%= render "shared/ad_banner" %>
        <h1>Products</h1>
        <p>Here are a few of our fine products:</p>
        <% @products.each do |product| %>
          <%= render partial: "product", locals: { product: product } %>
        <% end %>

        <%= render "shared/footer" %>
        ```
        > content trong *_ad_banner.html.erb* và *_footer.html.erb* có thể được tái sử dụng ở nhiều trang khác (view khác)
      - Ta có thể truyền parameters vào trong từng partial bằng options `locals` như ví dụ ở trên. Hai cách bên dưới có tác dụng như nhau.
        ```html
        <%= render partial: "product", locals: { product: @product } %>
        ```

         ```html
        <%= render "product", product: @product %>
        ```
      - `as` và `object` options
      - Rendering collections
      - Spacer Templates

  5. #### Layout
      - Trong một website có rất nhiều trang có nội dung khác nhau nhưng bố cục layout giống hệt nhau. Thông thường ta chỉ thay đổi nội dung của một page mà vẫn giữ nguyên hoặc điều chỉnh một chút về layout. Ở trong Rails `layout` được sử dụng như là một template chung dựa vào đó ta render thêm các content phù hợp cho từng page.
      - Thông thường một layout sẽ chứa các thẻ `<html></html>`, `<head></head>`, `<body></body>`, phần nội dung thay đổi sẽ nằm trong body. Các file css, javascript cần thiết sẽ được import trong thẻ head của layout thông qua **Asset Tag Helpers**
      - Chúng ta có thể chỉ định layout cho từng controller, hoặc cho một action cụ thể. Nếu không có chỉ định gì thì layout sẽ tự động lấy `application`  ở app/views/layouts

  6. #### Các loại Helpers hữu ích [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html#overview-of-helpers-provided-by-action-view)
      - AssetTagHelper (quan trọng)
      - AtomFeedHelper
      - BenchmarkHelper
      - CacheHelper
      - CaptureHelper
      - DateHelper
      - DebugHelper
      - FormHelper (quan trọng)
      - FormOptionsHelper (quan trọng)
      - FormTagHelper
      - JavascriptHelper
      - NumberHelper
      - SanitizeHelper
      - CsrfHelper

### II. Sử dụng Layout và Rendering trong Rails [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/layouts_and_rendering.html)
  - Đối với 1 controller có 3 cách để tạo một HTTP response trả về cho một HTTP request:
    - Gọi `render` để tạo một response đầy đủ (trả về HTML, JSON ...) và gửi ngược về browser.
    - Gọi `redirect_to` để gửi HTTP redirect status code về browser.
    - Gọi `head` để gửi một response chỉ chứa HTTP Header only về browser.
  - **1. Sử dụng `render`**
    - Trả về một response đầy đủ chứa data cần thiết cho browser. Response trả về có thể là HTML, JSON, XML, Text, File ...
      ```ruby
      # Render một Action View của controller hiện tại
      render :edit
      render action: :edit
      render "edit"
      render "edit.html.erb"
      render action: "edit"
      render action: "edit.html.erb"

      # Render một Action's template từ một controller khác.
      render "books/edit"
      render "books/edit.html.erb"
      render template: "books/edit"
      render template: "books/edit.html.erb"

      # Render một file bất kỳ
      render "/path/to/rails/app/views/books/edit"
      render "/path/to/rails/app/views/books/edit.html.erb"
      render file: "/path/to/rails/app/views/books/edit"
      render file: "/path/to/rails/app/views/books/edit.html.erb"

      # Render HTML
      render html: helpers.tag.strong('Not Found')

      # Render JSON
      render json: @product

      # Render XML
      render xml: @product

      # Render Vanilla Javascript
      render js: "alert('Hello Rails');"

      # Render Raw body (body of http)
      render body: "raw"
      ```
    - Các options cho render
      - `:content_type` - trả về giá trị `content-type` trong HTTP header
      - `:layout` - chỉ định layout cho view template
      - `:location` - sử dụng để set giá trị cho HTTP Location header
      - `:status` - trả về HTTP status
      - `:formats` - chỉ định format để xác định view template tương ứng.
      ```ruby
      # content_type
      render file: filename, content_type: "application/rss"

      # layout
      render layout: "special_layout"
      render layout: false

      # location
      render xml: photo, location: photo_url(photo)

      # status
      render status: 500
      render status: :forbidden

      # format
      render formats: :xml
      render formats: [:json, :xml]
      ```
    - Cách thức Rails xác định layout cho một action view.
      - Trường hợp không chỉ định layout cụ thể. Ví dụ tìm layout cho action view của `PhotosController`:
        - *app/views/layouts/photos.html.erb* (ưu tiên nếu có)
        - *app/views/layouts/application.html.erb*
      - Trường hợp chỉ định layout trong controller
        ```ruby
        class PhotosController < ApplicationController
          layout "inventory"
          #...
        end
        ```
        > Tìm kiếm layout *app/views/layouts/inventory.html.erb*
  - **2. Sử dụng `redirect_to`**
    - Thay vì trả về một response đầy đủ, ta sẽ báo cho browser biết phải gọi một request mới tới url ta chỉ định.
    ```ruby
    redirect_to photos_url

    redirect_back(fallback_location: root_path)

    redirect_to photos_path, status: 301
    ```
  - **3. Sử dụng `head`**
    - Trả về một response nhưng chỉ có data trong HTTP header.
    ```ruby
    head :bad_request
    ```
    > HTTP/1.1 400 Bad Request <br/>
    > Connection: close  <br/>
    > Date: Sun, 24 Jan 2010 12:15:53 GMT  <br/>
    > Transfer-Encoding: chunked  <br/>
    > Content-Type: text/html; charset=utf-8  <br/>
    > X-Runtime: 0.013483  <br/>
    > Set-Cookie: _blog_session=...snip...; path=/; HttpOnly  <br/>
    > Cache-Control: no-cache  <br/>

    ```ruby
    head :created, location: photo_path(@photo)
    ```
    > HTTP/1.1 201 Created <br/>
    > Connection: close <br/>
    > Date: Sun, 24 Jan 2010 12:16:44 GMT <br/>
    > Transfer-Encoding: chunked <br/>
    > Location: /photos/1 <br/>
    > Content-Type: text/html; charset=utf-8 <br/>
    > X-Runtime: 0.083496 <br/>
    > Set-Cookie: _blog_session=...snip...; path=/; HttpOnly <br/>
    > Cache-Control: no-cache <br/>

### III. Sử dụng các Form Helpers [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/form_helpers.html)
  - Form là thành phần được sử dụng phổ biến nhất để gửi dữ liệu từ một trang HTML lên server. Có một lưu ý nhỏ là theo chuẩn HTML standard thì form chỉ gửi data lên server bằng HTTP GET và POST.
  - Các input tags sẽ là nơi nhận data từ người dùng và những data này sẽ được gửi lên server khi được submit. Data khi gửi lên sẽ có parameter name tương ứng `name` attribute trong input tags.
  1. Basic Form
      - Có 3 loại helpers giúp tạo form:
          - `form_tag`
          - `form_for`
          - `form_with`
      - Cách dùng một `form_tag` thông thường để tạo một form đơn giản.

        ```HTML
        <!-- Trước khi render -->
        <%= form_tag do %>
          Form contents
        <% end %>

        <!-- Sau khi render -->
        <form accept-charset="UTF-8" action="/" method="post">
          <input name="utf8" type="hidden" value="&#x2713;" />
          <input name="authenticity_token" type="hidden" value="J7CBxfHalt49OSHp27hblqK20c9PgwJ108nDHX/8Cts=" />
          Form contents
        </form>
        ```
        > Chúng ta có thể thấy, sau khi render sẽ có 1 form và bên trong nó có 2 input ẩn. Đối với input với name `authenticity_token` thì được sử dụng cho mục đích security đảm bảo form này được tạo ra từ server chống **Cross Site Request Forgery - CSRF** [(Tham khảo)](https://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)

      - Một số dạng form phổ biến
        ```html
        <!-- Search Form -->
        <%= form_tag("/search", method: "get") do %>
          <%= label_tag(:q, "Search for:") %>
          <%= text_field_tag(:q) %>
          <%= submit_tag("Search") %>
        <% end %>

        <!-- Sau khi render -->
        <form accept-charset="UTF-8" action="/search" method="get">
          <input name="utf8" type="hidden" value="&#x2713;" />
          <label for="q">Search for:</label>
          <input id="q" name="q" type="text" />
          <input name="commit" type="submit" value="Search" />
        </form>
        ```
      - `form_tag` chấp nhận 2 arguments:
          - phần xác định `path` (đi đến route nào hoặc đi đến action của controller nào)
          - một hash chứa các `options` (dùng để đặc tả HTTP method và các HTML attributes).
          > Như đã nói ở trước, HTML standard chỉ chấp nhận HTTP `GET` và HTTP `POST` nhưng Rails có mẹo để biết form đó nên đi đến route dành cho HTTP `PUT`/`PATCH`/`DELETE` ... đó là thông qua key `method` trong `options`
          ```HTML
          <!-- Trước khi render  -->
          <!-- PATH: { controller: "people", action: "search" } chỉ định controler và action-->
          <!-- OPTIONS:  method: "get", class: "nifty_form" -->
          form_tag({ controller: "people", action: "search" }, method: "get", class: "nifty_form")
          <!-- Sau khi render  -->
          <form accept-charset="UTF-8" action="/people/search" method="get" class="nifty_form">
          </form>


          <!-- Trước khi render  -->
          <!-- PATH: people_search_path  chỉ định route bằng path_helper -->
          <!-- OPTIONS:  method: "get", class: "nifty_form" -->
          form_tag(people_search_path, method: "get", class: "nifty_form")
          <!-- Sau khi render  -->
          <form accept-charset="UTF-8" action="/user/search" method="get" class="nifty_form">
          </form>
          ```

  2. Form Helpers [(Tham khảo)](https://guides.rubyonrails.org/v5.2/form_helpers.html#other-helpers-of-interest)
      - Helpers hỗ trợ tạo các HTML Input. Các Form helpers này có tên theo dạng `*_tag`.
      - Checkboxes
        ```HTML
        <!-- Trước khi render  -->
        <%= check_box_tag(:pet_dog) %>
        <%= label_tag(:pet_dog, "I own a dog") %>
        <%= check_box_tag(:pet_cat) %>
        <%= label_tag(:pet_cat, "I own a cat") %>

        <!-- Sau khi render  -->
        <input id="pet_dog" name="pet_dog" type="checkbox" value="1" />
        <label for="pet_dog">I own a dog</label>
        <input id="pet_cat" name="pet_cat" type="checkbox" value="1" />
        <label for="pet_cat">I own a cat</label>
        ```
      - Radio Buttons
        ```HTML
        <!-- Trước khi render  -->
        <%= radio_button_tag(:age, "child") %>
        <%= label_tag(:age_child, "I am younger than 21") %>
        <%= radio_button_tag(:age, "adult") %>
        <%= label_tag(:age_adult, "I'm over 21") %>

        <!-- Sau khi render  -->
        <input id="age_child" name="age" type="radio" value="child" />
        <label for="age_child">I am younger than 21</label>
        <input id="age_adult" name="age" type="radio" value="adult" />
        <label for="age_adult">I'm over 21</label>
        ```
      - Text area
        ```HTML
        <!-- Trước khi render  -->
        <%= text_area_tag(:message, "Hi, nice site", size: "24x6") %>

        <!-- Sau khi render  -->
        <textarea id="message" name="message" cols="24" rows="6">Hi, nice site</textarea>
        ```
      - Password field
        ```HTML
        <!-- Trước khi render  -->
        <%= password_field_tag(:password) %>

        <!-- Sau khi render  -->
        <input id="password" name="password" type="password" />
        ```
      - Hidden field
        ```HTML
        <!-- Trước khi render  -->
        <%= hidden_field_tag(:parent_id, "5") %>

        <!-- Sau khi render  -->

        ```
      - Search field
        ```HTML
        <!-- Trước khi render  -->
        <%= search_field(:user, :name) %>

        <!-- Sau khi render  -->
        <input id="user_name" name="user[name]" type="search" />
        ```
      - Phone field
       ```HTML
        <!-- Trước khi render  -->
        <%= telephone_field(:user, :phone) %>

        <!-- Sau khi render  -->
        <input id="user_phone" name="user[phone]" type="tel" />
      ```
      - Date field
      - url field
      - email field
      - color_field
      - numer_field
      - range_field
      ```html
      <%= check_box_tag(:pet_dog) %>
      <%= label_tag(:pet_dog, "I own a dog") %>
      <%= check_box_tag(:pet_cat) %>
      <%= label_tag(:pet_cat, "I own a cat") %>

      <%= radio_button_tag(:age, "child") %>
      <%= label_tag(:age_child, "I am younger than 21") %>
      <%= radio_button_tag(:age, "adult") %>
      <%= label_tag(:age_adult, "I'm over 21") %>

      <%= text_area_tag(:message, "Hi, nice site", size: "24x6") %>
      <%= password_field_tag(:password) %>
      <%= hidden_field_tag(:parent_id, "5") %>
      <%= search_field(:user, :name) %>
      <%= telephone_field(:user, :phone) %>
      <%= date_field(:user, :born_on) %>
      <%= datetime_local_field(:user, :graduation_day) %>
      <%= month_field(:user, :birthday_month) %>
      <%= week_field(:user, :birthday_week) %>
      <%= url_field(:user, :homepage) %>
      <%= email_field(:user, :address) %>
      <%= color_field(:user, :favorite_color) %>
      <%= time_field(:task, :started_at) %>
      <%= number_field(:product, :price, in: 1.0..20.0, step: 0.5) %>
      <%= range_field(:product, :discount, in: 1..100) %>
      ```

  3. Model Object
      - Model Object Helpers
          - Helpers cho phép tạo các HTML input dựa trên object (thông thường là một instance variable của một model).
          - Khác với Form Helpers (ex: `text_field_tag`, `check_box_tag` ...) Model Object Helpers không có phần đuôi `_tag` (ex: `text_field`, `check_box` ...)
          - Text Field: chấp nhận 2 arguments: name của một instance varible, name của một method của instance đó
            ```HTML
            <!-- Trước khi render -->
            <%= text_field(:person, :name) %>
            <!-- Sau khi render -->
            <input id="person_name" name="person[name]" type="text" value="Henry"/>
            ```
            > ở ví dụ trên render text field dựa trên instance variable @person và value là @person.name

      - Binding a Form to an Object
          - Chúng ta có thể tạo một form dựa trên một object (thông thường là một instance variable của một model), các input tags tương ứng với attributes của object đó bằng cách sử dụng `form_for`
            ```ruby
            # app/controllers/articles_controller.rb
            def new
              @article = Article.new
            end
            ```

            ```html
            <!-- app/views/articles/new.html.erb -->

            <!-- Trước khi render -->
            <%= form_for @article, url: {action: "create"}, html: {class: "nifty_form"} do |f| %>
              <%= f.text_field :title %>
              <%= f.text_area :body, size: "60x12" %>
              <%= f.submit "Create" %>
            <% end %>

            <!-- Sau khi render -->
            <form class="nifty_form" id="new_article" action="/articles" accept-charset="UTF-8" method="post">
              <input name="utf8" type="hidden" value="&#x2713;" />
              <input type="hidden" name="authenticity_token" value="NRkFyRWxdYNfUg7vYxLOp2SLf93lvnl+QwDWorR42Dp6yZXPhHEb6arhDOIWcqGit8jfnrPwL781/xlrzj63TA==" />
              <input type="text" name="article[title]" id="article_title" />
              <textarea name="article[body]" id="article_body" cols="60" rows="12"></textarea>
              <input type="submit" name="commit" value="Create" data-disable-with="Create" />
            </form>
            ```
            > - @article là một instace variable, thường là instance của một Model.
            > - Sử dụng `url` để chỉ định routes/action muốn đến.
            > - Lưu ý cách sử dụng `f` (form builder) để gọi các Model Object Helpers.
      - Sử dụng PATCH, PUT, DELETE trong một form
          - Như đã nói từ trước HTML Standard chỉ hỗ trợ gửi data từ form lên server bằng HTTP GET và POST vậy làm sao có thể sử dụng PATCH, PUT, DELETE ? Rails cho phép làm điều này bằng một hidden input `_method`, về mặt kỹ thuật data vẫn được gửi bằng HTTP POST nhưng khi Rails nhận request này thì nó sẽ điều hướng tới route dùng PUT/PATCH/DETELE thay vì điều hướng tới route dùng POST.
            ```HTML
            <!-- Trước khi render -->
            form_tag(search_path, method: "patch")

            <!-- Sau khi render -->
            <form accept-charset="UTF-8" action="/search" method="post">
              <input name="_method" type="hidden" value="patch" />
              <input name="utf8" type="hidden" value="&#x2713;" />
              <input name="authenticity_token" type="hidden" value="f755bb0ed134b76c432144748a6d4b7a7ddf2b71" />
              ...
            </form>
            ```

  4. Date and Time Form Helpers
  5. Uploading Files
  6. Parameter Naming Conventions

### IV. Sử dụng I18n (Internationalization) cho việc hiển thị đa ngôn ngữ
  1. Localized Views
  2. I18n



### V. Bài tập
  1. Có bao nhiêu cách controler trả về một responce? Cách nào phổ biến nhất?
  2. Giả sử bạn có một controller `ProductsController` (ở tại app/controllers/) thì action `index` sẽ lấy file view ở đâu? Sử dụng layout ở đâu?
  3. Theo HTML Standard thì data trong `<form>` được gửi tới server bằng cách gì? Khi nào thì gửi? Làm sao để gửi data trong form một action của một controller chỉ định?
  4. Khác biết giữa Form Helpers và Modal Object Helpers là gì? Công dụng của Modal Object Helpers?

