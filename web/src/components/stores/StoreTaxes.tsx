import React, { useEffect, useState } from 'react';
import { fetchNui } from '../../utils/fetchNui';
import { money, t } from './StoreView';

type Period = { start: number; finish: number; sales: number; tax: number; paid?: number; status?: string };
type Summary = { current: Period; history: Period[]; owed: number; period: string };

const pad = (value: number) => String(value).padStart(2, '0');
const formatDate = (unix: number) => {
  const date = new Date(unix * 1000);
  return `${pad(date.getDate())}.${pad(date.getMonth() + 1)}.${date.getFullYear()}`;
};

const statusLabel = (status?: string) =>
  status === 'settled'
    ? t('ui_store_tax_settled', 'Paid')
    : status === 'overdue'
      ? t('ui_store_tax_overdue', 'Overdue')
      : t('ui_store_tax_open', 'Open');

// Tax included in the store's sales, settled from the till when each period ends.
const StoreTaxes: React.FC<{ storeId: number }> = ({ storeId }) => {
  const [summary, setSummary] = useState<Summary | null>(null);

  useEffect(() => {
    fetchNui<{ success: boolean; result?: Summary }>('storeManage', { id: storeId, action: 'taxes' }).then(
      (response) => response?.success && response.result && setSummary(response.result)
    );
  }, [storeId]);

  if (!summary) return null;

  const { current } = summary;

  return (
    <div className="store-history">
      <div className="store-manage-cards">
        <div className="store-card">
          <span>
            {t('ui_store_tax_current', 'This period')} ({formatDate(current.start)} – {formatDate(current.finish)})
          </span>
          <strong>{money(current.tax)}</strong>
          <span>
            {t('ui_store_tax_sales', 'Sales')}: {money(current.sales)}
          </span>
        </div>
        <div className="store-card">
          <span>{t('ui_store_tax_owed', 'Reserved in the till')}</span>
          <strong>{money(summary.owed)}</strong>
          <span>{t('ui_store_tax_note', 'Paid to the city from the till when the period ends')}</span>
        </div>
      </div>
      <div className="store-table">
        {summary.history.length === 0 && (
          <p className="store-empty">{t('ui_store_tax_none', 'No settled periods yet.')}</p>
        )}
        {summary.history.map((period) => (
          <div className="store-row" key={period.start}>
            <span className="store-row-meta store-history-time">
              {formatDate(period.start)} – {formatDate(period.finish)}
            </span>
            <div className="store-row-name">
              <p>{statusLabel(period.status)}</p>
              <span>
                {t('ui_store_tax_sales', 'Sales')}: {money(period.sales)}
              </span>
            </div>
            <span className="store-row-meta">
              {money(period.paid || 0)} / {money(period.tax)}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default StoreTaxes;
