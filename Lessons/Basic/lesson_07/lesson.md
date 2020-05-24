# Buổi 7: Làm bài tập với Ruby

## Nội dung cần học
 - Ôn lại các loại dữ liệu phổ biến từ bài trước
 - Làm quen với việc sử dụng Iterator
 - Nhắc về Block
 - Lập trình hướng đối tượng trong Ruby (OOP)
 - Bài tập

-----

### I. Ôn lại các loại dữ liệu phổ biến từ bài trước
1. #### String
2. #### Number
3. #### Boolean
4. #### Symbol
5. #### Range
6. #### Array
7. #### Hash

### II. Làm quen với việc sử dụng Iterator
1. #### Each


### III. Nhắc về Block


### IV. Lập trình hướng đối tượng trong Ruby (OOP)
  - Lập trình hướng đối tượng - Object Orientation Programming không phải là hướng phát triển duy nhất nhưng có là một trong nhưng hướng phổ biến nhất bên cạnh: Procedural Style như C hoặc Functional Programming như Golang ...
  - Có một khái niệm cần lưu ý: **Mọi thứ trong Ruby đều là object**
      - Mọi thứ đều có methods và các tính chất phổ biến của OOP

1. #### Ôn lại các khái niệm cơ bản của OOP trong Ruby
    1. Tính đóng gói (encapsulation) và che giấu thông tin (information hiding)
        - Bảo vệ, giới hạn những thứ được nào được truy cập hoặc tác động nói nôm na là: xem hoặc sửa
        - Nếu được truy cập thì sẽ được giới hạn bởi phạm vi truy cập: `public`, `private`, `protected`
        ```ruby
          # Define object Dog
          class Dog
              attr_accessor :weight, :height
              attr_reader :price
              # attr_writer

            def initialize(weight, height, price, birth_day)
              @weight = weight
              @height = height
              @price = price
              @birth_day = birth_day
            end

            def update_price(new_price)
              @price = new_price
            end

            def print_year_old
              p "This dog is #{calculate_year_old} year old"
            end

            private

            def calculate_year_old
              Time.now.to_date.year - @birth_day.year
            end

            protected
          end

          # Code for Testing
          require 'date'
          birth_day = Date.parse('1995-01-01').to_date
          a_dog = Dog.new(40, 1.2, 50_000, birth_day)
          a_dog.price
          a_dog.weight
          a_dog.height
          a_dog.calculate_year_old
          a_dog.print_year_old

          a_dog.instance_variables
        ```
    2. Tính kế thừa
        - Class con sẽ kế thừa được các thuộc tính và method (được cho phép) từ class cha để sử dụng lại
        - Lưu ý cách sử dụng keyword `super` (gọi lại toàn bộ xử lý và kết quả của method cha)
          ```ruby
          class Person
            def initialize(name)
              @name = name
            end

            def name
              return @name
            end
          end

          class Doctor < Person
            def name
              "Dr. " + super
            end
          end
          ```
    3. Tính đa hình (Overwrite và Overload)
        - Trong Ruby cho phép overwrite method
          ```ruby
          "This is a string".length
          class String
            def length
              20
            end
          end

          "This is a string".length
          ```
        - Cơ bản thì Ruby không hỗ trợ overload như các ngôn ngữ khác (cùng 1 method name nhưng có số lượng parameters khác nhau từng method)
          ```ruby
          # Đây chỉ là trick, không phải official Overload
          class Customer
            def self.display_info(*args)
              case args.size
              when 1
                puts "Their name is #{args[0]}"
              when 2
                puts "Their name is #{args[0]} #{args[1]}"
              when 3
                case args[2].class.name
                when String
                  puts "Their name is #{args[0]} #{args[1]} and their email address is #{args[2]}"
                when Integer, Fixnum
                  puts "Their name is #{args[0]} #{args[1]} and they are #{args[2]} years old"
                end
              end
            end
          end

          # Code for testing
          Customer.display_info("John")
          Customer.display_info("John", "Smith");
          Customer.display_info "John", "Smith", "j.smith@medium.com"
          Customer.display_info "John", "Smith", 34
          ```
    4. Tính trừu tượng
        - Trừu tượng hoá một đối tượng, chuyển đổi các thuộc tính, method của đối tượng thực tế thành class trong code. Xây dựng các thuộc tính và method cốt lõi của class.
        - Tính đa hình được sử dụng khá ít trong ruby vì trong Ruby không có abtract class type như Java hay C# thay vào đó ta xây dựng 1 class như interface và cho class khác kế thừa.

2. #### Phạm vi các biến (variable trong ruby)
    - Chuẩn đặt tên (naming convention):
        - Variable, Symbol, Method: sử dụng `snake_case`
        - Constant: chữ cái bắt đầu viết hoa
    1. **Local Variable - var**. Tạo ra ở chỗ nào, sử dụng trong scope đó thôi.
      ```ruby
      # b là local variable, chỉ sử dụng trong method plus_10
      $ irb
      a = 1
      def plus_10(a)
        b = 10
        a + b
      end
      a
      plus_10(a)
      b
      ```
    2. **Global Variable - $var**. Một khi được tạo ra thì có thể được sử dụng ở mọi nơi. TRÁNH SỬ DỤNG
      ```ruby
      # $a là global variable, có thể sử dụng ở mọi nơi.
      $ irb
      $a = 1
      def plus_10(a)
        b = 10
        $a + b
      end
      a
      plus_10(a)
      ```
    3. **Instance Variable - @var**. Được tạo ra trong một class và có thể sử dụng ở mọi nơi trong instance class
      ```ruby
      # @color là instance variable
      class Wall
        def initialize
          @color = 'white'
        end

        def color
          @color
        end
        def paint_it(value)
          @color = value
        end
      end
      ```
    4. **Class Variable - @@var**. Được tạo ra trong một class và có thể được sử dụng ở tất cả instance được tạo ra từ class này và kể cả chính bản thân nó.
      ```ruby
      class Square

        def initialize
          if defined?(@@number_of_squares)
            @@number_of_squares += 1
          else
            @@number_of_squares = 1
          end
        end

        # Class methods
        def self.count
          @@number_of_squares
        end
      end

      # Code for testing
      a = Square.new
      b = Square.new
      puts Square.count
      ```
1. #### Sử dụng Class
    1. Kế thừa trong các Class
      - Sử dụng dấu `<` để định nghĩa một class kết thừa một class khác
      ```ruby
      class ParentClass
        def method1
          puts "Hello from method1 in the parent class"
        end

        def method2
          puts "Hello from method2 in the parent class"
        end
      end

      class ChildClass < ParentClass
        def method2
          puts "Hello from method2 in the child class"
        end
      end

      my_object = ChildClass.new
      my_object.method1
      my_object.method2
      ```

    2. Scope của các methods: public, private, protected
        - **Public Methods**
            - Đây là level mặc định cho mọi methods nếu không có đặc tả thêm. Public method có thể được gọi từ bên ngoài, không bị giới hạn.
          ```ruby
          class User
            def initialize(email)
              @email = email
            end

            def email
              @email
            end
          end

          # Example:
          # email có thẻ được gọi từ bên ngoài

          user = User.new("jk@gmail.com")
          user.email
          ```
        - **Private Methods**
            - Chỉ có thể được gọi bên trong class. *Lưu ý: khác với một số ngôn ngữ khác, private methods có thể kế thừa được*
          ```ruby
          class BankAccount
            attr_accessor :transactions

            def balance
              calculate_balance
            end

            private

            def calculate_balance
              transactions.inject(0){|sum, txn| sum + txn }
            end
          end

          # Example:
          #

          b = BankAccount.new
          b.transactions = [20, -10, 30, -15]
          b.balance
          b.calculate_balance
          ```
        - **Protected Methods**
            - Khá giống với private, protected không thể gọi trực tiếp từ bên ngoài mà chỉ sử dụng ở bên trong. Sự khác biệt của protected và private nằm ở `self`. Nếu không dùng self ta sẽ tìm gọi method từ class, còn nếu dùng self ta sẽ gọi từ object.
            - Protected methods có thể được gọi trong các subclass (các class kế thừa) nhưng không thể gọi được từ các class khác
          ```ruby
          # Ví dụ về self
          class User

            def call_each
              public_method
              protected_method
              private_method
            end

            def call_each_with_self
              self.public_method
              self.protected_method
              self.private_method
            end

            def public_method
              puts "This is a public method"
            end

            protected
            def protected_method
              puts "This is a protected method"
            end

            private
            def private_method
              puts "This is a private method"
            end
          end

          # Example
          user = User.new
          user.call_each
          user.call_each_with_self
          ```

          ```ruby
          # Ví dụ về subclass
          require 'digest'
          class User
            def initialize(email)
              @email = email
            end

            def ==(other)
              self.unique_id == other.unique_id
            end
            protected

            def unique_id
              Digest::MD5.hexdigest @email.downcase
            end
          end

          # Example
          u = User.new("test@example.com")
          u2 = User.new("foo@example.com")
          u3 = User.new("TesT@EXAMPLE.COM")
          u == u2
          u == u3

          class Admin < User
          end

          class Department
            def initialize(name)
              @name = name
            end

            protected
            def unique_id
              Digest::MD5.hexdigest @name.downcase
            end
          end

          # Example
          admin = Admin.new("admin@example.com")
          admin2 = Admin.new("test@example.com")
          u == admin
          u == admin2
          u == sales

          ```


1. #### Sử dụng Module
  1. Sử dụng mixin và lưu ý

### V. Bài tập
  1. Làm quen với Number
      - Interger - Thực hiện những operations phổ biến (gõ `2.methods` để biết tất cả các methods có sẵn)
          - `+`, `-`, `*`, `/` ...
          - `next` - lấy giá trị interger tiếp theo và `pred` - lấy giá trị integer trước đó
          ```ruby
          #
          2.next
          #
          3.pred
          ```
          - `lcm` - lấy bội số chung nhỏ mất và `gcd` - lấy mẫu số chung lớn nhất giữa 2 số
          ```ruby
          #
          2.lcm(3)
          #
          2.gcd(3)
          ```
      - Float - Thực hiện những methods phổ biến (gõ `2.1.methods` để biết tất cả các methods có sẵn)
          - Làm tròn số: `ceil` - làm tròn lên, `floor` - làm tròng xuống, `round` - tự động làm tròn
          ```ruby
          num = 2.339
          num.ceil
          num.floor
          num.round

          num = 2.50
          num.round
          ```
  2. Làm quen với String  (gõ `'a string'.methods` để biết tất cả các methods có sẵn)
      - Sử dụng các phương pháp phổ biến: `size`, `length`, `upcase`, `downcase`, `capitalize`
      ```ruby
      title = 'ruby Fundamentals'
      title.size
      title.length
      a = title.upcase
      b = title.downcase
      c = title.capitalize
      title
      ```
      - Sử dụng một số phương pháp phổ biết kết hợp dấu than (bang methods - thay đổi giá trị ban đầu): `upcase!`, `downcase!` ...
      ```ruby
      title = 'ruby Fundamentals'
      title.upcase!
      title
      ```
      - Những cách nối chuỗi phổ biến: `+`, `concat`, `<<`
      ```ruby
      var_1 = 'Ruby'
      var_2 = 'Fundamentals'
      # cách dùng + (sẽ tạo ra một string mới rồi gán string đó cho title)
      title = var_1 + '' + var_2
      # cách dùng .concat (lưu ý giá trị var_1 đã bị thay đổi)
      title = var_1.concat(var_2)
      var_1
      # cách dùng << (không tạo string mới)
      var_1 = 'Ruby'
      var_2 = 'Fundamentals'
      title = ''
      title << var_1
      title << ' '
      title << var_2
      ```
      - Sử dụng string interpolation (sử dụng giá trị của biến/phép tính strong string). Lưu ý String phải bọc bằng dấu nháy đơn
      ```ruby
      var_1 = 'Ruby'
      var_2 = 'Fundamentals'
      title = "#{var_1} #{var_2}"

      calculation_result = "Result of 1 + 2: #{1+2}"
      ```
      - Làm việc với substring: lấy một phần của string, kiểm tra tồn tại
      ```ruby
      # string có thể được xem như một mảng các ký tự
      quote = 'Just Do IT'
      # từ ký tự thứ 8, lấy 2 ký tự
      quote[8, 2]
      # Kiểm tra một chuỗi phụ có tồn tại
      quote.include?('Just')
      quote.include?('just')
      ```
      - Thay thế một phần của String bằng một phần khác: `[]`, `gsub`, `gsub!`
      ```ruby
      # thay thế chuỗi khớp đầu tiên
      title = 'Java - My favorite book is Java Fundamentals'
      title["Java"] = 'Ruby'
      title
      #
      title = 'Java - My favorite book is Java Fundamentals'
      title.gsub("Java", "Ruby")
      title
      ```
      - Tách chuỗi và nối chuỗi: `split`, `join`, `split!`, `join!`
      ```ruby
      title = 'My Favorite book is Ruby Fundamentals, interesting?'
      # default ngắt bằng ký tự space
      title.split
      months = 'Jan; Feb; Mar'
      months.split(';')

      data = ['My', 'Favorite', 'book', 'is', 'Ruby', 'Fundamentals']
      data.join
      data.join(' ')
      ```

  3. Làm quen với Array  (gõ `[1,2,3].methods` để biết tất cả các methods có sẵn)
      - Thực hiện các operations phổ biến: tính số phần tử,  merge, remove, insert phần tử mới, find phần tử cuối cùng và xoá.
      ```ruby
      # tính số phần tử
      colors_1 = ['violet', 'indigo', 'blue', 'green']
      colors_2 = ['yellow', 'violet', 'orange', 'red', 'violet']
      colors_1.size
      colors_1.length
      # merge 2 arrays dùng + hoặc concat
      colors_3 = colors_1 + colors_2
      colors_1
      colors_3 = colors_1.merge(colors_2)
      colors_1
      # remove
      colors_repeated = ['violet']
      colors_new = colors_3 - colors_repeated
      # insert phần tử mới
      colors_1.push('yellow')
      colors_1.push('red')
      colors_2.push('green')
      colors_2.push('blue')
      # Lấy phần tử cuối với last và lấy và xoá với pop
      colors_1 = ['violet', 'indigo', 'blue', 'green']
      colors_1.last
      colors_1
      colors_1.pop
      colors_1
      ```

      - Tạo một mảng không thể chỉnh sửa: dùng `freeze`
      ```ruby
      my_array  = [1,2,3]
      my_array.freeze
      my_array << 4
      ```

      - Tìm lấy các phần tử duy nhất không trùng trong mảng: `uniq`, `uniq!`
      ```ruby
      my_array  = [1,2,3, 4,3,2]
      unique_array = my_array.uniq
      my_array
      ```

      - Sort trong mảng: `sort`, `sort!`
      ```ruby
      my_array = [3,6,23, 1]
      my_array.sort
      my_array.sort.reverse
      ```

      - Kiểm tra 1 element có tồn tại trong mảng: `include?`, `match`
      ```ruby
      my_array = ["I", "like", "ruby"]
      my_array.include?("ruby")
      my_array.include?("Ruby")
      ```

      - Chuyển đổi một mảng thành string: `join`
      ```ruby
      my_array = ["I", "love", "ruby"]
      my_array.join(",")
      my_array.join(" ")
      ```

  4. Làm quen với Hash
      - Thực hiện các operations phổ biến: lấy giá trị dựa trên key, set giá trị mới, sorting, merge, list keys hoặc values, xoá giá trị theo key
      ```ruby
      month_hash_1 = { jan: 1, feb: 2, mar: 3 }
      month_hash_2 = { :jan => 1, :feb => 2, :mar => 3 }
      month_hash_3 = { 'jan' => 1, 'feb' => 2, 'mar' => 3 }

      # Lấy giá trị dựa trên key
      month_hash_1[:jan]
      month_hash_1[:april]
      month_hash_2[:jan]
      month_hash_3['jan']

      # Set giá trị mới
      month_hash_1[:jan] = 13
      month_hash_1
      month_hash_1[:april] = 4
      month_hash_1
      month_hash_1['may'] = 5

      # Sorting
      people_hash = { nam: 30, thom: 20, vy: 18, van: 22 }
      people_hash.sort_by { |name, age| age }
      people_hash.sort_by { |name, age| age }.reverse

      people_hash_2 = { nam: { name: "Nam", age: 30 }, thom: { name: "Thơm", age: 20 }, vy: { name: "Vy", age: 18 }, van: { name: "Văn", age: 22 }}
      people_hash_2.sort_by { |key, value| value[:age] }

      # Merging
      my_hash_1 = {a: 10, b: 20}
      my_hash_2 = {c: 30, d: 40}
      my_hash_1.merge(my_hash_2)
      my_hash_1
      my_hash_1.merge!(my_hash_2)

      # List keys hoặc values của một hash
      people_hash = { nam: 30, thom: 20, vy: 18, van: 22 }
      people_hash.keys
      people_hash.values

      # Xoá giá trị theo key
      people_hash = { nam: 30, thom: 20, vy: 18, van: 22 }
      people_hash.delete(:thom)
      people_hash
      people_hash.delete(:vy)
      people_hash

      ```

      - Loại bỏ các phần tử khỏi hash
      ```ruby
      people_hash = { nam: 30, thom: 20, vy: 18, van: 22 }
      people_hash.reject { |key, value| value < 20 }
      people_hash
      people_hash.reject! { |key, value| value < 20 }
      people_hash
      ```
  5. Tạo email dựa trên input nhập từ người dùng.
      - Sử dụng `gets.chomp` để nhận input từ người nhập.
      - Nhập first_name và last_name.
      - Xuất ra email với format `first_name + last_name + @ + crosstech.com`
  6. Chuyển đổi một chuỗi thời gian thành một hash (Sử dụng kiến thức String, Array và Hash)
      - Input
      ```ruby
      my_string_time = "00:05:23.323"
      my_hash_time = {}
      ```
      - Output
      ```ruby
      # my_hash_time
      {"hh"=>"00", "mm"=>"05", "ss"=>"23", "s"=>"323"}
      ```