import React from 'react';
import logo from '../../assets/logo.webp';
import { Locale } from '../../store/locale';

const Hint: React.FC<{ keys: string[]; label: string }> = ({ keys, label }) => (
  <div className="inventory-hint">
    {keys.map((key) => (
      <kbd key={key}>{key}</kbd>
    ))}
    <span>{label}</span>
  </div>
);

const InventoryHeader: React.FC = () => (
  <div className="inventory-header">
    <div className="inventory-brand">
      <img src={logo} alt="MyStory" />
      <p>
        My<span>Story</span>RP
      </p>
    </div>
    <div className="inventory-hints">
      <Hint keys={['Shift']} label={Locale.ui_hint_split || 'split'} />
      <Hint keys={['Ctrl', 'LMB']} label={Locale.ui_hint_quickmove || 'quick move'} />
      <Hint keys={['Esc']} label={Locale.ui_hint_close || 'close'} />
    </div>
  </div>
);

export default InventoryHeader;
