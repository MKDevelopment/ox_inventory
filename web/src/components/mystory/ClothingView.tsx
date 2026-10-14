import React, { useRef } from 'react';
import { useDrag, useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import { selectLeftInventory, selectRightInventory } from '../../store/inventory';
import { EquipmentEntry } from '../../store/clothing';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getItemUrl, isSlotWithItem } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { DragSource, Inventory, Slot, SlotWithItem } from '../../typings';
import InventorySlot from '../inventory/InventorySlot';

const SET_ITEM = 'clothe_set';
const EQUIPMENT = 'EQUIPMENT';

type EquipmentDrag = { item: string; image: string };

export const isWardrobe = (inventory: Inventory) =>
  typeof inventory.id === 'string' && inventory.id.startsWith('wardrobe:');

const useGarmentSource = () => {
  const left = useAppSelector(selectLeftInventory);
  const right = useAppSelector(selectRightInventory);

  return (source: DragSource): { item: SlotWithItem; fromWardrobe: boolean } | undefined => {
    const fromWardrobe = isWardrobe(right) && source.inventory === right.type;
    const inventory = fromWardrobe ? right : source.inventory === left.type ? left : undefined;
    const item = inventory?.items.find((slot) => slot.slot === source.item.slot);

    return item && isSlotWithItem(item) ? { item, fromWardrobe } : undefined;
  };
};

const wear = (item: SlotWithItem, fromWardrobe: boolean) => fetchNui('clothingWear', { item, fromWardrobe });

const EquipmentSlot: React.FC<{ entry: EquipmentEntry }> = ({ entry }) => {
  const dispatch = useAppDispatch();
  const resolve = useGarmentSource();
  const timer = useRef<number | null>(null);

  // what is worn, shaped like a garment item so the photo and the tooltip work as for carried ones
  const garment: SlotWithItem = {
    name: entry.item,
    slot: 0,
    count: 1,
    weight: 0,
    metadata: { type: 'clothe', data: entry.parts, model: entry.model },
  };
  const image = `url(${getItemUrl(entry.worn ? garment : entry.item) || 'none'})`;

  const hideTooltip = () => {
    if (timer.current) window.clearTimeout(timer.current);
    timer.current = null;
    dispatch(closeTooltip());
  };

  const [{ isDragging }, drag] = useDrag<EquipmentDrag, void, { isDragging: boolean }>(
    () => ({
      type: EQUIPMENT,
      item: { item: entry.item, image },
      canDrag: entry.worn,
      collect: (monitor) => ({ isDragging: monitor.isDragging() }),
    }),
    [entry]
  );

  const [{ isOver, canDrop }, drop] = useDrop<DragSource, void, { isOver: boolean; canDrop: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({ isOver: monitor.isOver(), canDrop: monitor.canDrop() }),
      canDrop: (source) => (source.item.name === entry.item || source.item.name === SET_ITEM) && !!resolve(source),
      drop: (source) => {
        dispatch(closeTooltip());
        const garment = resolve(source);
        if (garment) wear(garment.item, garment.fromWardrobe);
      },
    }),
    [entry, resolve]
  );

  return (
    <div
      ref={(element) => {
        drag(drop(element));
      }}
      className={`equipment-slot${entry.worn ? ' worn' : ''}${isOver && canDrop ? ' over' : ''}${canDrop ? ' accepts' : ''}`}
      style={{ opacity: isDragging ? 0.4 : 1 }}
      onMouseEnter={() => {
        if (!entry.worn) return;
        timer.current = window.setTimeout(() => dispatch(openTooltip({ item: garment, inventoryType: 'player' })), 400);
      }}
      onMouseLeave={hideTooltip}
      onMouseDown={hideTooltip}
    >
      <div className="equipment-image" style={{ backgroundImage: image }} />
      <span className="equipment-label">{Items[entry.item]?.label || entry.item}</span>
      {!entry.worn && <span className="equipment-state">{Locale.ui_clothing_nothing || 'Nothing'}</span>}
    </div>
  );
};

const WardrobeSlot: React.FC<{ item: Slot; inventory: Inventory }> = ({ item, inventory }) => {
  const [{ isOver }, drop] = useDrop<EquipmentDrag, void, { isOver: boolean }>(
    () => ({
      accept: EQUIPMENT,
      collect: (monitor) => ({ isOver: monitor.isOver() }),
      drop: (source) => {
        fetchNui('clothingTakeOff', { item: source.item, toSlot: item.name ? undefined : item.slot });
      },
    }),
    [item]
  );

  return (
    <div
      ref={(element) => {
        drop(element);
      }}
      className={`wardrobe-slot${isOver ? ' over' : ''}`}
      onDoubleClick={() => isSlotWithItem(item) && wear(item, true)}
    >
      <InventorySlot
        item={item}
        inventoryType={inventory.type}
        inventoryGroups={inventory.groups}
        inventoryId={inventory.id}
      />
    </div>
  );
};

const ClothingView: React.FC = () => {
  const equipment = useAppSelector((state) => state.clothing.equipment);
  const right = useAppSelector(selectRightInventory);
  const wardrobe = isWardrobe(right) ? right : undefined;

  return (
    <div className="clothing-view">
      <div className="clothing-section">
        <p className="section-title">{Locale.ui_clothing_worn || 'Worn'}</p>
        <div className="equipment-grid">
          {equipment.map((entry) => (
            <EquipmentSlot key={entry.item} entry={entry} />
          ))}
        </div>
      </div>

      <div className="clothing-section">
        <p className="section-title">
          {Locale.ui_clothing_wardrobe || 'Wardrobe'}
          {wardrobe && (
            <span className="clothing-count">
              {wardrobe.items.filter((item) => item.name).length}/{wardrobe.slots}
            </span>
          )}
        </p>
        <div className="wardrobe-grid">
          {wardrobe?.items.map((item) => (
            <WardrobeSlot key={`wardrobe-${item.slot}`} item={item} inventory={wardrobe} />
          ))}
        </div>
      </div>
    </div>
  );
};

const ZOOM_PRESETS = ['head', 'body', 'feet'] as const;

/** Transparent area over the character: drag to turn, buttons to zoom. */
export const ClothingStage: React.FC = () => {
  const camera = useAppSelector((state) => state.clothing.camera);
  const drag = useRef<{ x: number; pending: number; timer: number | null } | null>(null);

  const flush = () => {
    const state = drag.current;
    if (!state) return;
    state.timer = null;
    if (state.pending) fetchNui('clothingRotate', state.pending);
    state.pending = 0;
  };

  return (
    <div
      className={`clothing-stage${camera ? ' has-camera' : ''}`}
      onMouseDown={(event) => {
        if (event.button === 0) drag.current = { x: event.clientX, pending: 0, timer: null };
      }}
      onMouseMove={(event) => {
        const state = drag.current;
        if (!state || !camera) return;
        state.pending += event.clientX - state.x;
        state.x = event.clientX;
        if (state.timer === null) state.timer = window.setTimeout(flush, 30);
      }}
      onMouseUp={() => {
        flush();
        drag.current = null;
      }}
      onMouseLeave={() => {
        flush();
        drag.current = null;
      }}
    >
      {camera && (
        <div className="clothing-controls" onMouseDown={(event) => event.stopPropagation()}>
          <span className="clothing-hint">{Locale.ui_clothing_rotate || 'Drag to turn'}</span>
          <div className="clothing-zoom">
            {ZOOM_PRESETS.map((preset) => (
              <button key={preset} onClick={() => fetchNui('clothingZoom', preset)}>
                {Locale[`ui_clothing_zoom_${preset}`] || preset}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default ClothingView;
