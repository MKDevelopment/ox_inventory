import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory } from '../../typings';
import WeightBar from '../utils/WeightBar';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { SearchIcon } from '../mystory/icons';

const PAGE_SIZE = 30;

const InventoryGrid: React.FC<{ inventory: Inventory }> = ({ inventory }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );
  const [page, setPage] = useState(0);
  const [search, setSearch] = useState('');
  const containerRef = useRef(null);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);

  const query = search.trim().toLowerCase();
  const items = useMemo(() => {
    if (!query) return inventory.items.slice(0, (page + 1) * PAGE_SIZE);

    return inventory.items.filter(
      (item) =>
        item.name && (item.metadata?.label || Items[item.name]?.label || item.name).toLowerCase().includes(query)
    );
  }, [inventory.items, page, query]);

  return (
    <section className="other-panel" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
      <header className="other-panel-header">
        <div className="other-panel-title">
          <h2>{inventory.label}</h2>
          {inventory.maxWeight ? (
            <span>
              {(weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })} / {inventory.maxWeight / 1000} kg
            </span>
          ) : null}
        </div>
        {inventory.maxWeight ? <WeightBar percent={(weight / inventory.maxWeight) * 100} /> : null}
        <label className="search-field">
          <SearchIcon />
          <input
            type="text"
            value={search}
            placeholder={Locale.ui_search || 'Search...'}
            onChange={(event) => setSearch(event.target.value)}
          />
        </label>
      </header>
      <div className="other-grid" ref={containerRef}>
        {items.map((item, index) => (
          <InventorySlot
            key={`${inventory.type}-${inventory.id}-${item.slot}`}
            item={item}
            ref={!query && index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
            inventoryType={inventory.type}
            inventoryGroups={inventory.groups}
            inventoryId={inventory.id}
          />
        ))}
      </div>
    </section>
  );
};

export default InventoryGrid;
