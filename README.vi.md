> [English](README.md) | **Tiếng Việt**

# Plugin Kong HiTechCloud vCWAF

Plugin Kong cho [HiTechCloud vCWAF](https://hitechwaf.vn/) — Web Application Firewall (WAF). Plugin này dùng để bảo vệ API của bạn khỏi các request độc hại. Nó có thể chặn các request chứa nội dung độc hại trong body, query parameter, header hoặc URI.

## Chuẩn bị HiTechCloud vCWAF

Engine phát hiện của HiTechCloud vCWAF mặc định cung cấp dịch vụ qua Unix socket. Ta cần chuyển sang TCP để plugin có thể gọi được.

1. Vào thư mục cấu hình của engine phát hiện HiTechCloud vCWAF:

   ```shell
   cd /data/hitechcloud-vcwaf/resources/detector/
   ```

2. Mở tệp `detector.yml` trong trình soạn thảo văn bản. Sửa cấu hình bind từ Unix socket sang TCP bằng cách thêm các thiết lập sau:

   ```yaml
   bind_addr: 0.0.0.0
   listen_port: 8000
   ```

   Các giá trị cấu hình này sẽ ghi đè thiết lập mặc định trong container, khiến engine HiTechCloud vCWAF lắng nghe trên cổng 8000.

3. Tiếp theo, map cổng 8000 của container ra máy host. Trước tiên, vào thư mục cài đặt HiTechCloud vCWAF:

   ```shell
   cd /data/hitechcloud-vcwaf
   ```

4. Mở tệp compose.yaml trong trình soạn thảo văn bản và thêm trường ports cho container detector để mở cổng 8000:

   ```yaml
   ...
   detect:
     ports:
       - 8000:8000
   ...
   ```

5. Lưu thay đổi và khởi động lại HiTechCloud vCWAF bằng các lệnh sau:

   ```shell
   docker-compose down
   docker-compose up -d
   ```

   Thao tác này sẽ áp dụng thay đổi và kích hoạt cấu hình mới.

## Cài đặt plugin

Để cài đặt plugin, chạy lệnh sau trên máy chủ Kong của bạn:

```shell
$ luarocks install kong-hitechcloud-vcwaf
```

## Cấu hình plugin

Bạn có thể thêm plugin cho API của mình bằng request sau:

```shell
# nếu detector của bạn chạy trên cổng tcp
$ curl -X POST http://kong:8001/services/{name}/plugins \
    --data "name=hitechcloud-vcwaf" \
    --data "config.host=your_detector_host" \
    --data "config.port=your_detector_port"
# nếu detector của bạn chạy qua unix socket
$ curl -X POST http://kong:8001/services/{name}/plugins \
    --data "name=hitechcloud-vcwaf" \
    --data "config.host=unix:/path/to/your/unix/socket"
```

## Kiểm tra

Bạn có thể kiểm tra plugin bằng cách gửi request tới API với nội dung độc hại. Nếu request bị chặn, bạn sẽ nhận được phản hồi `403 Forbidden`.

```shell
$ curl -X POST http://kong:8000?1=1%20and%202=2

# bạn sẽ nhận được phản hồi 403 Forbidden
{"code": 403, "success":false, "message": "blocked by HiTechCloud vCWAF Web Application Firewall", "event_id": "8b41a021ea9541c89bb88f3773b4da24"}
```
