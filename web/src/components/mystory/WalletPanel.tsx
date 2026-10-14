import React, { useState } from 'react';
import { Locale } from '../../store/locale';
import { fetchNui } from '../../utils/fetchNui';

const money = (value: number) => `$${value.toLocaleString('en-US')}`;

// Cash kept on the wallet item; the server moves it to and from the pocket.
const WalletPanel: React.FC<{ slot: number; cash: number }> = ({ slot, cash }) => {
  const [amount, setAmount] = useState('');
  const [busy, setBusy] = useState(false);
  const value = parseInt(amount, 10) || 0;

  const send = async (action: 'walletDeposit' | 'walletWithdraw') => {
    if (busy || value <= 0) return;
    setBusy(true);
    const success = await fetchNui<boolean>(action, { slot, amount: value });
    if (success) setAmount('');
    setBusy(false);
  };

  return (
    <div className="wallet-panel">
      <div className="wallet-cash">
        <span>{Locale.ui_wallet_cash || 'Cash in wallet'}</span>
        <strong>{money(cash)}</strong>
      </div>
      <div className="wallet-actions">
        <input
          type="text"
          inputMode="numeric"
          value={amount}
          placeholder={Locale.ui_wallet_amount || 'Amount'}
          onChange={(event) => setAmount(event.target.value.replace(/\D/g, '').slice(0, 9))}
        />
        <button disabled={busy || value <= 0} onClick={() => send('walletDeposit')}>
          {Locale.ui_wallet_deposit || 'Put in'}
        </button>
        <button disabled={busy || value <= 0 || value > cash} onClick={() => send('walletWithdraw')}>
          {Locale.ui_wallet_withdraw || 'Take out'}
        </button>
      </div>
    </div>
  );
};

export default WalletPanel;
