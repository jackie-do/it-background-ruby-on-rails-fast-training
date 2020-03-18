# Buổi 10: Giới thiệu module V - View trong MVC.

## Nội dung cần học
 - Cấu trúc của Action Views
 - Sử dụng Layout và Rendering trong Rails
 - Sử dụng các Form Helpers
 - Bài tập

-----

### I. Cấu trúc của Action Views [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html)
  1. #### Action Views  có tác dụng gì?
      - Với mỗi `controller` thì luôn có một `view` folder tương ứng ở `app/views` chứa các templates để tạo view cho các action tương ứng của controller đó. Tên file của view phải trùng với tên action trong controller.
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

  6. #### Các loại Helpers hữu ích [(Tham khảo)](https://guides.rubyonrails.org/v5.2/action_view_overview.html#overview-of-helpers-provided-by-action-view)
      - AssetTagHelper (quan trọng)
      - AtomFeedHelper
      - BenchmarkHelper
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

### II. Sử dụng Layout và Rendering trong Rails [(Tham Khảo)](https://guides.rubyonrails.org/v5.2/layouts_and_rendering.html)
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
  1. Basic Form
  ```HTML
  <%= form_tag do %>
    Form contents
  <% end %>
  ```

  ```html
  <%= form_tag("/search", method: "get") do %>
    <%= label_tag(:q, "Search for:") %>
    <%= text_field_tag(:q) %>
    <%= submit_tag("Search") %>
  <% end %>
  ```

  ```html
  <%= form_tag({controller: "people", action: "search"}, method: "get", class: "nifty_form") do %>
    <%= label_tag(:q, "Search for:") %>
    <%= text_field_tag(:q) %>
    <%= submit_tag("Search") %>
  <% end %>
  ```


  2. Form Elements
      - Checkboxes
      - Radio Buttons
      - Text area
      - Password field
      - Hidden field
      - Search field
      - Phone field
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
    - Mode Object Helpers
    - Binding a Form to an Object
    - Relying on Record Identification
    - Sử dụng PATCH, PUT, DELETE trong một form

  4. Date and Time Form Helpers
  5. Uploading Files
  6. Parameter Naming Conventions

### IV. Sử dụng I18n (Internationalization) cho việc hiển thị đa ngôn ngữ
  1. Localized Views
  2. I18n



### V. Bài tập
  1. xx
