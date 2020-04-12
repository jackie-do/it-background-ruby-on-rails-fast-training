# Buổi 3: Nói về SCSS (SASS), giới thiệu về các CSS Framework phổ biến

## Nội dung cần học
 - SCSS là gì ? Cú pháp và cách sử dụng
 - Các CSS framework phổ biến
 - Bài tập
 - Sách tham khảo

-----

### I. SCSS và cách sử dụng
1. #### CSS Preprocessor là gì?
    - CSS Preprocessor là ngôn ngữ tiền xử lý của CSS, về cơ bản nó cho phép bạn viết CSS dưới một cú pháp khác gần giống với CSS rồi complie nó ra CSS thuần.
    - Có rất nhiều CSS Preprocessor phổ biến như: `SASS`, `LESS`, `Stylus` ... CSS Preprocessor mình muốn nói đến trong bài này là **`SASS`**
    - Từ phiên bản 3.0, SASS có cú pháp mới là SCSS rất gần gủi với cú pháp CSS thuần, giúp viết dễ dàng hơn.
    - Tất cả các file CSS được viết theo SCSS thì có extension là `.scss`

2. #### Cú pháp và cách sử dụng
    ```html
    <!-- HTML để demo -->
    <div class="container">
      <div class="row">
          <div class="navbar col-12">
              <a class="brand">Viblo</a>
              <ul class="menu">
                  <li><a href="#">Menu 1</a></li>
                  <li><a href="#">Menu 2</a></li>
              </ul>
          </div>
      </div>
    </div>
    ```
    1. Nested rule (xếp chồng) - Đây là quy tắc được sử dụng phổ biến nhất
        - Dùng CSS thuần:
          - Giả sử bạn chỉ muốn CSS cho thẻ ul với class menu, với CSS thuần bạn viết
          ```css
          .navbar ul.menu {
            list-style: none;
          }
          ```
          - Nếu bạn tiếp tục muốn CSS cho thẻ li trong thẻ ul (có class là menu) thì
          ```css
          .navbar ul.menu li {
            padding: 5px;
          }

          ```
        - Dùng SCSS, cho phép lồng các class/id con trong class/id cha
            - Viết dưới dạng SCSS
            ```SCSS
            .navbar {
                ul.menu {
                    list-style: none;

                    li {
                        padding: 5px;

                        a {
                            text-decoration: none;
                        }
                    }
                }
            }
            ```
            - Được compile ra CSS thuần
            ```css
            .navbar ul.menu {
                list-style: none;
            }
            .navbar ul.menu li {
                padding: 5px;
            }
            .navbar ul.menu li a {
                text-decoration: none;
            }
            ```

    2. Variable (Biến)
        - Biến có thể được dùng để chứa giá trị sử dụng nhiều lần như mã màu, font, kiểu chữ. Để khai báo một biến chúng ta sử dụng `$`.
        ```SCSS
        $whiteColor = #fff;
        .navbar {
            ul.menu {
                list-style: none;

                li {
                    padding: 5px;

                    a {
                        text-decoration: none;
                        color: $whitecolor
                    }
                }
            }
        }
        ```

    3. Mixin
        - Gán nhiều thuộc tính nào đó thành một mixin. Khi sử dụng include vào. Sử dụng key `@mixin` và `@include`.
        ```SCSS
        // Cách 1, sử dụng không cần tham số
        @mixin colorVsFont {
            color: #fff;
            font-size: 50px;
        }

        .navbar {
            ul.menu {
                list-style: none;

                li {
                    padding: 5px;

                    a {
                        text-decoration: none;
                        @include colorVsFont;
                    }
                }
            }
        }
        // Cách 2, sử dụng có tham số
        @mixin colorVsFont($color, $fontSize) {
            color: $color;
            font-size: $fontSize;
        }

        .navbar {
            ul.menu {
                list-style: none;

                li {
                    padding: 5px;

                    a {
                        text-decoration: none;
                        @include colorVsFont(#000, 50px);
                    }
                }
            }
        }
        ```
    4. Import và Extends
        - Import: tạo nhiều file scss nhỏ rồi import vào file scss lớn sử dụng key `@import`
        ```SCSS
        // giả sử có 3 files: header.scss, body.scss và footer.css cùng cấp với file cần import
        @import 'header';
        @import 'body';
        @import 'footer';
        ```

        - Extends (Kế thừa): định nghĩa ra một class, nếu class khác cần sử dụng thì extends bằng class kia. Tái sử dụng
        ```SCSS
        .title-box {
            color: #dacb46;
            text-shadow: 1px 1px 1px #1a1a1a;
            display: inline-block;
            text-transform: uppercase;
        }

        .navbar {
            ul.menu {
                list-style: none;

                li {
                    padding: 5px;

                    a {
                        text-decoration: none;
                        @extend .title-box;
                    }
                }
            }
        }
        ```

### II. Các CSS framework phổ biến
1. #### Bulma
    1. Giới thiệu về Bulma ([Trang chủ](https://bulma.io/))
        - Là một open source CSS framework, được sử dụng để design web. Sử dụng các CSS built-in components để thiết kế mobile-first design.
    2. Cài đặt Bulma
        - Cách 1: Download từ trang [bulma.io](https://bulma.io/) và include vào trang HTML để sử dụng
        - Cách 2: Chèn link vào HTML
        ```HTML
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">
        ```
        - Cách 3: Cài đặt Bulma bằng npm


    3. Tự học Bulma [(Link Tham Khảo)](https://bulma.io/documentation/)
        - Grid layout
            - Adding Custom Width
            - Multiline Columns
            - Gaps
            - Nested Columns
            - Offsets
        - Utility Classes
            - Color Modifiers
            - Alignment Helpers
            - Responsive Helpers
            - Typography Helpers

        - Layout CSS helpers
            - Containers and Levels
            - Media Object
            - Banners
            - Cards and tiles
            - Callout Panels and Box
            - Incorporating Footers

        - Navigation and Media components
            - Navigation components
                - Breadcrumbs
                - Drop-Downs
                - Tabs
                - Navbar
            - Media Components
                - Progress Bars
                - Notifications
                - Images
                - Tags
                - Pagination
        - CSS Components and Forms
          - Buttons
          - Icons
          - Content Wrapper
          - Modals
          - Forms

2. #### Bootstrap (tự học - [Link Tham Khảo](https://getbootstrap.com/docs/4.4/getting-started/introduction/) )

### III. Bài tập
  1. Tạo một trang web tĩnh sử dụng Bulma - [Web tham khảo](./exercises/exercise_01.html). Yêu cầu:
    - Chủ đề bất kì: Giới thiệu bản thân, giới thiệu một ban nhạc ...
    - Sử dụng file `bulma.css` hoặc `bulma.min.css`, làm quen với một số class trong bulma.
    - Phải responsive (thay đổi chế độ hiển thị) cho màn hình di động.
  2. Tạo một trang web tĩnh tương tự sử dụng Bootstrap.

### IV. Sách tham khảo
  - Learning Bulma - [Link](./../../../Books/html_css_book/learning-bulma-understand-responsive-mobile-first.pdf)
