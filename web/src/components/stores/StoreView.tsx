import React, { useMemo, useState } from 'react';
import logo from '../../assets/logo.webp';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { SearchIcon } from '../mystory/icons';
import StoreManage from './StoreManage';
import { useImageFallback } from '../../store/imageFallback';

export type StoreProduct = { name: string; price: number; stock: number };

export type StoreManagement = {
  cash: number;
  type: 'stock' | 'infinite';
  items: Array<{ name: string; price: number; enabled: boolean; stock: number }>;
};

export type PaymentOption = {
  id: string;
  kind: 'cash' | 'personal' | 'business';
  label?: string;
  last4?: string;
  balance: number;
  disabled?: 'frozen' | 'no_access';
};

export type StoreData = {
  id: number;
  label: string;
  products: StoreProduct[];
  management?: StoreManagement;
  payments: PaymentOption[];
  tab?: 'manage';
};

export const t = (key: string, fallback: string) => Locale[key] || fallback;

export const money = (value: number) => `$${value.toLocaleString('en-US')}`;

export const itemLabel = (name: string) => Items[name]?.label || name;

const paymentTitle = (option: PaymentOption) => {
  if (option.kind === 'cash') return t('ui_store_cash', 'Cash');
  const kind =
    option.kind === 'business'
      ? t('ui_store_card_business', 'Business card')
      : t('ui_store_card_personal', 'Personal card');
  return option.label ? `${kind} · ${option.label}` : kind;
};

const PaymentTile: React.FC<{ option: PaymentOption; active: boolean; short: boolean; onSelect: () => void }> = ({
  option,
  active,
  short,
  onSelect,
}) => (
  <button
    className={`store-payment ${option.kind}${active ? ' active' : ''}${short ? ' short' : ''}`}
    disabled={!!option.disabled}
    onClick={onSelect}
  >
    <span className="store-payment-title">{paymentTitle(option)}</span>
    {option.last4 && <span className="store-payment-number">•••• {option.last4}</span>}
    <span className="store-payment-balance">
      {option.disabled === 'frozen'
        ? t('ui_store_card_frozen', 'Card blocked')
        : option.disabled === 'no_access'
          ? t('ui_store_card_no_access', 'No access to this account')
          : money(option.balance)}
    </span>
  </button>
);

const StoreView: React.FC<{ store: StoreData; onUpdate: (store: StoreData) => void }> = ({ store, onUpdate }) => {
  useImageFallback();
  const [tab, setTab] = useState<'shop' | 'manage'>(store.tab === 'manage' && store.management ? 'manage' : 'shop');
  const [cart, setCart] = useState<Record<string, number>>({});
  const [paymentId, setPaymentId] = useState<string | undefined>(
    () => store.payments.find((option) => !option.disabled)?.id
  );
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
  const payment = store.payments.find((option) => option.id === paymentId && !option.disabled);
  const canPay = !!payment && lines.length > 0 && payment.balance >= total;

  const pay = async () => {
    if (busy || !canPay) return;
    setBusy(true);

    const response = await fetchNui<{ success: boolean; store?: StoreData }>('storeCheckout', {
      id: store.id,
      cart: Object.fromEntries(lines),
      payment: paymentId,
    });

    if (response?.success) setCart({});
    if (response?.store) {
      onUpdate(response.store);
      if (!response.store.payments.some((option) => option.id === paymentId && !option.disabled)) {
        setPaymentId(response.store.payments.find((option) => !option.disabled)?.id);
      }
    }
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
                    <span>
                      {count} × {money(stockOf(name)?.price || 0)} = <b>{money((stockOf(name)?.price || 0) * count)}</b>
                    </span>
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
            {store.payments.length === 0 ? (
              <p className="store-no-payment">{t('ui_store_no_payment', 'You have no cash or card on you.')}</p>
            ) : (
              <div className="store-payments">
                {store.payments.map((option) => (
                  <PaymentTile
                    key={option.id}
                    option={option}
                    active={option.id === paymentId}
                    short={option.balance < total}
                    onSelect={() => setPaymentId(option.id)}
                  />
                ))}
              </div>
            )}
            {payment && (
              <div className="store-after">
                <span>{t('ui_store_after', 'Left after paying')}</span>
                <strong className={payment.balance < total ? 'short' : undefined}>
                  {money(payment.balance - total)}
                </strong>
              </div>
            )}
            <button className="store-pay" disabled={busy || !canPay} onClick={pay}>
              {t('ui_store_pay', 'Pay')} {total > 0 && money(total)}
            </button>
          </div>
        </aside>
      )}
    </div>
  );
};

export default StoreView;
