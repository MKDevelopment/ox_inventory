import React, { useEffect, useRef, useState } from 'react';
import { Locale } from '../../store/locale';
import { fetchNui } from '../../utils/fetchNui';
import { SortIcon } from './icons';

const MODES = [
  { mode: 'category', fallback: 'Category' },
  { mode: 'name', fallback: 'Name' },
  { mode: 'weight', fallback: 'Weight' },
  { mode: 'count', fallback: 'Amount' },
];

const SortMenu: React.FC = () => {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!open) return;

    const close = (event: MouseEvent) => {
      if (ref.current && !ref.current.contains(event.target as Node)) setOpen(false);
    };

    window.addEventListener('mousedown', close);
    return () => window.removeEventListener('mousedown', close);
  }, [open]);

  const sort = (mode: string) => {
    setOpen(false);
    fetchNui('sortInventory', mode);
  };

  return (
    <div className="sort-menu" ref={ref}>
      <button className={`icon-button${open ? ' active' : ''}`} onClick={() => setOpen(!open)}>
        <SortIcon />
        <span>{Locale.ui_sort || 'Sort'}</span>
      </button>
      {open && (
        <div className="sort-menu-list">
          {MODES.map(({ mode, fallback }) => (
            <button key={mode} onClick={() => sort(mode)}>
              {Locale[`ui_sort_${mode}`] || fallback}
            </button>
          ))}
        </div>
      )}
    </div>
  );
};

export default SortMenu;
