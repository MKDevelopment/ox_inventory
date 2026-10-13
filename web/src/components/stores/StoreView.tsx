import React, { useMemo, useState } from 'react';
import logo from '../../assets/logo.webp';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { SearchIcon } from '../mystory/icons';
import StoreManage from './StoreManage';

export type StoreProduct = { name: string; price: number; stock: number };

export type StoreManagement = {
  cash: number;
  type: 'stock' | 'infinite';
  items: Array<{ name: string; price: number; enabled: boolean; stock: number }>;
};

export type StoreData = {
  id: number;
  label: string;
  products: StoreProduct[];
  management?: StoreManagement;
  methods: Array<'cash' | 'bank'>;
};

export const t = (key: string, fallback: string) => Locale[key] || fallback;

export const money = (value: number) => `$${value.toLocaleString('en-US')}`;

export const itemLabel = (name: string) => Items[name]?.label || name;

const StoreView: React.FC<{ store: StoreData; onUpdate: (store: StoreData) => void }> = ({ store, onUpdate }) => {
  const [tab, setTab] = useState<'shop' | 'manage'>('shop');
  const [cart, setCart] = useState<Record<string, number>>({});
  const [method, setMethod] = useState(store.methods[0] || 'cash');
  const [search, setSearch] = useState('');
  const [busy, setBusy] = useState(false);

  const products = useMemo(() => {
    const query = search.trim().toLowerCase();
    return store.products.filter((p) => !query || itemLabel(p.name).toLowerCase().includes(query));
  }, [store.products, search]);

  const stockOf = (name: string) => store.products.find((p) => p.name === name);

  const setCount = (name: string, count: number) => {
    const product = stockOf(name);
    if (!product) return;

    setCart((current) => {
      const next = { ...current };
      const clamped = Math.max(0, Math.min(count, product.stock, 1000));

      if (clamped === 0) delete next[name];
      else next[name] = clamped;

      return next;
    });
  };

  const lines = Object.entries(cart).filter(([name]) => stockOf(name));
  const total = lines.reduce((sum, [name, count]) => sum + (stockOf(name)?.price || 0) * count, 0);

  const pay = async () => {
    if (busy || lines.length === 0) return;
    setBusy(true);

    const response = await fetchNui<{ success: boolean; store?: StoreData }>('storeCheckout', {
      id: store.id,
      cart: Object.fromEntries(lines),
      method,
    });

    if (response?.success) setCart({});
    if (response?.store) onUpdate(response.store);
    setBusy(false);
  };

  return (
    <div className="store">
      <section className="store-main">
        <header className="store-header">
          <img src={logo} alt="MyStory" />
          <h1>{store.label}</h1>
          {store.management && (
            <div className="store-tabs">
              <button className={tab === 'shop' ? 'active' : undefined} onClick={() => setTab('shop')}>
                {t('ui_store_shop', 'Shop')}
              </button>
              <button className={tab === 'manage' ? 'active' : undefined} onClick={() => setTab('manage')}>
                {t('ui_store_manage', 'Manage')}
              </button>
            </div>
          )}
          <button className="store-close" onClick={() => fetchNui('storeClose')}>
            {t('ui_store_close', 'Close')}
            <kbd>Esc</kbd>
          </button>
        </header>

        {tab === 'manage' && store.management ? (
          <StoreManage store={store} management={store.management} onUpdate={onUpdate} />
        ) : (
          <>
            <label className="search-field store-search">
              <SearchIcon />
              <input
                type="text"
                value={search}
                placeholder={Locale.ui_search || 'Search...'}
                onChange={(event) => setSearch(event.target.value)}
              />
            </label>
            {store.products.length === 0 ? (
              <p className="store-empty">{t('ui_store_no_products', 'This store has nothing for sale yet.')}</p>
            ) : (
              <div className="store-products">
                {products.map((product) => {
                  const inCart = cart[product.name] || 0;
                  const soldOut = product.stock <= 0;

                  return (
                    <button
                      key={product.name}
                      className={`store-product${soldOut ? ' sold-out' : ''}${inCart ? ' in-cart' : ''}`}
                      disabled={soldOut}
                      onClick={() => setCount(product.name, inCart + 1)}
                    >
                      <img src={getItemUrl(product.name)} alt="" />
                      <span className="store-product-name">{itemLabel(product.name)}</span>
                      <span className="store-product-price">{money(product.price)}</span>
                      <span className="store-product-stock">
                        {soldOut
                          ? t('ui_store_sold_out', 'Sold out')
                          : product.stock >= 9999
                            ? t('ui_store_unlimited', 'Unlimited')
                            : `${t('ui_store_stock', 'In stock')}: ${product.stock}`}
                      </span>
                      {inCart > 0 && <span className="store-product-badge">{inCart}</span>}
                    </button>
                  );
                })}
              </div>
            )}
          </>
        )}
      </section>

      {tab === 'shop' && (
        <aside className="store-cart">
          <h2>{t('ui_store_cart', 'Cart')}</h2>
          {lines.length === 0 ? (
            <p className="store-cart-empty">{t('ui_store_empty_cart', 'Add products to your cart to buy them.')}</p>
          ) : (
            <ul className="store-cart-lines">
              {lines.map(([name, count]) => (
                <li key={name}>
                  <img src={getItemUrl(name)} alt="" />
                  <div>
                    <p>{itemLabel(name)}</p>
                    <span>{money((stockOf(name)?.price || 0) * count)}</span>
                  </div>
                  <div className="store-stepper">
                    <button onClick={() => setCount(name, count - 1)}>−</button>
                    <input
                      type="text"
                      value={count}
                      onChange={(event) => setCount(name, parseInt(event.target.value.replace(/\D/g, ''), 10) || 0)}
                    />
                    <button onClick={() => setCount(name, count + 1)}>+</button>
                  </div>
                </li>
              ))}
            </ul>
          )}
          <div className="store-cart-footer">
            <div className="store-total">
              <span>{t('ui_store_total', 'Total')}</span>
              <strong>{money(total)}</strong>
            </div>
            {store.methods.length > 1 && (
              <div className="store-methods">
                {store.methods.map((m) => (
                  <button key={m} className={method === m ? 'active' : undefined} onClick={() => setMethod(m)}>
                    {m === 'cash' ? t('ui_store_cash', 'Cash') : t('ui_store_bank', 'Card')}
                  </button>
                ))}
              </div>
            )}
            <button className="store-pay" disabled={busy || lines.length === 0} onClick={pay}>
              {t('ui_store_pay', 'Pay')} {total > 0 && money(total)}
            </button>
          </div>
        </aside>
      )}
    </div>
  );
};

export default StoreView;
