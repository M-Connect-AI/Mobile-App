# AI Assistant

Flutter chatbot sử dụng hai repository độc lập:

- `SpeechToTextRepository`: chuyển giọng nói thành transcript trực tiếp qua dịch vụ nhận dạng trên thiết bị.
- `ChatRepository`: gửi text hoặc transcript lên Chat API và nhận phản hồi AI.

Project này chỉ chứa Flutter client, không chứa source backend.

## Cấu trúc màn hình

- `lib/presentation/pages/login`: màn đăng nhập bằng tài khoản backend và danh sách tài khoản gợi ý.
- `lib/presentation/pages/home`: màn trang chủ và điểm mở trợ lý.
- `lib/presentation/pages/chat`: màn hội thoại với trợ lý AI.
- `lib/common/`: design system, typography Roboto và responsive extensions.
- `lib/l10n/`: nội dung bản địa hóa tiếng Việt/tiếng Anh.
- `lib/route/go_router.dart`: typed routes cho ba màn hình.

Ứng dụng khởi động ở màn đăng nhập và chỉ chuyển sang trang chủ sau khi backend
xác thực thành công.

Roboto được nhúng trong `assets/fonts/` và cấu hình làm font mặc định của toàn
bộ light/dark theme, không phụ thuộc font có sẵn trên thiết bị.

## Cấu hình backend

```bash
cp .env.example .env
```

Điền địa chỉ HR và Agent service vào file `.env`:

```dotenv
HR_API_BASE_URL=http://localhost:3002
AGENT_API_BASE_URL=http://localhost:3001
```

Với production gateway, cấu hình origin; ứng dụng tự thêm `/api/hr` và
`/api/agent`. Chat dùng JWT nhận từ Login, không đóng gói model API key trong app.

## Chạy ứng dụng

```bash
fvm flutter pub get
fvm flutter run
```

Chat luôn gọi Agent backend thật:

```text
GET  <AGENT_API_BASE_URL>/chat/threads
GET  <AGENT_API_BASE_URL>/chat/threads/:threadId
POST <AGENT_API_BASE_URL>/chat/stream
Authorization: Bearer <accessToken>
```

Payload:

```json
{
  "message": "Tôi muốn xin nghỉ phép",
  "threadId": "optional",
  "confirm": false
}
```

Repository đọc named SSE, ghép token, giữ `threadId` do server cấp và xử lý
confirmation, result, citation. Lịch sử do backend quản lý; mobile không gửi lại
history, model setting hoặc system prompt.

Ví dụ response streaming:

```text
event: token
data: {"text":"Bạn có muốn gửi đơn nghỉ phép?"}

event: confirm
data: {"tool":"create_leave","args":{},"summary":"Gửi đơn nghỉ phép"}

event: done
data: {"threadId":"...","citations":[]}
```

Khi nhấn microphone lần đầu, hãy cấp cả quyền microphone và speech recognition. `DeviceSpeechToTextRepository` ưu tiên locale tiếng Việt, phát partial transcript qua stream và `ChatBloc` gửi transcript cuối cùng qua `ChatRepository`.

## Lưu ý theo nền tảng

- Nên kiểm tra nhận dạng giọng nói trên thiết bị Android/iOS thật.
- Android cần có dịch vụ nhận dạng giọng nói tương thích, thường được cung cấp bởi ứng dụng Google.
- iOS Simulator có thể chưa cài voice data cho tiếng Việt.
- Nhận dạng của hệ điều hành có thể tự dừng sau một khoảng im lặng; ứng dụng sẽ tự gửi nếu đã nhận được transcript.
- Nội dung hiện không được upload hoặc lưu thành file audio bởi project này.

## Kiểm tra

```bash
fvm flutter analyze
fvm flutter test
```

## Android release signing

Android release dùng application ID `com.irohasu.mconnect.chatbot` và bắt buộc
ký bằng upload keystore cố định. Cấu hình local nằm trong `android/key.properties`;
keystore và mật khẩu đều bị loại khỏi Git.

GitHub Actions truyền các secret tương ứng qua biến môi trường:

```text
ANDROID_KEYSTORE_PATH
ANDROID_KEY_ALIAS
ANDROID_STORE_PASSWORD
ANDROID_KEY_PASSWORD
```

Luôn sao lưu keystore và mật khẩu ở nơi an toàn. Nếu mất hoặc thay keystore,
tester sẽ không thể cài APK mới đè lên phiên bản hiện có.

## CI/CD Android nội bộ

Repository có hai GitHub Actions workflow:

- `CI`: kiểm tra format, analyze và test trên pull request/push vào `main`.
- `Release Android APK`: build, ký APK và đính kèm APK vào GitHub prerelease.

Tạo GitHub Environment tên `internal`, sau đó cấu hình:

```text
Variables:
HR_API_BASE_URL
AGENT_API_BASE_URL

Secrets:
ANDROID_KEYSTORE_BASE64
ANDROID_KEY_ALIAS
ANDROID_STORE_PASSWORD
ANDROID_KEY_PASSWORD
```

`ANDROID_KEYSTORE_BASE64` là nội dung Base64 một dòng của
`android/app/mconnect-chatbot-upload.jks`. Alias hiện tại là
`mconnect-chatbot`. Hai mật khẩu dùng giá trị trong file local
`android/signing/keystore-password.txt`.

Phát hành APK mới bằng tag có định dạng:

```bash
git tag 'internal-v1.0.0+1'
git push origin 'internal-v1.0.0+1'
```

Cũng có thể chạy workflow `Release Android APK` thủ công và nhập version dạng
`1.0.0+1`.
