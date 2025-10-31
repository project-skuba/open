# 🎨 Neobrutalist Design System

The Skuba Open GitHub Pages site uses a **neobrutalist design system** that matches the Skuba mobile app.

## What is Neobrutalism?

Neobrutalism is a modern design trend characterized by:
- **Bold, thick borders** (typically 2-3px)
- **Solid, offset shadows** (no blur)
- **High contrast colors**
- **Simple, geometric shapes**
- **Flat, minimalist aesthetics**
- **Brutally honest, no-nonsense UI**

## Design Tokens

Based on the Skuba app's design system (`src/lib/tamagui/tokens.ts`):

### Border Radius
```
sm: 8px   - Small elements (inline code)
md: 12px  - Standard (cards, buttons, tables)
lg: 16px  - Large containers
```

### Border Width
```
sm: 2px   - Inline code, table cells
md: 3px   - Main elements (cards, buttons)
lg: 4px   - Emphasis (reserved)
```

### Shadow Offsets
```
X: 2px    - Horizontal offset
Y: 4px    - Vertical offset
Blur: 0   - No blur (solid shadow)
```

### Shadow Colors
```
Light mode: #000000 (pure black)
Dark mode:  Lighter than background for visibility
```

## Implementation

### Content Cards
```css
border: 3px solid #000000;
border-radius: 12px;
box-shadow: 2px 4px 0 #000000;
```

**Result:** Bold card that "pops" off the page

### Buttons
```css
/* Default state */
border: 3px solid #000000;
border-radius: 12px;
box-shadow: 2px 4px 0 #000000;

/* Hover state */
transform: translate(1px, 2px);
box-shadow: 1px 2px 0 #000000;
```

**Effect:** Button appears to "press down" when hovered

### Code Blocks
```css
/* Inline code */
border: 2px solid #000000;
border-radius: 8px;

/* Code blocks */
border: 3px solid #000000;
border-radius: 12px;
box-shadow: 2px 4px 0 #000000;
```

### Tables
```css
/* Table container */
border: 3px solid #000000;
border-radius: 12px;
overflow: hidden;

/* Table cells */
border-right: 2px solid #000000;
border-bottom: 2px solid #000000;

/* Table headers */
border-bottom: 3px solid #000000;
```

**Result:** Strong, defined table structure

### Blockquotes
```css
border-left: 3px solid #0b95da;
background-color: #f8f9fa;
border-radius: 8px;
padding: 12px 16px;
```

**Result:** Distinct, Skuba-branded callouts

### Horizontal Rules
```css
background-color: #000000;
height: 3px;
border: 0;
```

**Result:** Bold, clear section dividers

## Color Palette

### Light Mode (Active)
```
Background:     #f8f9fa  ███
Cards:          #ffffff  ███
Borders:        #000000  ███  (bold black)
Shadows:        #000000  ███  (solid black)
Accent:         #0b95da  ███  (Skuba blue)
Text:           #000000  ███
```

### Dark Mode (Prepared)
Based on Skuba app dark theme:
```
Background:     #1b1b1f  ███  (deep warm black)
Cards:          #2a2a2e  ███  (warm charcoal)
Borders:        #47474f  ███  (muted visible)
Shadows:        #5a5a62  ███  (brighter than fill)
Accent:         #7891b3  ███  (slate blue)
Text:           #e4e4e7  ███
```

## Visual Examples

### Card Structure
```
┌─────────────────────────────────┐ ← 3px black border
│  Content Card                   │
│  #ffffff background             │
│                                 │
│  Black text, Skuba blue links   │
│                                 │
└─────────────────────────────────┘
  └─────shadow (2px, 4px, 0)────┘ ← Solid offset shadow
```

### Button Interaction
```
Normal:
┌──────────┐
│ Click Me │  ← At position (0, 0)
└──────────┘
  └─shadow──┘  ← At position (2px, 4px)

Hover/Press:
┌──────────┐
│ Click Me │  ← Moves to (1px, 2px)
└──────────┘
  └─shadow─┘   ← Moves to (3px, 6px) → appears "pressed"
```

### Table Grid
```
┌─────────────────────────────────┐ ← 3px outer border
│ Header 1 ║ Header 2 ║ Header 3 │ ← 3px bottom border
╞══════════╬══════════╬══════════╡
│ Cell     ║ Cell     ║ Cell     │ ← 2px borders
├──────────╫──────────╫──────────┤
│ Cell     ║ Cell     ║ Cell     │
└─────────────────────────────────┘
```

## Principles

### 1. **Bold & Unapologetic**
Every element has a strong presence. No subtle gradients or soft shadows.

### 2. **High Contrast**
Black borders on white backgrounds. No ambiguity.

### 3. **Functional Clarity**
Interactive elements are obvious. Buttons look like buttons.

### 4. **Consistent Geometry**
12px border radius throughout. 3px borders for major elements.

### 5. **Honest Interactions**
Hover states mimic physical button presses. No magic transitions.

### 6. **Accessibility First**
High contrast ratios (21:1 for black on white). Clear focus states.

## Why Neobrutalism for Skuba?

### ✅ Matches Diving Aesthetic
- Bold and direct like diving equipment
- No-nonsense approach fits safety-critical content
- High visibility like diving signals

### ✅ Modern & Memorable
- Stands out from typical web design
- Strong brand identity
- Professional yet approachable

### ✅ Accessibility
- High contrast for readability
- Clear interactive elements
- Works well in various lighting conditions

### ✅ Consistency
- Matches Skuba mobile app exactly
- Unified design language
- Professional brand coherence

## Browser Support

Works perfectly in all modern browsers:
- ✅ Chrome/Edge (Chromium)
- ✅ Firefox
- ✅ Safari (desktop & mobile)
- ✅ Mobile browsers

No special features required - just CSS borders and box-shadow!

## Mobile Responsive

The neobrutalist style scales beautifully to mobile:
- Touch targets remain clear and bold
- High contrast aids outdoor visibility
- Buttons are obviously tappable
- No reliance on subtle hover states

## Performance

Neobrutalism is performant:
- ✅ No gradient calculations
- ✅ No blur effects (expensive)
- ✅ Simple solid colors
- ✅ Hardware-accelerated transforms
- ✅ Minimal CSS complexity

## Comparison to Traditional Design

| Aspect | Traditional | Neobrutalist |
|--------|-------------|--------------|
| Borders | 1px, subtle | 3px, bold |
| Shadows | Blurred, soft | Solid, offset |
| Corners | Various radii | Consistent 12px |
| Colors | Gradients, soft | Solid, high contrast |
| Interactions | Fade, scale | Press/shift |
| Aesthetic | Polished | Brutally honest |

## Future: Dark Mode

When dark mode is enabled, the design will use:
```css
/* Dark mode tokens */
background: #1b1b1f;
cards: #2a2a2e;
borders: #47474f;
shadows: #5a5a62; /* Lighter than background */
accent: #7891b3;
text: #e4e4e7;
```

Same neobrutalist principles, inverted for dark environments!

## Code Reference

See the Skuba app for the complete design system:
- Tokens: `/skuba-app/src/lib/tamagui/tokens.ts`
- Themes: `/skuba-app/src/lib/tamagui/themes.ts`

---

## Quick Reference

### Element Styles

| Element | Border | Radius | Shadow |
|---------|--------|--------|--------|
| Main card | 3px solid #000 | 12px | 2px 4px 0 #000 |
| Button | 3px solid #000 | 12px | 2px 4px 0 #000 |
| Code block | 3px solid #000 | 12px | 2px 4px 0 #000 |
| Inline code | 2px solid #000 | 8px | none |
| Table | 3px solid #000 | 12px | none |
| Suggestions | 3px solid #000 | 12px | 2px 4px 0 #000 |

### Interactive States

| State | Transform | Shadow |
|-------|-----------|--------|
| Default | none | 2px 4px 0 |
| Hover | translate(1px, 2px) | 1px 2px 0 |

---

**The Skuba neobrutalist design: Bold, functional, and unapologetically direct.** 🌊

Just like diving itself.

