import React from 'react';
import { ItemCategory } from '../../helpers/category';

const paths: Record<ItemCategory | 'all', string> = {
  all: 'M4 4h7v7H4zM13 4h7v7h-7zM4 13h7v7H4zM13 13h7v7h-7z',
  weapons: 'M12 2v4M12 18v4M2 12h4M18 12h4M12 7a5 5 0 1 0 0 10 5 5 0 0 0 0-10zM12 11a1 1 0 1 0 0 2 1 1 0 0 0 0-2z',
  food: 'M7 2v8a2 2 0 0 0 2 2v10M11 2v8a2 2 0 0 1-2 2M9 2v6M17 22V2c-2.5 1.5-3 4-3 7v4h3',
  medical: 'M9 3h6v6h6v6h-6v6H9v-6H3V9h6z',
  clothing: 'M8 3l-5 3 2 5 3-1v11h8V10l3 1 2-5-5-3c-.5 1.5-2 2.5-4 2.5S8.5 4.5 8 3z',
  tools: 'M14.5 6.5a4 4 0 0 0 5 5L13 18a2.1 2.1 0 0 1-3-3l6.5-6.5zM10 14l-6 6M4.5 3.5l3 3',
  documents: 'M3 5h18v14H3zM7 9a2 2 0 1 0 0 4 2 2 0 0 0 0-4zM5 16c.5-1.5 1.5-2 2-2s1.5.5 2 2M13 9h5M13 12h5M13 15h3',
  drinks: 'M7 3h10l-1.5 17a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1zM7.5 8h9M14 3l2-2',
  ingredients: 'M12 3c-4 0-7 3-7 6 0 2 1 3 2 4v6a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-6c1-1 2-2 2-4 0-3-3-6-7-6zM9 17h6',
  drugs: 'M10.5 20.5a5 5 0 0 1-7-7l6-6a5 5 0 0 1 7 7zM7 10l7 7',
  vehicle:
    'M5 17h14M3 13l2-6a2 2 0 0 1 2-1h10a2 2 0 0 1 2 1l2 6v4a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-1H7v1a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1zM3 13h18M7 15.5h.01M17 15.5h.01',
  valuables: 'M6 3h12l3 6-9 12L3 9zM3 9h18M9 3l3 6 3-6M12 9v12',
  materials: 'M3 17l9 4 9-4M3 12l9 4 9-4M3 7l9-4 9 4-9 4z',
  other: 'M3 7l9-4 9 4v10l-9 4-9-4zM3 7l9 4 9-4M12 11v10',
};

export const CategoryIcon: React.FC<{ category: ItemCategory | 'all' }> = ({ category }) => (
  <svg
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth={1.7}
    strokeLinecap="round"
    strokeLinejoin="round"
    aria-hidden
  >
    <path d={paths[category]} />
  </svg>
);

export const SearchIcon: React.FC = () => (
  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={1.8} strokeLinecap="round" aria-hidden>
    <circle cx="11" cy="11" r="6" />
    <path d="M20 20l-4.2-4.2" />
  </svg>
);

export const SortIcon: React.FC = () => (
  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={1.8} strokeLinecap="round" aria-hidden>
    <path d="M4 6h12M4 12h8M4 18h4M18 8v12M15 17l3 3 3-3" />
  </svg>
);
