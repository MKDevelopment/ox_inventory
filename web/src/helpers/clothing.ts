import { Locale } from '../store/locale';

export interface GarmentPart {
  category: 'component' | 'prop';
  id: number;
  data: { collection?: string; index: number; texture: number };
}

// garment photo template from data/clothing.lua (image)
let template: string | undefined;

export const setClothingImage = (value?: string) => {
  template = typeof value === 'string' && value !== '' ? value : undefined;
};

const GENDERS: Record<number, 'male' | 'female'> = { 1885233650: 'male', 2627665880: 'female' };

export const garmentGender = (model: unknown) => {
  const hash = Number(model);
  return Number.isFinite(hash) ? GENDERS[((hash % 2 ** 32) + 2 ** 32) % 2 ** 32] : undefined;
};

export const garmentParts = (metadata?: Record<string, any>): GarmentPart[] =>
  metadata?.type === 'clothe' && Array.isArray(metadata.data)
    ? metadata.data.filter((part: GarmentPart) => part && part.data)
    : [];

/** Photo of a tgiann-clothing garment, built from its first part; undefined without a template. */
export const garmentImageUrl = (metadata?: Record<string, any>) => {
  const part = garmentParts(metadata)[0];
  if (!template || !part) return;

  const values: Record<string, unknown> = {
    gender: garmentGender(metadata?.model) ?? '',
    category: part.category,
    id: part.id,
    collection: part.data.collection ?? '',
    index: part.data.index,
    texture: part.data.texture,
  };

  return template.replace(/\{(\w+)\}/g, (match, key) => (key in values ? String(values[key]) : match));
};

export const partLabel = (part: GarmentPart) =>
  Locale[`ui_clothing_part_${part.category}_${part.id}`] || `${part.category} ${part.id}`;
