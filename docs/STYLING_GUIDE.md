# 🎨 Social Bee App - Standardized Styling Guide

## 📋 Overview
This guide defines the **ONLY** way to style UI components in the Social Bee app. Follow these rules strictly for consistent, maintainable, and professional UI across the entire application.

## 🚫 **NEVER DO THESE**
- ❌ **NO inline styles** - Never use `TextStyle(fontSize: 16, color: Colors.blue)`
- ❌ **NO hardcoded colors** - Never use `Color(0xFF123456)` or `Colors.blue`
- ❌ **NO hardcoded dimensions** - Never use `width: 100, height: 50, padding: 16`
- ❌ **NO hardcoded text** - Never use `Text('Hello World')` - use localization
- ❌ **NO custom decorations** - Never create `BoxDecoration` inline

## ✅ **ALWAYS DO THESE**
- ✅ **Use AppTextStyles** for ALL text styling
- ✅ **Use AppColors** for ALL colors
- ✅ **Use AppDimensions** for ALL spacing and sizes
- ✅ **Use AppDecorations** for ALL visual elements
- ✅ **Use localization** for ALL text strings

---

## 📁 **File Structure**
```
lib/core/theme/
├── app_text_styles.dart    # ALL text styling
├── app_dimensions.dart     # ALL spacing & sizes
└── app_decorations.dart    # ALL visual elements
```

---

## 🎯 **1. TEXT STYLING - AppTextStyles**

### **Headlines**
```dart
// ✅ CORRECT
Text('Title', style: AppTextStyles.h1)
Text('Subtitle', style: AppTextStyles.h2)
Text('Section', style: AppTextStyles.h3)

// ❌ WRONG
Text('Title', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
```

### **Body Text**
```dart
// ✅ CORRECT
Text('Description', style: AppTextStyles.bodyLarge)
Text('Details', style: AppTextStyles.bodyMedium)
Text('Caption', style: AppTextStyles.bodySmall)

// ❌ WRONG
Text('Description', style: TextStyle(fontSize: 16))
```

### **Buttons**
```dart
// ✅ CORRECT
Text('Submit', style: AppTextStyles.buttonLarge)
Text('Cancel', style: AppTextStyles.buttonMedium)
Text('Save', style: AppTextStyles.buttonSmall)

// ❌ WRONG
Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
```

### **Special Cases**
```dart
// ✅ CORRECT
Text('App Name', style: AppTextStyles.splashAppName)
Text('Error Message', style: AppTextStyles.errorText)
Text('Success Message', style: AppTextStyles.successText)
Text('Link Text', style: AppTextStyles.linkText)
```

---

## 📏 **2. DIMENSIONS - AppDimensions**

### **Spacing**
```dart
// ✅ CORRECT
SizedBox(height: AppDimensions.spacing16)
Padding(padding: EdgeInsets.all(AppDimensions.spacing12))
Container(margin: EdgeInsets.all(AppDimensions.spacing8))

// ❌ WRONG
SizedBox(height: 16)
Padding(padding: EdgeInsets.all(12))
Container(margin: EdgeInsets.all(8))
```

### **Border Radius**
```dart
// ✅ CORRECT
BorderRadius.circular(AppDimensions.radiusMedium)
BorderRadius.circular(AppDimensions.radiusLarge)
BorderRadius.circular(AppDimensions.radiusRound)

// ❌ WRONG
BorderRadius.circular(8)
BorderRadius.circular(12)
BorderRadius.circular(50)
```

### **Icon Sizes**
```dart
// ✅ CORRECT
Icon(Icons.home, size: AppDimensions.iconMedium)
Icon(Icons.settings, size: AppDimensions.iconLarge)

// ❌ WRONG
Icon(Icons.home, size: 20)
Icon(Icons.settings, size: 24)
```

### **Button Heights**
```dart
// ✅ CORRECT
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, AppDimensions.buttonHeightMedium),
  ),
  child: Text('Button'),
)

// ❌ WRONG
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 40),
  ),
  child: Text('Button'),
)
```

---

## 🎨 **3. DECORATIONS - AppDecorations**

### **Cards**
```dart
// ✅ CORRECT
Container(decoration: AppDecorations.card)
Container(decoration: AppDecorations.cardElevated)

// ❌ WRONG
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(...)],
  ),
)
```

### **Buttons**
```dart
// ✅ CORRECT
Container(decoration: AppDecorations.primaryButton)
Container(decoration: AppDecorations.secondaryButton)
Container(decoration: AppDecorations.outlineButton)

// ❌ WRONG
Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
)
```

### **Input Fields**
```dart
// ✅ CORRECT
Container(decoration: AppDecorations.inputField)
Container(decoration: AppDecorations.inputFieldFocused)
Container(decoration: AppDecorations.inputFieldError)

// ❌ WRONG
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

### **Gradients**
```dart
// ✅ CORRECT
Container(decoration: AppDecorations.primaryGradient)
Container(decoration: AppDecorations.accentGradient)

// ❌ WRONG
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
)
```

---

## 🌈 **4. COLORS - AppColors**

### **Primary Colors**
```dart
// ✅ CORRECT
color: AppColors.primary
color: AppColors.primaryDark
color: AppColors.primaryLight

// ❌ WRONG
color: Color(0xFF6366F1)
color: Colors.blue
```

### **Text Colors**
```dart
// ✅ CORRECT
color: AppColors.textPrimary
color: AppColors.textSecondary
color: AppColors.textOnPrimary

// ❌ WRONG
color: Colors.black
color: Colors.grey
color: Colors.white
```

### **Status Colors**
```dart
// ✅ CORRECT
color: AppColors.success
color: AppColors.error
color: AppColors.warning
color: AppColors.info

// ❌ WRONG
color: Colors.green
color: Colors.red
color: Colors.orange
color: Colors.blue
```

---

## 🌐 **5. LOCALIZATION - Text Strings**

### **All Text Must Use Localization**
```dart
// ✅ CORRECT
Text('app_name'.tr)
Text('welcome_message'.tr)
Text('error_occurred'.tr)

// ❌ WRONG
Text('Social Bee')
Text('Welcome to our app')
Text('An error occurred')
```

### **Adding New Strings**
1. Add to `lib/localization/en_us/en_us_translations.dart`:
```dart
"new_string_key": "New String Value",
```

2. Use in code:
```dart
Text('new_string_key'.tr)
```

---

## 📱 **6. COMPONENT EXAMPLES**

### **Card Component**
```dart
// ✅ CORRECT
Container(
  padding: EdgeInsets.all(AppDimensions.cardPadding),
  margin: EdgeInsets.all(AppDimensions.cardMargin),
  decoration: AppDecorations.card,
  child: Column(
    children: [
      Text('Card Title', style: AppTextStyles.cardTitle),
      SizedBox(height: AppDimensions.spacing8),
      Text('Card content', style: AppTextStyles.bodyMedium),
    ],
  ),
)
```

### **Button Component**
```dart
// ✅ CORRECT
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, AppDimensions.buttonHeightMedium),
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  ),
  onPressed: () {},
  child: Text('button_text'.tr, style: AppTextStyles.buttonMedium),
)
```

### **Input Field Component**
```dart
// ✅ CORRECT
Container(
  decoration: AppDecorations.inputField,
  child: TextField(
    style: AppTextStyles.bodyMedium,
    decoration: InputDecoration(
      hintText: 'hint_text'.tr,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(AppDimensions.spacing16),
    ),
  ),
)
```

---

## 🔧 **7. IMPLEMENTATION CHECKLIST**

When creating/updating any UI screen:

- [ ] **Text**: All text uses `AppTextStyles.*`
- [ ] **Colors**: All colors use `AppColors.*`
- [ ] **Spacing**: All spacing uses `AppDimensions.spacing*`
- [ ] **Sizes**: All sizes use `AppDimensions.*`
- [ ] **Radius**: All radius uses `AppDimensions.radius*`
- [ ] **Decorations**: All decorations use `AppDecorations.*`
- [ ] **Strings**: All text uses localization `'key'.tr`
- [ ] **No inline styles**: No hardcoded values anywhere

---

## 📚 **8. QUICK REFERENCE**

### **Most Used Text Styles**
- `AppTextStyles.h1` - Main titles
- `AppTextStyles.h2` - Section titles
- `AppTextStyles.bodyMedium` - Regular text
- `AppTextStyles.buttonMedium` - Button text
- `AppTextStyles.caption` - Small text

### **Most Used Dimensions**
- `AppDimensions.spacing16` - Standard spacing
- `AppDimensions.radiusMedium` - Standard radius
- `AppDimensions.buttonHeightMedium` - Standard button height
- `AppDimensions.iconMedium` - Standard icon size

### **Most Used Decorations**
- `AppDecorations.card` - Standard cards
- `AppDecorations.primaryButton` - Primary buttons
- `AppDecorations.inputField` - Input fields
- `AppDecorations.primaryGradient` - Background gradients

---

## 🎯 **9. MIGRATION STRATEGY**

When updating existing screens:

1. **Replace all inline styles** with `AppTextStyles.*`
2. **Replace all hardcoded colors** with `AppColors.*`
3. **Replace all hardcoded dimensions** with `AppDimensions.*`
4. **Replace all custom decorations** with `AppDecorations.*`
5. **Replace all hardcoded text** with localization keys
6. **Test the screen** to ensure it looks consistent

---

## 🚀 **10. BENEFITS**

- **Consistency**: Same look across entire app
- **Maintainability**: Change once, update everywhere
- **Performance**: No inline style calculations
- **Scalability**: Easy to add new themes
- **Professional**: Clean, modern design system
- **Developer Experience**: Easy to use, hard to mess up

---

## 📞 **Support**

If you need to add new styles:
1. **Text**: Add to `AppTextStyles`
2. **Dimensions**: Add to `AppDimensions`
3. **Decorations**: Add to `AppDecorations`
4. **Colors**: Add to `AppColors`
5. **Strings**: Add to localization file

**Remember**: These 4 files are the ONLY place to define styles. Everything else should reference these files.
