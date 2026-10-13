import React, { useState } from 'react';
import logo from '../../assets/logo.webp';
import { fetchNui } from '../../utils/fetchNui';
import { money, t } from './StoreView';

export type AdminStore = {
  id: number;
  label: string;
  type: 'stock' | 'infinite';
  owner?: string;
  job?: string;
  grade: number;
  blip?: number;
  cash: number;
  items: number;
  distance: number;
};

type Form = {
  id?: number;
  label: string;
  type: 'stock' | 'infinite';
  job: string;
  grade: string;
  ownerId: string;
  blip: string;
};

const emptyForm: Form = { label: '', type: 'stock', job: '', grade: '0', ownerId: '', blip: '' };

const toForm = (store: AdminStore): Form => ({
  id: store.id,
  label: store.label,
  type: store.type,
  job: store.job || '',
  grade: String(store.grade),
  ownerId: '',
  blip: store.blip !== undefined && store.blip !== null ? String(store.blip) : '',
});

const StoreAdmin: React.FC<{ stores: AdminStore[]; onUpdate: (stores: AdminStore[]) => void }> = ({
  stores,
  onUpdate,
}) => {
  const [form, setForm] = useState<Form>(emptyForm);
  const selected = stores.find((store) => store.id === form.id);

  const call = async (action: string, data: Record<string, unknown>) => {
    const response = await fetchNui<{ success: boolean; result?: number; list?: AdminStore[] }>('storeAdmin', {
      action,
      data,
    });

    if (response?.list) onUpdate(response.list);
    return response;
  };

  const payload = () => ({
    id: form.id,
    label: form.label,
    type: form.type,
    job: form.job,
    grade: parseInt(form.grade, 10) || 0,
    ownerId: form.ownerId ? parseInt(form.ownerId, 10) : undefined,
    blip: form.blip !== '' ? parseInt(form.blip, 10) : undefined,
  });

  const save = async () => {
    if (!form.label.trim()) return;

    if (form.id) {
      await call('update', payload());
    } else {
      const response = await call('create', payload());
      if (response?.success && typeof response.result === 'number') setForm({ ...form, id: response.result });
    }
  };

  const field = (key: keyof Form) => ({
    value: form[key] as string,
    onChange: (event: React.ChangeEvent<HTMLInputElement>) => setForm({ ...form, [key]: event.target.value }),
  });

  return (
    <div className="store store-admin">
      <section className="store-main">
        <header className="store-header">
          <img src={logo} alt="MyStory" />
          <h1>{t('ui_store_admin', 'Stores')}</h1>
          <button className="store-close" onClick={() => fetchNui('storeClose')}>
            {t('ui_store_close', 'Close')}
            <kbd>Esc</kbd>
          </button>
        </header>
        <div className="store-table">
          {stores.map((store) => (
            <button
              key={store.id}
              className={`store-row admin${form.id === store.id ? ' selected' : ''}`}
              onClick={() => setForm(toForm(store))}
            >
              <span className="store-row-id">#{store.id}</span>
              <div className="store-row-name">
                <p>{store.label}</p>
                <span>
                  {store.type === 'stock'
                    ? t('ui_store_type_stock', 'Stock room')
                    : t('ui_store_type_infinite', 'Unlimited')}
                  {store.job ? `, ${store.job} ${store.grade}+` : ''}
                  {store.owner ? `, ${store.owner}` : ''}
                </span>
              </div>
              <span className="store-row-meta">{store.items}</span>
              <span className="store-row-meta">{money(store.cash)}</span>
              <span className="store-row-meta">{Math.round(store.distance)} m</span>
            </button>
          ))}
        </div>
      </section>

      <aside className="store-cart store-form">
        <h2>{form.id ? `#${form.id} ${selected?.label || ''}` : t('ui_store_new', 'New store here')}</h2>
        <label>
          <span>{t('ui_store_name', 'Name')}</span>
          <input type="text" maxLength={64} {...field('label')} />
        </label>
        <div className="store-methods">
          {(['stock', 'infinite'] as const).map((type) => (
            <button
              key={type}
              className={form.type === type ? 'active' : undefined}
              onClick={() => setForm({ ...form, type })}
            >
              {type === 'stock' ? t('ui_store_type_stock', 'Stock room') : t('ui_store_type_infinite', 'Unlimited')}
            </button>
          ))}
        </div>
        <div className="store-form-row">
          <label>
            <span>{t('ui_store_job', 'Job')}</span>
            <input type="text" maxLength={32} {...field('job')} />
          </label>
          <label>
            <span>{t('ui_store_grade', 'Min. grade')}</span>
            <input type="text" {...field('grade')} />
          </label>
        </div>
        <div className="store-form-row">
          <label>
            <span>{t('ui_store_owner', 'Owner (player id)')}</span>
            <input type="text" {...field('ownerId')} placeholder={selected?.owner || ''} />
          </label>
          <label>
            <span>{t('ui_store_blip', 'Blip sprite')}</span>
            <input type="text" {...field('blip')} />
          </label>
        </div>
        <div className="store-cart-footer">
          <button className="store-pay" onClick={save}>
            {form.id ? t('ui_store_save', 'Save') : t('ui_store_new', 'New store here')}
          </button>
          {form.id && (
            <div className="store-methods">
              <button onClick={() => call('move', { id: form.id })}>{t('ui_store_move', 'Move here')}</button>
              <button
                className="danger"
                onClick={async () => {
                  await call('delete', { id: form.id });
                  setForm(emptyForm);
                }}
              >
                {t('ui_store_delete', 'Delete')}
              </button>
            </div>
          )}
          {form.id && (
            <button className="store-link" onClick={() => setForm(emptyForm)}>
              {t('ui_store_new', 'New store here')}
            </button>
          )}
        </div>
      </aside>
    </div>
  );
};

export default StoreAdmin;
