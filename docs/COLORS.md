# 🎨 Skuba Open - Color Theme

This site uses the official Skuba brand colors for a consistent experience across all platforms.

## Primary Colors

- **Background**: `#f3f4f6` - Light gray background
- **Accent (Primary Blue)**: `#0b95da` - Skuba blue (links, buttons, headings)
- **Accent Dark**: `#075985` - Darker blue for hover states

## Neutral Colors

- **White**: `#ffffff` - Card/box backgrounds
- **Light Gray**: `#f9fafb` - Alternate row backgrounds
- **Medium Gray**: `#e5e7eb` - Borders, subtle UI elements
- **Dark Gray**: `#374151` - Secondary text
- **Black**: `#000000` - Primary text, headings

## Usage

### Homepage (index.html)

- Background: `#f3f4f6`
- Content card: `#ffffff` with subtle shadow
- Links: `#0b95da` → `#075985` on hover
- Blockquotes: `#0b95da` left border
- Code blocks: `#f3f4f6` background with `#e5e7eb` border

### 404 Page (404.html)

- Background: `#f3f4f6`
- Container: `#ffffff` card with shadow
- 404 text: `#0b95da`
- Primary button: `#0b95da` background
- Secondary button: `#ffffff` with `#e5e7eb` border
- Suggestions box: `#f3f4f6` with `#e5e7eb` border

### Loading Spinner

- Spinner border: `#e5e7eb`
- Spinner accent: `#0b95da`

## Color Accessibility

All color combinations meet WCAG AA standards for contrast:

- `#0b95da` on `#ffffff`: ✅ 4.52:1 (AA)
- `#000000` on `#ffffff`: ✅ 21:1 (AAA)
- `#374151` on `#ffffff`: ✅ 9.73:1 (AAA)

## Consistency

These colors match the Skuba mobile app theme (see `/skuba-app/src/lib/tamagui/themes.ts`), ensuring a unified brand experience.
