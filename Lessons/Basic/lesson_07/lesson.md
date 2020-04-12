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

### III. Nhắc về Block


### IV. Lập trình hướng đối tượng trong Ruby (OOP)
1. #### Sử dụng Class
  1. Kế thừa trong các Class
  2. Scope của các methods: private, public, protected
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
  5. Chuyển đổi một chuỗi thời gian thành một hash (Sử dụng kiến thức String, Array và Hash)
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