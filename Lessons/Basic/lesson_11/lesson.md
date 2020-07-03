# Buổi 11: Giới thiệu module M - Model trong MVC.

## Nội dung cần học
 - Tương tác với database và tables trong Rails
 - Tạo các loại quan hệ giữa các Models bằng Active Record Associations
 - Tương tác với từng record trong table
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
          > Thay đổi loại data của column `price` t
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
      - **Cách để tạo một model[(Tham khảo)](https://guides.rubyonrails.org/v5.2/active_record_migrations.html#model-generators)**
          - Bạn có thể tạo model bằng cách tạo các file ruby bằng tay hoặc sử dụng model generator được hỗ trợ bởi rails. Xem ví dụ bên dưới
          > Tạo một model để quản lý 1 table có 2 columns: name và description
          ```bash
          # Cú pháp 1
          bin/rails generate model Product name:string description:text
          
          # Cú pháp 2
          bin/rails g model Product name:string description:text
          ```
      - Active Record Query Interface

### II. Tạo các loại quan hệ giữa các Models bằng Active Record Associations
  1. #### xx

### III. Tương tác với từng record trong table
  1. #### Kiểm tra data với Active Record Validations
  2. #### Xử lý các sự kiện với Active Record Callbacks

### IV. Bài tập
  1. xx
