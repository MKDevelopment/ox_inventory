import { useSyncExternalStore } from 'react';
import placeholderSvg from '../assets/item-placeholder.svg';

// slots use unquoted css url(...), where the quotes Vite leaves in inlined svg data URIs are invalid
const placeholder = placeholderSvg.replace(/'/g, '%27');

// Item images that failed to load are replaced by a generic icon, so items without artwork still look intentional.
const checked = new Set<string>();
const failed = new Set<string>();
const listeners = new Set<() => void>();
let version = 0;

const notify = () => {
  version++;
  listeners.forEach((listener) => listener());
};

const check = (url: string) => {
  if (checked.has(url)) return;
  checked.add(url);

  const image = new Image();
  image.onerror = () => {
    failed.add(url);
    notify();
  };
  image.src = url;
};

export const withImageFallback = (url?: string) => {
  if (!url || url.startsWith('data:')) return url;
  check(url);
  return failed.has(url) ? placeholder : url;
};

/** Whether an image is known to be missing (checks it on first use). */
export const imageFailed = (url: string) => {
  check(url);
  return failed.has(url);
};

const subscribe = (listener: () => void) => {
  listeners.add(listener);
  return () => listeners.delete(listener);
};

/** Re-renders the calling component when an item image turns out to be missing. */
export const useImageFallback = () => useSyncExternalStore(subscribe, () => version);
