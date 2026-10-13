import React, { useEffect, useState } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import { fetchNui } from '../../utils/fetchNui';
import StoreView, { StoreData } from './StoreView';
import StoreAdmin, { AdminStore } from './StoreAdmin';

const StoreApp: React.FC = () => {
  const [store, setStore] = useState<StoreData | null>(null);
  const [admin, setAdmin] = useState<AdminStore[] | null>(null);

  useNuiEvent<StoreData>('openStore', (data) => {
    setAdmin(null);
    setStore(data);
  });

  useNuiEvent<AdminStore[]>('openStoreAdmin', (data) => {
    setStore(null);
    setAdmin(data);
  });

  useNuiEvent('closeStore', () => {
    setStore(null);
    setAdmin(null);
  });

  const open = store !== null || admin !== null;

  useEffect(() => {
    if (!open) return;

    const onKey = (event: KeyboardEvent) => {
      if (event.code !== 'Escape') return;
      event.stopImmediatePropagation();
      setStore(null);
      setAdmin(null);
      fetchNui('storeClose');
    };

    window.addEventListener('keyup', onKey, true);
    return () => window.removeEventListener('keyup', onKey, true);
  }, [open]);

  if (store) return <StoreView store={store} onUpdate={setStore} />;
  if (admin) return <StoreAdmin stores={admin} onUpdate={setAdmin} />;

  return null;
};

export default StoreApp;
