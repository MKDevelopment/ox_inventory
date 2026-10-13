import { Items } from '../store/items';
import { Locale } from '../store/locale';

export const CATEGORIES = ['weapons', 'food', 'medical', 'clothing', 'tools', 'documents', 'other'] as const;

export type ItemCategory = (typeof CATEGORIES)[number];

const FALLBACK_LABELS: Record<ItemCategory | 'all', string> = {
  all: 'All',
  weapons: 'Weapons',
  food: 'Food',
  medical: 'Medical',
  clothing: 'Clothing',
  tools: 'Tools',
  documents: 'Documents',
  other: 'Other',
};

export const getCategoryLabel = (category: ItemCategory | 'all') =>
  Locale[`ui_category_${category}`] || FALLBACK_LABELS[category];

export const getItemCategory = (name: string): ItemCategory => {
  const explicit = Items[name]?.category;

  if (explicit && (CATEGORIES as readonly string[]).includes(explicit)) return explicit as ItemCategory;

  const lower = name.toLowerCase();

  if (lower.startsWith('weapon_') || lower.startsWith('ammo-') || lower.startsWith('at_')) return 'weapons';
  if (lower.startsWith('clothing')) return 'clothing';

  return 'other';
};
