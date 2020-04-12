# Buổi 2: Học về HTML và CSS

## Nội dung cần học
 - Học cách sử dụng HTML
 - Học cách sử dụng CSS
 - Bài tập

-----

### I. Sử dụng HTML
1. #### HTML là gì? Cú pháp HTML? Các thành phần quan trọng?
  - HTML(Hypertext Markup Language) là ngôn ngữ đánh dấu cho các trang web. Dùng để đặc tả định dạng, cấu trúc cho text(đa phần) và hình ảnh/video (một ít) trên một trang web. Kết hợp với CSS ta sẽ có một trang web lung linh. HTML dùng để định hình "khung xương" của một trang web, còn CSS tô vẻ "bề ngoài" của trang web đó.
  - Cấu trúc một trang HTML đơn giản [(Link tham khảo)](https://www.w3schools.com/html/default.asp)
```HTML
 <!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>This is a Heading</h1>
<p>This is a paragraph.</p>

</body>
</html>
```
  - HTML cơ bản là một file text, được viết theo cú pháp HTML và có đuôi file là `.html` . Ta có thể đọc file này bằng các trình duyệt phổ biến như Chrome, Firefox, Edge, Opera, Safari ...
  - HTML có các thành phần quan trọng cần biết:
    - HTML elements, bao gồm: tag mở, tag đóng và content ở giữa tag mở và đóng. Một số element cần tag đóng, một số element không cần. Sẽ gọi chung HTML elements = HTML tag [(Link tham khảo)](https://www.w3schools.com/html/html_elements.asp)
    - HTML attributes, là các thuộc tính của HTML elements. Mỗi loại HTML element sẽ có các thuộc tính khác nhau [(Link tham khảo)](https://www.w3schools.com/html/html_attributes.asp)
    - HTML styles, là một thuộc tính đặc biệt của HTML element, dùng để đặc tả style của một element dựa trên CSS inline. [(Link tham khảo)](https://www.w3schools.com/html/html_styles.asp)

2. #### Các loại HTML element/tag?
  - HTML structure elements, những tag bắt buộc phải có của một trang web:
    - DOCTYPE `<!DOCTYPE html>`
    - html `<html> </html>`
    - head `<head> </head>`
    - body `<body> </body>`
  - HTML head element, chứa những meta data cho một trang web. Element này không được hiển thị cho người dùng. Chứa các tags sau
    `<title> </title>`, `<style>`, `<meta>`, `<link>`, `<script>` và `<base>` [(Link tham khảo)](https://www.w3schools.com/html/html_head.asp)
```HTML
 <!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="description" content="Free Web tutorials">
  <meta name="keywords" content="HTML, CSS, XML, JavaScript">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>Page Title</title>
   <style>
      body {background-color: powderblue;}
      h1 {color: red;}
      p {color: blue;}
  </style>
   <link rel="stylesheet" href="mystyle.css">

  <script>
    function myFunction {
      document.getElementById("demo").innerHTML = "Hello JavaScript!";
    }
  </script>
</head>

<body>
  Background of body element will be powderblue
  <h1 id="demo"> This text is red</h1>
  <p> This text is blue </p>
</body>

</html>
```
  - HTML layout elements, gồm các tags được bố cục với nhau để xây dựng một trang web. Chứa các tags sau: `<header> </header>`, `<nav> <nav>`, `<section> </section>`, `<article> </article>`, `<aside> </aside>`, `<footer> </footer>`. Về cơ bản các tagg này không khác với `<div> </div>` nhưng nó có ý nghĩa gợi nhớ và tốt cho SEO [(Link tham khảo)](https://www.w3schools.com/html/html_layout.asp)
  - HTML CSS element, là tag dùng để chèn CSS vào HTML. Có 3 cách để sử dụng CSS trong HTML [(Link tham khảo)](https://www.w3schools.com/html/html_css.asp)
    - Inline - Sử dụng attribute `style` trong HTML tag.
    - Internal - Sử dụng HTML tag `<style> </style>` trong `<head>` để đặc tả CSS.
    - External - nhúng file css bên ngoài sử dụng HTML tag `<link>`
  - HTML file paths, dùng để hiển thị các files (ảnh, video, audio ...) trên một trang web [(Link tham khảo)](https://www.w3schools.com/html/html_filepaths.asp)


3. #### HTML attribute là gì? HTML attribute phổ biến?
- Mỗi HTML element/tag để được hỗ trợ một số attribute nhất định. Một số tag sẽ có các attributes khác với tag còn lại. [(Link tham khảo)](https://www.w3schools.com/html/html_attributes.asp)
- Các attribute phổ biến mà gần như tag nào cũng có là:
  - `class` - dùng để xếp loại 1 tag thuộc class nào, thường dùng cho đặc tả CSS
  - `id` - dùng để định danh duy nhất, không trùng lặp với tất cả các tags khác
  - `name` - dùng để định danh, khi gửi dữ liệu lên server
  - `style` - dùng để đặc tả CSS inline

### II. Sử dụng CSS
1. #### CSS là gì? Cú pháp CSS?
  - CSS là ngôn ngữ để mô tả style cho các HTML element.
  - Cú pháp của CSS [(Link tham khảo)](https://www.w3schools.com/css/css_syntax.asp)
```CSS
body {
  background-color: lightblue;
}

h1 {
  color: white;
  text-align: center;
}

p {
  font-family: verdana;
  font-size: 20px;
}
```
  - Có 3 cách để sử dụng CSS trong HTML
    - Inline - Sử dụng attribute `style` trong HTML tag.
    - Internal - Sử dụng HTML tag `<style> </style>` trong `<head>` để đặc tả CSS.
    - External - nhúng file css bên ngoài sử dụng HTML tag `<link>`
2. #### Lưu ý độ ưu tiên khi sử dụng CSS
  - ID là duy nhất và có độ ưu tiên cao hơn Class khi mô tả HTML element bằng CSS.

3. #### CSS Selectors là gì? Cách sử dụng?
  - CSS Selector để tìm HTML element bạn muốn style. [(Link tham khảo)](https://www.w3schools.com/css/css_selectors.asp)
  - CSS Selector có 5 loại:
    - **Simple selectors** (tìm và style các HTML element dựa trên attribute `name`, `id`, `class`)
    - **Combinator selectors** (tìm và style các HTML elements dựa trên mỗi quan hệ của các HTML elements với nhau)
    - **Pseudo-class selectors** (tìm và style các HTML elem elements dựa trên trạng thái của HTML element: đang được trỏ chuột-hover, đã click-clicked ...)
    - **Pseudo-elements selectors** (tìm và style cho một phần của một HTML element)
    - **Attribute selectors** (tìm và style dựa trên attribute của một HTML element)

4. #### CSS Properties là gì? Cách sử dụng?
  - Có rất rất nhiều CSS properties để sử dụng, bạn nên vào link tham khảo để xem các thuộc tính này [(Link tham khảo)](https://www.w3schools.com/css/default.asp)
  - Việc làm quen và sự dụng CSS properties đòi hỏi bạn phải bỏ thời gian học tập và học thuộc.
  - Mình sẽ gom cụm một số CSS properties quen thuộc:
    - Làm việc với màu sắc nói chung [(Link tham khảo)](https://www.w3schools.com/css/css3_colors.asp)
    - Làm việc với chữ:
      - Màu sắc và khoảng cách [(Link tham khảo)](https://www.w3schools.com/css/css_text.asp)
      - Font chữ [(Link tham khảo)](https://www.w3schools.com/css/css_font.asp)
    - Tạo bố cục:
      - Box model - Cấu trúc bố cục của một HTML element [(Link tham khảo)](https://www.w3schools.com/css/css_boxmodel.asp)
      - Border - Đường biên bên ngoài HTML element [(Link tham khảo)](https://www.w3schools.com/css/css_border.asp)
      - Margin - Khoảng cách từ border element này tới border element khác [(Link tham khảo)](https://www.w3schools.com/css/css_margin.asp)
      - Padding - Khoảng cách từ border element tới content bên trong element [(Link tham khảo)](https://www.w3schools.com/css/css_padding.asp)
      - Heigh/Weight - Chiều cao và độ dài của element [(Link tham khảo)](https://www.w3schools.com/css/css_dimension.asp)
      - Flexbox - Bố cục vị trí ngang dọc cho các elements [(Link tham khảo)](https://www.w3schools.com/css/css3_flexbox.asp)
      - Grid - Bố cục vị trí theo lưới cho các elements[(Link tham khảo)](https://www.w3schools.com/css/css_grid.asp)
    - Tạo mối quan hệ giữa các HTML elements:
      - Position - Mối quan hệ trừu tượng giữa các elements [(Link tham khảo)](https://www.w3schools.com/css/css_positioning.asp)
    - Xử lý với các kích thước màn hình hiển thị khác nhau:
      - Media Query - Thay đổi CSS cho các màn hình khác nhau [(Link tham khảo)](https://www.w3schools.com/css/css3_mediaqueries.asp)
    - Hiệu ứng chuyển động:
      - Animations [(Link tham khảo)](https://www.w3schools.com/css/css3_animations.asp)
      - Transitions [(Link tham khảo)](https://www.w3schools.com/css/css3_transitions.asp)


### III. Bài tập
  1. HTML - Tạo trang web offline đầu tiên bằng HTML. [(Demo)](./exercises/exercise_01.html)
  2. HTML - Thêm metadata vào trang web ở bài tập 1. [(Demo)](./exercises/exercise_02.html)
  3. HTML - Kiểm tra lỗi HTML bằng [**Validator**](https://validator.w3.org/). [(Demo)](./exercises/exercise_03.html)
  4. CSS - Sử dụng CSS cho một trang HTML bằng CSS Internal và CSS Inline. [(Demo)](./exercises/exercise_04.html)
      -  Lưu ý: độ ưu tiên của CSS thông thường sẽ theo thứ tự **CSS Inline > CSS Internal > CSS External**
  5. CSS - Sử dụng CSS cho một trang HTML bằng CSS External [(Demo)](./exercises/exercise_05.html)

> Note: Các bạn có thể dùng tool [Validator](https://validator.w3.org/#validate_by_upload) để kiểm tra lỗi HTML của mình bằng cách upfile lên và check.

