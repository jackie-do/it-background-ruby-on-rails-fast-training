# Buổi 6: Ngôn ngữ Ruby.

## Nội dung cần học
 - Giới thiệu về ngôn ngữ Ruby.
 - Cài đặt Ruby bằng RVM.
 - Giới thiệu về Gem và cách sử dụng.
 - Kiến thức cơ bản về Ruby cần biết
 - Bài tập

-----

### I. Giới thiệu về ngôn ngữ Ruby
1. #### Sơ lược về Ruby
  - Ruby là ngôn ngữ không cần biên dịch tương tự PHP, Javascript, Python ... (khác với các ngôn ngữ cần biên dịch như C#, Java, Golang ...)
  - Ruby được xây dựng trên nền C, sử dụng rất nhiều library C ở nền bên dưới. Về cơ bản chúng ta chỉ cần code dưới cú pháp Ruby nên các bạn cũng không cần quá đề tâm đến điều này.
  - Các file ruby có extension là `.rb`. Ví dụ: `hello_world.rb`
  ```ruby
  # hello_world.rb
  puts 'Hello World'
  ```
  - Ruby là ngôn ngữ lập trình hướng đối tượng OOP, tuy nhiên trong Ruby không hỗ trợ đa kế thừa. Mọi thứ trong Ruby là một object, mọi object là một instance của một class.
  - Trong các ngôn ngữ lập trình khác ta có `function`, `procedure`, `subroutines`, `method` ... để nói về một cụm chức năng nhỏ được gói lại. Trong Ruby ra gọi đó là `method` (bất kể có tham số hay không có tham số)
  ```ruby
  def three_times
    puts 'Hello World!'
    puts 'Hello World!'
    puts 'Hello World!'
  end

  def say_hi name
    puts "Just say hi. #{name}"
  end

  def say_hi(name)
    puts "Just say hi. #{name}"
  end
  ```
  - Ruby có nhiều phiên bản với sự đổi mới về cú pháp, mở rộng các methods nên bạn cần lưu ý phiên bản Ruby bạn đang sử dụng.
    - Ví dụ: Từ phiên 1.9 thì cú pháp của loại data là Hash có bổ sung mới
    ```Ruby
    # old
    { :a => 'value of a' }
    # new
    { a: 'value of a' }
    ```
    - Ví dụ: Từ phiên bản 2.2 thì có thêm cú pháp hỗ trợ gọi hàm và check rỗng
    ```ruby
    # cú pháp sử dụng .&
    method_1&.method_2&.method_3&.[](hash_key)
    ```
  - Ưu điềm của Ruby:
    - Dễ học, dễ đọc, dễ code.
    - Các thư viện (gem) hỗ trợ đầy đủ và rất hoàn thiện.
  - Nhược điềm của Ruby:
    - So về performance thuần tính toán thì không nhanh.
    - Chưa hỗ trợ tốt cho xử lý thread, xử lý đồng thời.
    - Khá tốn Ram so với các ngôn ngữ khác.

### II. Cài đặt Ruby bằng RVM
1. #### Cài đặt RVM
  - Xem cách cài đặt ở đây cho Ubuntu và Mac [(Link)](https://rvm.io/rvm/install)
2. #### Các câu lệnh RVM hay dùng
  - Kiểm tra, xem thông tin
    ```bash
    # Kiểm tra phiên bản của RVM
    rvm -v
    # Kiểm tra các Ruby version đã cài đặt
    rvm list
    # Kiểm tra Ruby version đang sử dụng
    rvm current
    # Kiểm tra Ruby version bằng câu lệnh của Ruby
    ruby -v
    ```
  - Chọn phiên bản ruby để sử dụng
    ```bash
    # Kiểm tra các phiên bản Ruby đã cài đặt
    rvm list
    # Cài đặt thêm một phiên bản Ruby
    rvm install ruby # tự động cài bản mới nhất
    rvm install ruby -v 2.6.3 # cài theo một phiên bản cụ thể
    # Chuyển qua sử dụng một Ruby khác
    rvm use <ruby version>
    rvm use 2.7.0
    # Đặt một phiên bản Ruby làm mặc định
    rvm use --default 2.7.0
    ```
  - Tìm hiểu thêm về Gemset trong RVM. [(Link)](https://rvm.io/gemsets)
  - Tìm hiểu cách chuyển Ruby version và Ruby Gemset tự động khi vào một folder bằng command line [(Link)](https://rvm.io/workflow/projects)
    - lưu ý cách dùng 2 files `.ruby-version` và `.ruby-gemset`

### III. Giới thiệu về Gem và cách sử dụng
1. #### Gem là gì?
  - Gem là một thư viện trong Ruby. Trong Ruby một thư viện được gọi là Gem. Tương tự lib trong C, plugin trong PHP hay package trong NodeJS.
  - Đọc thêm [(Link)](http://www.ruby-lang.org/en/libraries/)
2. #### Quản lý và cài đặt các Gem bằng Bundler
  - `bunlder` bản thân nó cũng là 1 Gem. Nó sẽ giúp ta cài đặt và quản lý các gem trong một Ruby version một cách dễ dàng.
  - Cách sử dụng `bunlder`
    1. Cài gem `bunlder`.
    ```bash
      # Dùng terminal
      gem install bunlder
    ```

    2. Tạo Gemfile, là một file text theo một số cú pháp nhất định, `bundler` sẽ dựa vào file này để quản lý gem file
    ```gemfile
    source 'https://rubygems.org'

    # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
    gem 'rails', '4.2.11'
    # Use mysql as the database for Active Record
    gem 'mysql2', '>= 0.3.13', '< 0.5'
    # Use SCSS for stylesheets
    gem 'sass-rails', '~> 5.0'
    # Use Uglifier as compressor for JavaScript assets
    gem 'uglifier', '>= 1.3.0'
    # parse coffeescript to js
    gem 'coffee-rails'
    ```

    3. Cài đặt gems dựa trên Gemfile.
    ```bash
    # vào cùng thư mục với Gemfile bằng terminal để bunlde
    bundler install # phải đứng cùng thư mục với Gemfile, nếu không phải dẫn path
    ```


### IV. Kiến thức Ruby cần biết
1. #### IRB (Interactive Ruby)
    - Sau khi cài đặt Ruby (cài trực tiếp, cài qua RVM, cài qua Rbenv ...) cách dễ nhất để tương tác với Ruby là dùng `irb` rồi gõ code Ruby thoải mái.
    ```bash
    # Trong terminal gõ irb và enter. bạn sẽ thấy cột bên trái là Ruby version
    irb
    2.3.1 :001 > puts 'Hello World'
    2.3.1 :002 >
    2.3.1 :003 >
    2.3.1 :004 >
    ```
    - Bạn cũng có thể load file ruby và chạy bằng.
    ```bash
      ruby hello_world.rb
    ```
2. #### Cú Pháp của Ruby [(Tham khảo)](https://www.tutorialspoint.com/ruby/index.htm)
    1. Các methods print ra terminal
        - `puts` - In ra một string với dấu xuống dòng
        - `printf` - In ra một string không có dấu xuống dòng

    2. Cú pháp để comment
        - Inline comments
        ```ruby
        # Program for displaying "Hello World!"
        # by Huy Do
        puts 'Hello World!'

        puts 'Hello World!' # another way
        ```
        - Multiline comments
        ```ruby
        puts "Hello, Ruby!"
        =begin
        This is a multiline comment and con spwan as many lines as you
        like. But =begin and =end should come in the first line only.
        =end
        ```


    3. Method
        - Lưu ý về giá trị trả về trong một methods. Ta có thể của động trả về giá trị của method bằng keyword `return` hoặc method sẽ nhận giá trị cuối cùng trong method đó
        ```ruby
        # 2 methods này hoạt động như nhau
        def total(number_1, number_2)
          number_1 + number_2
        end

        def total(number_1, number_2)
          return number_1 + number_2
        end
        ```
        - Phạm vi được sử dụng của các method được chia làm 3 loại: `public`, `private`, `protect` khi được định nghĩa trong một class.

    4. Các loại dữ liệu cơ bản (Classes cơ bản)
        1. String [(Link)](https://www.tutorialspoint.com/ruby/ruby_strings.htm)
            - Có thể tạo ra string trực tiếp hoặc dùng class String
            ```bash
            $ irb
            >> "First test"
            => "First test"
            >> "First test".class
            => String

            >> String.new("Second test")
            => "Second test"
            >> String.new("Second test").class
            => String
            ```
            - Dấu nháy đôi và dấu nháy kép (Single and Double Quotations Marks). Dấu nháy đơn để bọc chuỗi thuần, dấu nhaý kép có thể xử lý giá trị biến trong chuỗi.
            ```bash
            $ irb
            >> a = "blue"
            => "blue"
            >> b = "Color: #{a}"
            => "Color: blue"
            >> exit
            ```
            - String có hỗ trợ một số method sẵn: `class`, `size`, `downcase`, `upcase`, `reverse` ...
        2. Number
            1. Interger (từ Ruby 2.4 mọi số nguyên đều là class Interger)
            ```bash
            $ irb
            >> 23.class
            => Integer
            >> 230000000000000000000.class
            => Integer
            >> (23*10000).class
            => Integer
            >> exit
            ```

            2. Float
            ```bash
            $ irb
            >> a = 20.424
            => 20.424
            >> a.class
            => Float
            >> exit
            ```

            3. Tính toán giữa Integer và Float
            ```bash
            $ irb
            >> a = 10
            => 10
            >> b = 23
            => 23
            >> (a + b).class
            => Integer
            >> (a + 3.13).class
            => Float
            >> exit
            ```
        3. Boolean
            - Lưu ý giá trị `nil` được xem là `false`
        4. Symbol
            - mỗi symbol là một giá trị duy nhất.
            ```ruby
            var_a = :a_symbol
            ```
        5. Range [(Link)](https://www.tutorialspoint.com/ruby/ruby_ranges.htm)
        6. Array [(Link)](https://www.tutorialspoint.com/ruby/ruby_arrays.htm)
            - Array là một collection chứa danh sách các elements theo cấu trúc list. Element có thể là Number, String, Symbol, Hash. Trong một array có thể có nhiều loại element khác nhau.
            - Một sô cách tạo Array
            ```ruby
            # Cách ngắn gọn
            my_array = [1,2,3]
            # Cách dùng class
            my_array = Array.new([1,2,3])
            my_array = Array.new(3, "ruby")

            my_array = ["ruby", 1, "is", 2, "awesome", 3]

            my_array.each do |element|
              puts element
            end
            ```
        7. Hash  [(Link)](https://www.tutorialspoint.com/ruby/ruby_hashes.htm)
            - Hash là một collection chứa elements theo cấu trúc key-value. Key phải là giá trị duy nhất (trong cùng cấp). Key có thể là bất cứ loại object nào: Number, String, Symbol, Hash ... và value cũng vậy
            - Một số cách tạo Hash
            ```ruby
            # Cách ngắn gọn
            my_hash = {}
            # Cách dùng class
            my_hash = Hash.new

            my_hash = Hash.new("No Value")
            my_hash["Non existent key"]
            my_hash = Hash.new("test")
            my_hash["No such key"]

            my_hash = {"jan" => 1, "feb" => 2, "mar" => 3}

            my_hash = {}
            my_hash[:jan] = 1
            my_hash[:feb] = 2
            my_hash[:mar] = 3
            my_hash

            my_hash.each do |key, value|
              puts "#{key} => #{value}"
            end

            ```
        6. Variable [(Link)](https://www.tutorialspoint.com/ruby/ruby_variables.htm)
            - Chuẩn đặt tên (naming convention):
              - Variable, Symbol, Method: sử dụng `snake_case`
              - Constant: chữ cái bắt đầu viết hoa
            - Phạm vị (scope):
              - **Local Variable - var**. Tạo ra ở chỗ nào, sử dụng trong scope đó thôi.
              ```ruby
              # b là local variable, chỉ sử dụng trong method plus_10
              $ irb
              >> a = 1
              >> def plus_10(a)
              >>   b = 10
              >>   a + b
              >> end
              >> a
              => 1
              >> plus_10(a)
              => 11
              >> b
              => error
              ```
              - **Global Variable - $var**. Một khi được tạo ra thì có thể được sử dụng ở mọi nơi. TRÁNH SỬ DỤNG
              ```ruby
              # $a là global variable, có thể sử dụng ở mọi nơi.
              $ irb
              >> $a = 1
              >> def plus_10(a)
              >>   b = 10
              >>   $a + b
              >> end
              >> a
              => 1
              >> plus_10(a)
              => 11
              >> b
              => error
              ```
              - **Instance Variable - @var**. Được tạo ra trong một class và có thể sử dụng ở mọi nơi trong instance class
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
              - **Class Variable - @@var**. Được tạo ra trong một class và có thể được sử dụng ở tất cả instance được tạo ra từ class này và kể cả chính bản thân nó.

    5. Operations [(Tham khảo)](https://www.tutorialspoint.com/ruby/ruby_operators.htm)
        - Các operations tính toán: `+`, `-`, `*`, `/`, `%` ...
        - Các operations so sánh: `==`, `!=`,`>=`, `<=` ...
        - Các operations gán giá trị: `=`, `+=`, `-=`, `*=` ...
        - Các operations về logic: `and`, `or`, `&&`, `||`, `!` ...
        - Operation ba ngôi: `? :`
        - Oparation về range: `..`, `...`
        - Bang methods: các method với dấu chấm ! sẽ thay đổi giá trị gốc `upcase!`, `gsub!` ...
    6. Class và Module [(Class)](https://www.tutorialspoint.com/ruby/ruby_classes.htm) - [(Module)](https://www.tutorialspoint.com/ruby/ruby_modules.htm)
        - Kế thừa giữa các class thế nào?
        - Trong Ruby không hỗ trợ đa kế thừa, nhưng có hỗ trợ mixin module, dùng thế nào?
    7. Các câu lệnh điều kiện [(Link)](https://www.tutorialspoint.com/ruby/ruby_if_else.htm)
        - Câu lệnh với if: `if end`, `if else end`, `if elsif else end`
        - Câu lệnh với unless: `unless end`, `unless else end`
        - Câu lệnh với case: `case when end`, `case when else end`
        - Toán tử 3 ngôi: `expression ? value_when_true : value_when_false`
    8. Các vòng lặp
        1. `while`. Ngừng chạy khi expression là false
        ```ruby
        while expression do
          program
        end

        # Ví dụ
        i = 0
        while i < 3 do
          puts i
          i = i + 1
        end
        ```
        2. `until`. Ngừng chạy khi expression là true
        ```ruby
        until expression
          program
        end

        # Ví dụ
        i = 5
        until i == 0
          i = i - 1
          puts i
        end
        ```
        3. `for`
        ```ruby
        for  x  in 0..5
          if  x > 2 then
              break
          end
          puts  "Value of  x is  #{x}"
        end
        ```
    9. Iterator [(Link)](https://www.tutorialspoint.com/ruby/ruby_iterators.htm)
        - Các methods hỗ trợ làm việc với array/hash: `each`, `each_with_index`, `map`, `reject`, `filter`...

    10. Block [(Link)](https://www.tutorialspoint.com/ruby/ruby_blocks.htm)

### V. Bài tập
  1. Cài đặt RVM và cài đặt Ruby phiên bản 2.6.3
  2. Tìm hiểu về cách kế thừa giữa các Class trong Ruby.
  3. Phân biệt được cách sử dụng và scope của `public`, `private`, `protected` trong Ruby.
  4. Cách sử dụng Module trong Ruby. Sử dụng mixin là thế nào? Cách sử dụng các methods `include`, `extend` và `prepend` để "nhét" một Module vào trong một Class.
  5. Làm quen với các loại dữ liệu phổ biến: String, Number, Array, Hash.
  6. Làm quen với các Iterator phổ biến: `each`, `map`, `reject`, `filter`.


