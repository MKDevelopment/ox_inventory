import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory, Slot } from '../../typings';
import WeightBar from '../utils/WeightBar';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { CATEGORIES, ItemCategory, getCategoryLabel, getItemCategory } from '../../helpers/category';

const PAGE_SIZE = 30;

type Filter = ItemCategory | 'all';

const matchesFilter = (item: Slot, search: string, category: Filter) => {
  if (!item.name) return false;

  if (category !== 'all' && getItemCategory(item.name) !== category) return false;

  if (search) {
    const label = (item.metadata?.label || Items[item.name]?.label || item.name).toLowerCase();
    if (!label.includes(search)) return false;
  }

  return true;
};

const InventoryGrid: React.FC<{ inventory: Inventory }> = ({ inventory }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );
  const [page, setPage] = useState(0);
  const [search, setSearch] = useState('');
  const [category, setCategory] = useState<Filter>('all');
  const containerRef = useRef(null);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);

  // only offer the categories that are actually present in this inventory
  const availableCategories = useMemo(() => {
    const present = new Set<ItemCategory>();

    for (const item of inventory.items) {
      if (item.name) present.add(getItemCategory(item.name));
    }

    return CATEGORIES.filter((c) => present.has(c));
  }, [inventory.items]);

  useEffect(() => {
    if (category !== 'all' && !availableCategories.includes(category)) setCategory('all');
  }, [availableCategories, category]);

  const normalizedSearch = search.trim().toLowerCase();
  const filtering = normalizedSearch !== '' || category !== 'all';
  const usedSlots = useMemo(() => inventory.items.filter((item) => item.name).length, [inventory.items]);

  return (
    <div className="inventory-panel" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
      <div className="inventory-panel-header">
        <div className="inventory-grid-header-wrapper">
          <div className="inventory-panel-title">
            <p>{inventory.label}</p>
            <span className="inventory-panel-slots">
              {usedSlots}/{inventory.slots}
            </span>
          </div>
          {inventory.maxWeight && (
            <p>
              {weight / 1000}/{inventory.maxWeight / 1000}kg
            </p>
          )}
        </div>
        <WeightBar percent={inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0} />
      </div>
      <div className="inventory-toolbar">
        <div className="inventory-search">
          <svg viewBox="0 0 24 24" aria-hidden>
            <path d="M10 4a6 6 0 1 0 3.75 10.68l4.78 4.79 1.42-1.42-4.79-4.78A6 6 0 0 0 10 4zm0 2a4 4 0 1 1 0 8 4 4 0 0 1 0-8z" />
          </svg>
          <input
            type="text"
            value={search}
            placeholder={Locale.ui_search || 'Search...'}
            onChange={(event) => setSearch(event.target.value)}
          />
          {search && (
            <button className="inventory-search-clear" onClick={() => setSearch('')}>
              ×
            </button>
          )}
        </div>
        {availableCategories.length > 1 && (
          <div className="inventory-categories">
            {(['all', ...availableCategories] as Filter[]).map((c) => (
              <button
                key={c}
                className={`inventory-category${category === c ? ' active' : ''}`}
                onClick={() => setCategory(c)}
              >
                {getCategoryLabel(c)}
              </button>
            ))}
          </div>
        )}
      </div>
      <div className="inventory-grid-container" ref={containerRef}>
        {inventory.items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
          <InventorySlot
            key={`${inventory.type}-${inventory.id}-${item.slot}`}
            item={item}
            ref={index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
            inventoryType={inventory.type}
            inventoryGroups={inventory.groups}
            inventoryId={inventory.id}
            dimmed={filtering && !matchesFilter(item, normalizedSearch, category)}
          />
        ))}
      </div>
    </div>
  );
};

export default InventoryGrid;
