import React, { useEffect, useRef, useState } from 'react';
import { Locale } from '../../store/locale';
import { Items } from '../../store/items';
import { fetchNui } from '../../utils/fetchNui';
import { SlotWithItem } from '../../typings';

export type MetadataField = 'label' | 'note';

type EditRequest = { item: SlotWithItem; field: MetadataField };

const EVENT = 'mystory:editMetadata';

export const openMetadataEditor = (item: SlotWithItem, field: MetadataField) =>
  window.dispatchEvent(new CustomEvent<EditRequest>(EVENT, { detail: { item, field } }));

const LIMITS: Record<MetadataField, number> = { label: 32, note: 120 };

const MetadataEditor: React.FC = () => {
  const [request, setRequest] = useState<EditRequest | null>(null);
  const [value, setValue] = useState('');
  const inputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    const open = (event: Event) => {
      const { item, field } = (event as CustomEvent<EditRequest>).detail;
      setRequest({ item, field });
      setValue(field === 'label' ? (item.metadata?.renamed && item.metadata.label) || '' : item.metadata?.note || '');
    };

    window.addEventListener(EVENT, open);
    return () => window.removeEventListener(EVENT, open);
  }, []);

  useEffect(() => {
    if (request) inputRef.current?.focus();
  }, [request]);

  if (!request) return null;

  const { item, field } = request;
  const itemLabel = item.metadata?.label || Items[item.name]?.label || item.name;

  const save = () => {
    fetchNui('editItemMetadata', { slot: item.slot, field, value });
    setRequest(null);
  };

  return (
    <div className="metadata-editor-overlay" onMouseDown={() => setRequest(null)}>
      <form
        className="metadata-editor"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={(event) => {
          event.preventDefault();
          save();
        }}
      >
        <h3>
          {field === 'label' ? Locale.ui_rename || 'Rename' : Locale.ui_note || 'Note'}: {itemLabel}
        </h3>
        <input
          ref={inputRef}
          type="text"
          value={value}
          maxLength={LIMITS[field]}
          onChange={(event) => setValue(event.target.value)}
          onKeyDown={(event) => {
            // keep Escape/Tab from closing the inventory while typing
            event.stopPropagation();
            if (event.key === 'Escape') setRequest(null);
          }}
        />
        <p>
          {field === 'label' ? Locale.ui_rename_hint : Locale.ui_note_hint}
          <span>
            {value.length}/{LIMITS[field]}
          </span>
        </p>
        <div className="metadata-editor-actions">
          <button type="button" onClick={() => setRequest(null)}>
            {Locale.ui_cancel || 'Cancel'}
          </button>
          <button type="submit" className="primary">
            {Locale.ui_save || 'Save'}
          </button>
        </div>
      </form>
    </div>
  );
};

export default MetadataEditor;
