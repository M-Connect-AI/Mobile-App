# Chatbot_project Constitution

**Luôn luôn phản hồi, trả lời bằng tiếng việt.**

## Core Principles

### I. Layer-First Architecture

Code được tổ chức theo **Layer-First Architecture** trong `lib/`

* Các layer chính gồm:

  * `data/`: chứa repository implementation, data source, API client và model/DTO phục vụ việc truy xuất dữ liệu
  * `domain/`: chứa model/entity nghiệp vụ, repository abstraction và use case
  * `presentation/`: chứa UI, state management và các thành phần liên quan đến presentation layer
* Feature được tổ chức bên trong từng layer tương ứng, ví dụ:

  * `data/repository/chat/`
  * `domain/usecase/chat/`
  * `presentation/pages/chat/`
* Code dùng chung giữa nhiều feature được đặt trong `lib/common/`
* Dependency injection được đặt trong `lib/di/`
* Routing được đặt trong `lib/route/`
* Resources và generated files được đặt trong `lib/resources/`
* Không tạo `lib/features/` hoặc đóng gói toàn bộ một feature thành một thư mục riêng
* Mọi dependency phải tuân theo hướng: `presentation -> domain <- data`
* `domain` không được phụ thuộc vào `presentation` hoặc implementation trong `data`

### II. Component-Based UI (NON-NEGOTIABLE)

- **PHẢI** sử dụng app components có sẵn, **KHÔNG** tạo widget tuỳ chỉnh:
  - Buttons: `IrhIconTextButton()`, `IrhButton()`, `IrhTextButton()`, `IrhRichTextButton()`
  - Text: `IrhText.small()`, `IrhText.regular()`, `IrhText.medium()`, etc.
  - Text fields: `IrhTextField` với `FormBuilder` - KHÔNG dùng raw `TextField`
  - Inputs: `Item.normal()`, `Item.arrowDown()`, `Item.switchNetWork()`
  - Toast: `AppToast.showSuccess()`, `AppToast.showError()`, `AppToast.showWarning()`, `AppToast.showInfo()`
  - Icons: `ThemedIcon()`, `MonoIcon()`, `Assets.icons.iconName.svg()` - **KHÔNG** dùng Material Icons, tải icon từ Figma

**AppTextField Usage:**

```dart
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../common/components/app_text_field.dart';

// Wrap trong FormBuilder
FormBuilder(
  key: _formKey,
  child: AppTextField(
    context,
    name: 'fieldName',              // Required: tên field trong form
    initialValue: 'default value',  // Giá trị ban đầu
    labelText: S.of(context).label, // Floating label
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    autofocus: true,
    validator: (value) {            // Validation
      if (value == null || value.trim().isEmpty) {
        return S.of(context).titleIsRequired(S.of(context).label);
      }
      return null;
    },
  ),
)

// Lấy giá trị từ form
if (_formKey.currentState?.saveAndValidate() ?? false) {
  final value = _formKey.currentState?.value['fieldName']?.toString().trim() ?? '';
}
```

### III. Design System Compliance

- **Colors**: Chỉ sử dụng `context.appColorScheme` - KHÔNG hardcode colors
  - Text: `textPrimary`, `textSecondary`, `textTertiary`, `textBrand`, `textError`, `textSuccess`
  - Surface: `surfacePrimary`, `surfaceSecondary`, `surfaceTemary`
  - Border: `borderPrimary`, `borderSecondary`, `borderTertiary`
  - Icons: `iconPrimary`, `iconSecondary`, `iconBrand`
- **Typography**: Chỉ sử dụng `AppTextStyle` - KHÔNG dùng raw `TextStyle`
  - Nếu chưa có style phù hợp → thêm mới vào `lib/common/components/app_text_style.dart` (đặt tên theo quy ước: prefix `b`=bold/w700, `m`=medium/w500, `sm`=semibold/w600, `r`=regular/w400, `l`=light/w300, suffix = fontSize)
  - Cho phép dùng `.copyWith()` trên style có sẵn khi chỉ cần thay đổi nhỏ (color, decoration, v.v.)
  - **KHÔNG** dùng `TextStyle(fontFamily: ..., fontWeight: ...)` trực tiếp trong widget
- **Number Format**: Sử dụng `toVNDFormat()` - KHÔNG dùng `toStringAsFixed()`
- Dùng SafeArea, nhưng KHÔNG nên để nó hiện thành một vùng đen riêng biệt. Safe area nên “hòa” vào giao diện, trừ khi app cố tình thiết kế kiểu bottom bar đen hoặc màn hình video/game toàn màn hình.

### III-A. Responsive Sizing (NON-NEGOTIABLE)

Project dùng `flutter_screenutil` + extension tại `lib/common/extensions/responsive_extension.dart`.

**Tất cả giá trị kích thước, khoảng cách, padding, margin PHẢI đi qua extension:**

Kích thước **PHẢI** chia được hết cho 4

```dart
import 'package:chatbot_project/common/extensions/responsive_extension.dart';

// SizedBox khoảng cách
32.height.heightBox   // vertical gap
16.width.widthBox     // horizontal gap

// Padding / Margin
EdgeInsets.symmetric(horizontal: 16.width, vertical: 12.height)
EdgeInsets.fromLTRB(8.width, 16.height, 8.width, 32.height)
EdgeInsets.only(left: 8.width, top: 8.height)
EdgeInsets.all(16.width)  // hoặc symmetric nếu khác chiều

// Widget width / height tường minh
SizedBox(width: 261.width, height: 48.height)
Container(width: 256.width, height: 256.height)

// Icon / font size dùng .sp
Icon(Icons.check, size: 20.sp)
TextStyle(fontSize: 16.sp)

// Border radius: để nguyên (không áp dụng responsive)
BorderRadius.circular(16)
```

**Quy tắc chiều:**

- Horizontal (trái-phải, width) → `.width`
- Vertical (trên-dưới, height) → `.height`
- Font / icon size → `.sp`

**Import bắt buộc** cho mọi file sử dụng giá trị kích thước:

```dart
import 'package:chatbot_project/common/extensions/responsive_extension.dart';
```



### IV. Localization (NON-NEGOTIABLE)

- Tất cả text hiển thị **PHẢI** sử dụng `S.of(context).keyName` hoặc `S.current.keyName`
- **KHÔNG** hardcode strings trong UI
- Localization files hiện có: `lib/l10n/intl_vi.arb`, `lib/l10n/intl_en.arb`
- Khi thêm locale mới: cập nhật ARB trong `lib/l10n/` và regenerate localization

### V. State Management - BLOC (NON-NEGOTIABLE)

- Đọc trong ./skills/bloc-state.md.
### VI. Data Models - Freezed

* Tất cả data models **PHẢI** sử dụng `@freezed` annotation
* Data models/DTOs đặt trong `lib/data/model/` hoặc thư mục con tương ứng theo domain/feature nếu cần
* Domain models/entities đặt trong `lib/domain/model/`
* Không đặt model trong `presentation/`
* Generated files đặt cùng thư mục với source model:

  * `*.freezed.dart`
  * `*.g.dart`
* Generated files **KHÔNG** được chỉnh sửa thủ công

**Standard Model Structure:**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_name.freezed.dart';
part 'model_name.g.dart';

@freezed
class ModelName with _$ModelName {
  const factory ModelName({
    required int id,
    required String title,
    String? optionalField,
    @Default('') String fieldWithDefault,
    @JsonKey(name: 'api_field_name') required String dartFieldName,
  }) = _ModelName;

  factory ModelName.fromJson(Map<String, dynamic> json) =>
      _$ModelNameFromJson(json);
}
```

**Freezed Patterns:**

- `required` - Field bắt buộc, non-nullable
- `String?` - Field optional, nullable
- `@Default(value)` - Field có giá trị mặc định
- `@JsonKey(name: 'snake_case')` - Map API field name sang Dart camelCase
- Nested objects: Dùng freezed class khác làm type
- Lists: `required List<OtherModel> items`

**Model với Extensions:**

```dart
@freezed
class Currency with _$Currency {
  const factory Currency({
    required int id,
    required String code,
    @JsonKey(name: 'market_base_price') @Default(0) num marketBasePrice,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  // Empty factory for default/fallback values
  factory Currency.empty() => const Currency(id: 0, code: '');
}

// Extension cho computed properties và methods
extension CurrencyExtension on Currency {
  String get formattedPrice => marketBasePrice.toVNDFormat();
}
```

**Response Wrapper Pattern:**

```dart
@freezed
class PostListResponse with _$PostListResponse {
  const factory PostListResponse({
    required List<PostModel> posts,
    Meta? meta,
  }) = _PostListResponse;

  factory PostListResponse.fromJson(Map<String, dynamic> json) =>
      _$PostListResponseFromJson(json);
}
```

## Technology Stack

### Framework & Tools

- **Flutter**: 3.41.29++ (managed via `fvm`)
- **Commands**: Luôn dùng prefix `fvm flutter`, `fvm dart`
- **State**: Flutter_bloc với annotations
- **Routing**: GoRouter 15.x
- **API**: Chopper với auto-generated `.chopper.dart` files
- **Serialization**: Freezed + JSON Serializable
- **DI**: get_it + injectable 
- **Design Assets**: Icons từ Figma, **KHÔNG** sử dụng Material Icons mặc định

### Code Generation

- Run `make generate` sau khi thay đổi models/providers
- Run `make gen_i18n` sau khi thay đổi localization ARB files
- Generated files: `*.g.dart`, `*.freezed.dart`, `*.chopper.dart`
- Assets: Auto-generated trong `lib/gen/assets.gen.dart`
- Localization: Auto-generated trong `lib/generated/l10n.dart`

## Development Workflow

### Code Standards

```dart
// Standard screen structure
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/components/app_text_style.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../l10n/l10n.dart';

class FeatureScreen extends ConsumerWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.appColorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).screenTitle)),
      body: // UI code
    );
  }
}
```

### Feature Creation Checklist

1. Tạo màn hình trong `feature/[feature_name]/view/`
2. Tạo state/notifier trong `feature/[feature_name]/controller/` (nếu cần)
3. Tạo/đặt models trong `feature/[feature_name]/model/` (nếu cần)
4. Đăng ký route trong `lib/common/routes/go_router.dart`
5. Chạy `make generate` nếu có thay đổi codegen

### Navigation with GoRouter (NON-NEGOTIABLE)

**LUÔN LUÔN** dùng GoRouter cho navigation, KHÔNG bao giờ dùng `Navigator.push()`, `MaterialPageRoute()`, hay `Navigator.of(context)`.

**Standard pattern:**

1. **Định nghĩa route trong `go_router.dart`:**

```dart
import 'package:chatbot_project/feature/[feature_name]/view/[screen_name].dart';

@TypedGoRoute<ScreenRoute>(path: '/path-name')
class ScreenRoute extends GoRouteData with _$ScreenRoute {
  const ScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScreenName();
}
```

1. **Sử dụng route để navigate:**

```dart
// ✅ ĐÚNG - Dùng route class
const ScreenRoute().push(context);
const ScreenRoute().go(context);

// ❌ KHÔNG BƯỚC - Dùng Navigator
Navigator.of(context).push(MaterialPageRoute(...))
```

1. **Quay lại screen trước:**

```dart
// ✅ ĐÚNG
context.pop()

// ❌ KHÔNG
GoRouter.of(context).pop()
Navigator.of(context).pop()
```

1. **Route với parameters:**

```dart
@TypedGoRoute<DetailRoute>(path: '/detail/:id')
class DetailRoute extends GoRouteData with _$DetailRoute {
  final String id;
  
  const DetailRoute(this.id);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DetailScreen(id: id);
}

// Sử dụng
DetailRoute(userId: '123').push(context);
```

### Figma Integration Guidelines

- **Icons**: Tải về SVG icons từ Figma design files thay vì sử dụng Material Icons
- **File placement**: Đặt SVG files vào `assets/icons/` với tên descriptive
- **Code generation**: Sau khi thêm icons, chạy `make generate` để cập nhật `Assets.gen.dart`
- **Usage**: Sử dụng `Assets.icons.iconName.svg()` với proper theming (`ColorFilter.mode`)
- **Theming**: Luôn apply `colorFilter` cho consistency với app color scheme

### VII-B. Không dùng _build Methods — Dùng Private Widget Classes (NON-NEGOTIABLE)

Flutter rebuild widget theo đơn vị **class**, không theo method. Hàm `_buildXxx()` luôn chạy lại khi parent rebuild dù output không đổi, trong khi class widget có thể skip rebuild nhờ `const` constructor.

```dart
// ❌ KHÔNG dùng
Widget _buildHeader(BuildContext context) {
  return Column(children: [...]);
}

// ✅ DÙNG — private class cùng file
class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Column(children: [...]);
  }
}
```

**Quy tắc:**

- Mọi đoạn UI tách ra thành method `_buildXxx` → phải chuyển thành private class trong cùng file
- Nếu cần truyền data: dùng constructor parameters thay vì closure/method params
- Exception duy nhất: các expression cực ngắn (1-2 widget, không có state) có thể dùng getter `Widget get _xxx`

### Import Convention

- Ưu tiên `package:carhub/...` cho import cross-feature/cross-layer để nhất quán
- Chỉ dùng relative import cho phạm vi gần trong cùng feature khi thực sự cần

### VII-A. Widget Reuse Strategy (NON-NEGOTIABLE)

Trước khi tạo bất kỳ widget nào, **PHẢI kiểm tra xem có widget tương tự đã tồn tại** để tái sử dụng:

**Quy tắc vị trí đặt widget:**

- Widget dùng trong Ýt nhất 2 screen khác nhau → đưa vào `lib/common/components/` hoặc `lib/feature/[feature]/view/widgets/`
- Widget chỉ dùng trong 1 feature nhưng nhiều screen → `lib/feature/[feature]/view/widgets/`
- Widget chỉ dùng trong 1 screen → private class trong cùng file

**Quy định bắt buộc:**

- **KHÔNG** tạo 2 widget khác tên nhưng cùng việc (vd: `_SocialBtn` và `_SocialItem` thực ra là 1 widget)
- **KHÔNG** copy-paste code widget giữa các file → phải extract ra file chung
- **PHẢI** tìm kiếm widget hiện có trong `lib/common/components/` và `lib/feature/` trước khi tạo mới

**Đặt tên file widget chung:**

```
lib/feature/authen/view/widgets/auth_social_buttons.dart
lib/feature/authen/view/widgets/auth_channel_selector.dart
lib/common/components/labeled_divider.dart
```

### Quality Gates

1. Run `fvm flutter analyze` - không có errors
2. Run `make generate` nếu có thay đổi models
3. Test trên cả light và dark theme
4. Verify responsive design

### Prohibitions (❌ KHÔNG BAO GIỜ)

- ❌ Hardcoded colors → ✅ `context.appColorScheme`
- ❌ Hardcoded strings → ✅ `S.of(context)`
- ❌ Raw TextStyle → ✅ `AppTextStyle`
- ❌ Raw TextField → ✅ `AppTextField` với `FormBuilder`
- ❌ ScaffoldMessenger → ✅ `AppToast`
- ❌ toStringAsFixed() → ✅ `toVNDFormat()`
- ❌ flutter/dart commands without fvm → ✅ `fvm flutter`, `fvm dart`
- ❌ Sửa tay file generated (`*.g.dart`, `*.freezed.dart`, `*.chopper.dart`, `go_router.g.dart`) → ✅ sửa file nguồn và chạy generate
- ❌ Hardcoded padding/margin/size số thô: `16.heightBox`, `EdgeInsets.all(16)`, `SizedBox(width: 100)` → ✅ Dùng responsive extension: `16.height.heightBox`, `EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height)`, `SizedBox(width: 100.width)`
- ❌ `Padding(padding: EdgeInsets.xxx, child: widget)` → ✅ `widget.paddingAll()` / `.paddingSymmetric()` / `.paddingLTRB()` / `.paddingOnly()` từ `awesome_extensions`
- ❌ `Expanded(child: widget)` / `Flexible(child: widget)` → ✅ `widget.expanded()` / `widget.flexible()`
- ❌ Tạo widget trùng lập (cùng UI khác tên) giữa các file → ✅ Extract ra `lib/feature/[feature]/view/widgets/` hoặc `lib/common/components/` và import lại
- ❌ Hàm `_buildXxx(BuildContext context)` trả về `Widget` trong State/Widget class → ✅ Tạo private class `class _XxxWidget extends StatelessWidget` hoặc `StatefulWidget`
- ❌ `GestureDetector`, `InkWell`, `TextButton` cho button/tap → ✅ `CupertinoButton` (có feedback native iOS/Android, padding dễ tuỳ, không có ripple thầy): `CupertinoButton(padding: EdgeInsets.zero, onPressed: onTap, child: widget)`
- ❌ `Navigator.of(context).pop()` → ✅ `context.pop()` (từ go_router extension)
- ❌ `Navigator.of(context).push(MaterialPageRoute(...))` → ✅ Tạo route class trong `go_router.dart` và dùng `const RouteClass().push(context)`
- ❌ Sử dụng Material Icons mặc định → ✅ Download icons từ link Figma và sử dụng `Assets.icons.iconName.svg()` với proper theming
- ❌ `setState()` trong StatefulWidget → ✅ Dùng Riverpod (StateProvider, NotifierProvider, ConsumerWidget) để quản lý state reactive
- ❌ Khai báo Riverpod provider thủ công (`StateProvider`, `StateNotifierProvider`, `Provider`, `NotifierProvider`) cho logic mới → ✅ Dùng `@Riverpod`/`@riverpod` và generate code

## Testing

### Test Structure

- Tests đặt trong `test/` mirror với `lib/` structure
- Widget tests sử dụng standard Flutter test framework
- Run tests: `fvm flutter test`

## Governance

Constitution này là source of truth cho Chatbot mobile development. Mọi PR/review phải verify compliance với các principles trên. Exceptions cần documented justification và approval.

**Version**: 1.0.0 | **Ratified**: 2026-9-6
