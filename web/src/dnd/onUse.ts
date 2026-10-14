import { fetchNui } from '../utils/fetchNui';
import { Slot } from '../typings';

export const onUse = (item: Slot) => {
  fetchNui('useItem', item.slot);
};

// items inside an open wallet are taken out to the pocket and used there (the server checks it is a wallet)
export const onUseInContainer = (item: Slot) => {
  fetchNui('walletUse', item.slot);
};
