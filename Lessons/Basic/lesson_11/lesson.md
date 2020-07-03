# Buổi 11: Giới thiệu module M - Model trong MVC.

## Nội dung cần học
 - Tương tác với database và tables trong Rails
 - Tạo các loại quan hệ giữa các Models bằng Active Record Associations
 - Tương tác với từng record trong table
 - Kiểm tra data với Active Record Validations
 - Xử lý các sự kiện với Active Record Callbacks
 - Bài tập

-----

### I. Tương tác với database và tables trong Rails 
  1. #### Tạo sửa xoá các tables sử dụng Active Record Migrations [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_migrations.html)
      - Sử dụng những Migrations là một cách thuật tiện để thay đổi cấu trúc database (database schema), đảm bảo sự nhanh chóng, thuận tiện và dễ dàng.
      - Đối với Rails, ta sử dụng code Ruby (với các methods hỗ trợ sẵn) để tạo nên các migrations thay vì phải viết migration thủ công.
      - Mỗi migration sẽ là một sự thay đổi nhỏ tạo nên một phiên bản mới của database. Tất cả thay đổi bao gồm: thêm xóa sửa tables/columns, thêm xóa sửa function/procedure/strigger... đều có thể có được xem là migration.
      - Ví dụ:
          - Tạo một table
          > Tạo table `products` với 3 columns là name, description, price và 2 columns timestamp là created_at và updated_at 
          ```ruby
          class CreateProducts < ActiveRecord::Migration[5.0]
            def change
              create_table :products do |t|
                t.string :name
                t.text :description
                t.integer :price

                t.timestamps
              end
            end
          end
          ```
          - Tạo một thay đổi với up và down (up là action khi apply migration, down là action khi gỡ migration ra)
          > Thay đổi loại data của column `price` từ integer thành str
          ```ruby
          class ChangeProductsPrice < ActiveRecord::Migration[5.0]
           def up
             change_table :products do |t|
               t.change :price, :string
             end
           end

           def down
             change_table :products do |t|
               t.change :price, :integer
             end
           end
         end
          ```
      - **Cách để tạo một migration [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_migrations.html#creating-a-migration)**



  2. #### Tương tác với data của các tables sử dụng các Models
      - Thông thường một model class là một mô hình hóa của một table trong database. Model class để tương tác với table, model instance để tương tác với row.
      - Đối với các ứng dụng quy mô nhỏ, thông thường các logic nghiệp vu thường được đặt ở model theo chuẩn MVC.
      - **Cách để tạo một model [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_migrations.html#model-generators)**
          - Bạn có thể tạo model bằng cách tạo các file ruby bằng tay hoặc sử dụng model generator được hỗ trợ bởi rails. Xem ví dụ bên dưới
          > Tạo một model để quản lý 1 table có 2 columns: name và description
          ```bash
          # Cú pháp 1
          bin/rails generate model Product name:string description:text
          
          # Cú pháp 2
          bin/rails g model Product name:string description:text
          ```
      - Để tương tác với data trong database thông thường chúng ta không sử dụng SQL thuần (raw SQL) mà thao tác thông qua **Active Record Query [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html)**
          - Lấy một object (record) từ một table trong database [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html#retrieving-objects-from-the-database)
          > 1) Sử dụng `find` để tìm một client trong table clients bằng `id` của một record. Method này sẽ báo lỗi (exception) nếu không có kết quả. Nếu muốn tìm với id mà không báo lỗi khi tìm không có, ta có thể dùng `find_by`. Kết quả matched trả về luôn luôn là **một object**
          ```ruby 
          # Sử dụng 'find' để tìm một client bằng primary key (id) = 10.
          client = Client.find(10)
          # => #<Client id: 10, first_name: "Ryan">
          
          
          # Sử dụng 'find_by'
          client = Client.find_by(id: 10)
          ```
          
          ```sql
          /* SQL tương ứng */
          SELECT * FROM clients WHERE (clients.id = 10) LIMIT 1
          ```
          
          > 2) Sử dụng `first` để lấy một client đầu tiên trong table theo thứ tự (thứ tự default là primary key tăng dần). Method này trả về nil nếu không có kết quả matched. Kết quả matched trả về có thể là **một object** hoặc **một mảng object**
          ```ruby
          # Sử dụng với order default
          client = Client.first
          # => #<Client id: 1, first_name: "Lifo">
          
          # Sử dụng với order bằng first_name
          client = Client.order(:first_name).first
          # => #<Client id: 2, first_name: "Fifo">
          
          # Sử dụng để lấy một vài object đầu tiên
          client = Client.first(3)
          
          ```
          
          ```sql
          /* SQL tương ứng */
          SELECT * FROM clients ORDER BY clients.id ASC LIMIT 1
          
          SELECT * FROM clients ORDER BY clients.first_name ASC LIMIT 1
          
          SELECT * FROM clients ORDER BY clients.id ASC LIMIT 3
          ```
          
          > 3) Sử dụng `last` (tương tự `first` nhưng thứ tự ngược lại)
          ```ruby
          #
          client = Client.last
          # => #<Client id: 221, first_name: "Russel">
          ```
          
          ```sql
          SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1
          ```
          - Lấy nhiều object (records) từ một table trong database [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html#retrieving-multiple-objects-in-batches)
          Để tránh tình trạng cạn kiệt bộ nhớ RAM do lấy quá nhiều records và chuyển thành object, thông thường ta sử dụng một số method bên dưới để lấy objects theo cụm.
          > 1) Sử dụng `find_each` để lấy nhiều records theo cụm [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html#find-each) . Kết quả matched trả về có thể là **một collection chứa nhiều objects**
          ```ruby
          User.find_each do |user|
            NewsMailer.weekly(user).deliver_now
          end
          ```
          
          - **Sử dụng `where` để thêm điều kiện để lọc ra các record phù hợp [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html#conditions)** 
          > 1) Sử dụng `where` với string trực tiếp
          ```ruby
          # Tránh sử dụng string trực tiếp trong where sẽ bị SQL injection 
          Client.where("orders_count = #{params[:orders]}")
          # Nên dùng cú pháp bên dưới
          Client.where("orders_count = ?", params[:orders])
          ```
          
          
          > 2) Sử dụng `where` với array input. Những dấu `?` sẽ được thay thế bằng giá trị tương ứng theo thứ tự.
          ```ruby
          Client.where("orders_count = ?", params[:orders])
          
          Client.where("orders_count = ? AND locked = ?", params[:orders], false)
          ```
          
          
          > 3) Sử dụng `where` với placeholders
          ```ruby
          Client.where("created_at >= :start_date AND created_at <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
          ```
          
          
          > 4) Sử dụng `where` với hash
          ```ruby
           # So sánh bằng
           Client.where(id: 1)
           SELECT * FROM clients WHERE (clients.id = 1)
           
           # So sánh bao gồm
           Client.where(id: [1,2,3])
           SELECT * FROM clients WHERE clients.locked IN (1, 2, 3)
    
           # So sánh range (thường dùng cho ngày giờ)
           Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
           SELECT * FROM clients WHERE (clients.created_at BETWEEN '2008-12-21 00:00:00' AND '2008-12-22 00:00:00')

           # So sánh phủ định với NOT
           Client.where.not(locked: true)
           SELECT * FROM clients WHERE (clients.locked != 1)
 
           # Thêm điều kiên với OR
           Client.where(locked: true).or(Client.where(orders_count: [1,3,5]))
           SELECT * FROM clients WHERE (clients.locked = 1 OR clients.orders_count IN (1,3,5))
          ```
          
          
          - **Sử dụng `order` thay đổi thứ tự các record trước khi where được apply [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_querying.html#ordering)** 
          > 1) Order 1 column
          ```ruby
          # created_at giảm dần
          Client.order(created_at: :desc)
          Client.order("created_at DESC")
          
          # OR
          # created_at tăng dần 
          Client.order(created_at: :asc)
          Client.order("created_at ASC")
          ```
          
          
          > 2) Order nhiều columns
          ```ruby
          Client.order(orders_count: :asc, created_at: :desc)
          # OR
          Client.order(:orders_count, created_at: :desc)
          # OR
          Client.order("orders_count ASC, created_at DESC")
          # OR
          Client.order("orders_count ASC", "created_at DESC")
          ```

### II. Tạo các loại quan hệ giữa các Models bằng Active Record Associations [(Tham khảo)](https://guides.rubyonrails.org/v5.2/association_basics.html)
  1. #### belongs_to
  2. #### has_one
  3. #### has_many
  4. #### has_one :through
  5. #### has_many :through
  

### III. Tương tác với từng record trong table bằng Active Record [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_basics.html)
  1. #### create
  2. #### read
  3. #### update
  4. #### delete
  5. #### new   ???
  6. #### save  ???
  
  
### IV.  Kiểm tra data với Active Record Validations  [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_validations.html)
  1. #### `valid?` and `invalid?`
  2. #### `errrors`
  3. #### Validation helpers [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_validations.html)
  
### V.   Xử lý các sự kiện với Active Record Callbacks  [(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_callbacks.html)
  Ví dụ cách sử dụng một callback
  ```ruby
  class User < ApplicationRecord
    validates :login, :email, presence: true

    before_validation :ensure_login_has_a_value

    private
      def ensure_login_has_a_value
        if login.nil?
          self.login = email unless email.blank?
        end
      end
  end
  ```
  1. #### Callbacks khi tạo một object
      + before_validation
      + after_validation
      + before_save
      + around_save
      + before_create
      + around_create
      + after_create
      + after_save
      + after_commit/after_rollback
  2. #### Callbacks khi cập nhật một object
      + before_validation
      + after_validation
      + before_save
      + around_save
      + before_update
      + around_update
      + after_update
      + after_save
      + after_commit/after_rollback
  
  3. #### Callbacks khi xóa một object 
      + before_destroy
      + around_destroy
      + after_destroy
      + after_commit/after_rollback
  
  
### VI. Bài tập

