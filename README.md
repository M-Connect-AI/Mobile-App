# AI Assistant

Flutter chatbot sử dụng hai repository độc lập:

- `SpeechToTextRepository`: chuyển giọng nói thành transcript trực tiếp qua dịch vụ nhận dạng trên thiết bị.
- `ChatRepository`: gửi text hoặc transcript lên Chat API và nhận phản hồi AI.

Project này chỉ chứa Flutter client, không chứa source backend.

## Cấu trúc màn hình

- `lib/presentation/pages/login`: màn đăng nhập mockup, chưa xác thực thật.
- `lib/presentation/pages/home`: màn trang chủ và điểm mở trợ lý.
- `lib/presentation/pages/chat`: màn hội thoại với trợ lý AI.
- `lib/common/`: design system, typography Roboto và responsive extensions.
- `lib/l10n/`: nội dung bản địa hóa tiếng Việt/tiếng Anh.
- `lib/route/go_router.dart`: typed routes cho ba màn hình.

Ứng dụng khởi động ở màn đăng nhập. Hiện tại nút **Đăng nhập** chuyển thẳng
sang trang chủ để phục vụ dựng giao diện và kiểm thử luồng.

Roboto được nhúng trong `assets/fonts/` và cấu hình làm font mặc định của toàn
bộ light/dark theme, không phụ thuộc font có sẵn trên thiết bị.

## Cấu hình AI Platform

```bash
cp .env.example .env
```

Điền API key vào file `.env`:

```dotenv
AI_PLATFORM_API_KEY=your-api-key
AI_PLATFORM_BASE_URL=https://your-ai-platform.example/v1
AI_PLATFORM_MODEL=your-model-id
```

`.env` đã được git-ignore. Tuy nhiên, đây là Flutter asset nên key vẫn được đóng gói trong APK/IPA và có thể bị trích xuất. Không nên phân phối bản production chứa API key dùng chung có quyền hạn lớn.

## Chạy ứng dụng

```bash
fvm flutter pub get
fvm flutter run
```

Nếu `AI_PLATFORM_API_KEY` trống, ứng dụng dùng `MockChatRepository`. Khi có key, `ApiChatRepository` gọi:

```text
POST <AI_PLATFORM_BASE_URL>/chat/completions
Authorization: Bearer <AI_PLATFORM_API_KEY>
```

Payload:

```json
{
  "model": "<AI_PLATFORM_MODEL>",
  "messages": [
    {
      "role": "assistant",
      "content": "You are an AI assistant tasked with providing information to users."
    },
    {
      "role": "user",
      "content": "Chuyển 500k cho Nguyễn Văn A"
    }
  ],
  "max_tokens": 4096,
  "temperature": 1,
  "top_p": 0.95,
  "stream": true
}
```

Repository đọc từng SSE event từ `choices[0].delta.content` cho đến `data: [DONE]`, ghép JSON hoàn chỉnh và chỉ hiển thị `confirmation_question`. JSON gốc vẫn được lưu trong tối đa 20 message gần nhất để duy trì ngữ cảnh hội thoại.

Speech-to-text và text nhập tay đều được gửi tới cùng Chat Completions API dưới role `user`.

Custom business-trip prompt được gửi tại `messages[0].content` với role `assistant`. Transcript nằm ở message role `user`, nên prompt không bị nối trực tiếp vào transcript hoặc lưu lặp lại trong conversation history.

Mỗi lần ứng dụng khởi động, `BusinessTripPromptBuilder` sinh một `transaction_id` ngẫu nhiên mới. ID này giữ nguyên trong suốt phiên chạy và được yêu cầu trả lại trong JSON để tách cache/ngữ cảnh giữa các lần mở ứng dụng.

Business data được truyền qua `BusinessTripPromptData`:

```dart
final promptBuilder = BusinessTripPromptBuilder(
  data: const BusinessTripPromptData(
    locations: ['Đà Nẵng', 'Hà Nội'],
    employees: [
      BusinessEntity(id: 'employee-1', name: 'Nguyễn Văn A'),
    ],
    customers: [
      BusinessEntity(id: 'customer-1', name: 'Công ty ABC'),
    ],
    transportationOptions: ['Máy bay', 'Ô tô'],
  ),
);
```

Nếu chưa có dữ liệu nghiệp vụ, truyền danh sách rỗng. Prompt builder tự chèn ngày hiện tại theo định dạng `YYYY-MM-DD`.

Ví dụ response streaming:

```text
data: {"choices":[{"delta":{"content":"{\\"confirmation_question\\":"}}]}

data: {"choices":[{"delta":{"content":"\\"Bạn muốn chuyển từ tài khoản nào?\\"}"}}]}

data: [DONE]
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
