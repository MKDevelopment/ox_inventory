import React, { useMemo, useState } from 'react';
import logo from '../../assets/logo.webp';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getTotalWeight } from '../../helpers';
import { CATEGORIES, ItemCategory, getCategoryLabel, getItemCategory } from '../../helpers/category';
import { Slot } from '../../typings';
import InventorySlot from '../inventory/InventorySlot';
import WeightArc from './WeightArc';
import SortMenu from './SortMenu';
import { CategoryIcon, SearchIcon } from './icons';

const QUICK_SLOTS = 5;

type Folder = ItemCategory | 'all';

const getLabel = (item: Slot) =>
  (item.metadata?.label || (item.name && Items[item.name]?.label) || item.name || '').toLowerCase();

const PlayerPanel: React.FC = () => {
  const inventory = useAppSelector(selectLeftInventory);
  const isBusy = useAppSelector((state) => state.inventory.isBusy);
  const [folder, setFolder] = useState<Folder>('all');
  const [search, setSearch] = useState('');

  const weight = useMemo(() => getTotalWeight(inventory.items), [inventory.items]);
  const quickSlots = useMemo(() => inventory.items.slice(0, QUICK_SLOTS), [inventory.items]);
  const pocket = useMemo(() => inventory.items.slice(QUICK_SLOTS), [inventory.items]);

  const folders = useMemo(() => {
    const stats: Record<Folder, { count: number; weight: number }> = { all: { count: 0, weight: 0 } } as any;

    for (const item of pocket) {
      if (!item.name) continue;
      const category = getItemCategory(item.name);
      stats[category] = stats[category] || { count: 0, weight: 0 };
      stats[category].count++;
      stats[category].weight += item.weight || 0;
      stats.all.count++;
      stats.all.weight += item.weight || 0;
    }

    return stats;
  }, [pocket]);

  const query = search.trim().toLowerCase();

  // "all" keeps the real slot layout (empty slots included); a folder lists its items plus one free slot to drop into
  const visibleSlots = useMemo(() => {
    if (folder === 'all' && !query) return pocket;

    const matches = pocket.filter(
      (item) =>
        item.name &&
        (folder === 'all' || getItemCategory(item.name) === folder) &&
        (!query || getLabel(item).includes(query))
    );
    const freeSlot = pocket.find((item) => !item.name);

    return freeSlot ? [...matches, freeSlot] : matches;
  }, [pocket, folder, query]);

  const filtered = folder !== 'all' || query !== '';
  const hasMatches = !filtered || visibleSlots.some((item) => item.name);

  return (
    <section className="player-panel" style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
      <header className="player-panel-header">
        <img className="player-panel-logo" src={logo} alt="MyStory" />
        <div className="player-panel-identity">
          <h1>{inventory.label}</h1>
          <p>
            {folders.all.count + quickSlots.filter((item) => item.name).length}/{inventory.slots}{' '}
            {Locale.ui_slots_used || 'slots used'}
          </p>
        </div>
        {inventory.maxWeight ? <WeightArc weight={weight} maxWeight={inventory.maxWeight} /> : null}
      </header>

      <div className="player-panel-body">
        <nav className="folder-rail">
          {(['all', ...CATEGORIES] as Folder[]).map((key) => {
            const stats = folders[key];
            const empty = key !== 'all' && !stats;

            return (
              <button
                key={key}
                className={`folder${folder === key ? ' active' : ''}${empty ? ' empty' : ''}`}
                onClick={() => setFolder(key)}
                title={getCategoryLabel(key)}
              >
                <CategoryIcon category={key} />
                <span className="folder-name">{getCategoryLabel(key)}</span>
                {stats && stats.count > 0 && <span className="folder-count">{stats.count}</span>}
              </button>
            );
          })}
        </nav>

        <div className="player-panel-content">
          <div className="quick-slots">
            <p className="section-title">{Locale.ui_quickslots || 'Quick access'}</p>
            <div className="quick-slots-row">
              {quickSlots.map((item) => (
                <InventorySlot
                  key={`player-quick-${item.slot}`}
                  item={item}
                  inventoryType={inventory.type}
                  inventoryGroups={inventory.groups}
                  inventoryId={inventory.id}
                />
              ))}
            </div>
          </div>

          <div className="pocket-toolbar">
            <div className="pocket-title">
              <h2>{getCategoryLabel(folder)}</h2>
              {folders[folder] && (
                <span>{(folders[folder].weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 2 })} kg</span>
              )}
            </div>
            <label className="search-field">
              <SearchIcon />
              <input
                type="text"
                value={search}
                placeholder={Locale.ui_search || 'Search...'}
                onChange={(event) => setSearch(event.target.value)}
              />
            </label>
            <SortMenu />
          </div>

          <div className="pocket-grid">
            {visibleSlots.map((item) => {
              const slot = (
                <InventorySlot
                  key={`player-${item.slot}`}
                  item={item}
                  inventoryType={inventory.type}
                  inventoryGroups={inventory.groups}
                  inventoryId={inventory.id}
                />
              );

              return filtered && !item.name ? (
                <div className="free-slot" key={`player-free-${item.slot}`} title={Locale.ui_free_slot}>
                  {slot}
                </div>
              ) : (
                slot
              );
            })}
            {!hasMatches && <p className="pocket-empty">{Locale.ui_folder_empty || 'Nothing here yet.'}</p>}
          </div>
        </div>
      </div>
    </section>
  );
};

export default PlayerPanel;
