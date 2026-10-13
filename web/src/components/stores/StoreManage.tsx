import React, { useMemo, useState } from 'react';
import { Items } from '../../store/items';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { SearchIcon } from '../mystory/icons';
import { StoreData, StoreManagement, itemLabel, money, t } from './StoreView';
import StoreHistory from './StoreHistory';

type Props = { store: StoreData; management: StoreManagement; onUpdate: (store: StoreData) => void };

const StoreManage: React.FC<Props> = ({ store, management, onUpdate }) => {
  const [prices, setPrices] = useState<Record<string, string>>({});
  const [adding, setAdding] = useState('');
  const [view, setView] = useState<'products' | 'history'>('products');

  const manage = async (action: string, data?: unknown) => {
    const response = await fetchNui<{ success: boolean; store?: StoreData }>('storeManage', {
      id: store.id,
      action,
      data,
    });

    if (response?.store) onUpdate(response.store);
    return response?.success;
  };

  const listed = useMemo(() => new Set(management.items.map((item) => item.name)), [management.items]);

  const candidates = useMemo(() => {
    const query = adding.trim().toLowerCase();
    if (query.length < 2) return [];

    return Object.values(Items)
      .filter((item) => item && !listed.has(item.name))
      .filter((item) => item!.label.toLowerCase().includes(query) || item!.name.toLowerCase().includes(query))
      .slice(0, 8);
  }, [adding, listed]);

  const priceValue = (name: string, fallback: number) => prices[name] ?? String(fallback);

  const savePrice = (name: string, enabled: boolean, fallback: number) => {
    const price = parseInt(priceValue(name, fallback), 10);
    if (Number.isNaN(price) || price < 0) return;

    const current = management.items.find((item) => item.name === name);
    if (current && current.price === price && current.enabled === enabled) return;

    manage('setItem', { name, price, enabled });
  };

  return (
    <div className="store-manage">
      <div className="store-manage-cards">
        <div className="store-card">
          <span>{t('ui_store_till', 'Till')}</span>
          <strong>{money(management.cash)}</strong>
          <button disabled={management.cash <= 0} onClick={() => manage('withdraw')}>
            {t('ui_store_withdraw', 'Withdraw')}
          </button>
        </div>
        {management.type === 'stock' && (
          <div className="store-card">
            <span>{t('ui_store_type_stock', 'Stock room')}</span>
            <strong>{management.items.reduce((sum, item) => sum + item.stock, 0)}</strong>
            <button onClick={() => fetchNui('storeManage', { id: store.id, action: 'openStock' })}>
              {t('ui_store_open_stock', 'Open stock room')}
            </button>
          </div>
        )}
      </div>

      <div className="store-tabs store-subtabs">
        <button className={view === 'products' ? 'active' : undefined} onClick={() => setView('products')}>
          {t('ui_store_products', 'Products')}
        </button>
        <button className={view === 'history' ? 'active' : undefined} onClick={() => setView('history')}>
          {t('ui_store_history', 'Sales')}
        </button>
      </div>

      {view === 'history' ? (
        <StoreHistory storeId={store.id} />
      ) : (
        <>
          <div className="store-add">
            <label className="search-field">
              <SearchIcon />
              <input
                type="text"
                value={adding}
                placeholder={t('ui_store_add_product', 'Add product')}
                onChange={(event) => setAdding(event.target.value)}
              />
            </label>
            {candidates.length > 0 && (
              <div className="store-add-results">
                {candidates.map((item) => (
                  <button
                    key={item!.name}
                    onClick={() => {
                      manage('setItem', { name: item!.name, price: 0, enabled: false });
                      setAdding('');
                    }}
                  >
                    <img src={getItemUrl(item!.name)} alt="" />
                    {item!.label}
                  </button>
                ))}
              </div>
            )}
          </div>

          <div className="store-table">
            {management.items.map((item) => (
              <div className={`store-row${item.enabled ? '' : ' disabled'}`} key={item.name}>
                <img src={getItemUrl(item.name)} alt="" />
                <div className="store-row-name">
                  <p>{itemLabel(item.name)}</p>
                  <span>
                    {management.type === 'stock'
                      ? `${t('ui_store_stock', 'In stock')}: ${item.stock}`
                      : t('ui_store_unlimited', 'Unlimited')}
                  </span>
                </div>
                <label className="store-price">
                  <span>$</span>
                  <input
                    type="text"
                    value={priceValue(item.name, item.price)}
                    onChange={(event) =>
                      setPrices((current) => ({ ...current, [item.name]: event.target.value.replace(/\D/g, '') }))
                    }
                    onBlur={() => savePrice(item.name, item.enabled, item.price)}
                    onKeyDown={(event) => event.key === 'Enter' && savePrice(item.name, item.enabled, item.price)}
                  />
                </label>
                <button
                  className={`store-toggle${item.enabled ? ' on' : ''}`}
                  onClick={() => savePrice(item.name, !item.enabled, item.price)}
                  title={t('ui_store_visible', 'For sale')}
                >
                  <span />
                </button>
                <button className="store-remove" onClick={() => manage('removeItem', { name: item.name })}>
                  {t('ui_store_remove', 'Remove')}
                </button>
              </div>
            ))}
          </div>
        </>
      )}
    </div>
  );
};

export default StoreManage;
