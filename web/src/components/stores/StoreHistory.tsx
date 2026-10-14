import React, { useEffect, useState } from 'react';
import { fetchNui } from '../../utils/fetchNui';
import { itemLabel, money, t } from './StoreView';

type Sale = {
  buyer_name?: string;
  items: Array<{ name: string; count: number; price: number }>;
  total: number;
  method: string;
  time: number;
};

type History = { sales: Sale[]; today: number; week: number };

const pad = (value: number) => String(value).padStart(2, '0');

// dd.mm hh:mm, independent of the CEF locale
const formatTime = (unix: number) => {
  const date = new Date(unix * 1000);
  return `${pad(date.getDate())}.${pad(date.getMonth() + 1)} ${pad(date.getHours())}:${pad(date.getMinutes())}`;
};

const StoreHistory: React.FC<{ storeId: number }> = ({ storeId }) => {
  const [history, setHistory] = useState<History | null>(null);

  useEffect(() => {
    fetchNui<{ success: boolean; result?: History }>('storeManage', { id: storeId, action: 'history' }).then(
      (response) => response?.success && response.result && setHistory(response.result)
    );
  }, [storeId]);

  if (!history) return null;

  return (
    <div className="store-history">
      <div className="store-manage-cards">
        <div className="store-card">
          <span>{t('ui_store_today', 'Today')}</span>
          <strong>{money(history.today)}</strong>
        </div>
        <div className="store-card">
          <span>{t('ui_store_week', 'Last 7 days')}</span>
          <strong>{money(history.week)}</strong>
        </div>
      </div>
      <div className="store-table">
        {history.sales.length === 0 && <p className="store-empty">{t('ui_store_no_sales', 'No sales yet.')}</p>}
        {history.sales.map((sale, index) => (
          <div className="store-row" key={index}>
            <span className="store-row-meta store-history-time">{formatTime(sale.time)}</span>
            <div className="store-row-name">
              <p>{sale.buyer_name || '?'}</p>
              <span>{sale.items.map((line) => `${line.count}x ${itemLabel(line.name)}`).join(', ')}</span>
            </div>
            <span className="store-row-meta">
              {sale.method === 'cash' ? t('ui_store_cash', 'Cash') : t('ui_store_bank', 'Card')}
            </span>
            <strong className="store-history-total">{money(sale.total)}</strong>
          </div>
        ))}
      </div>
    </div>
  );
};

export default StoreHistory;
