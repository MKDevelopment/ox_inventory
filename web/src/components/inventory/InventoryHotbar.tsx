import React, { useMemo, useState } from 'react';
import { getItemUrl, getTotalWeight, isSlotWithItem } from '../../helpers';
import useNuiEvent from '../../hooks/useNuiEvent';
import { Items } from '../../store/items';
import WeightBar from '../utils/WeightBar';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { SlotWithItem } from '../../typings';
import SlideUp from '../utils/transitions/SlideUp';
import { useImageFallback } from '../../store/imageFallback';

const InventoryHotbar: React.FC = () => {
  useImageFallback();
  const [hotbarVisible, setHotbarVisible] = useState(false);
  const leftInventory = useAppSelector(selectLeftInventory);
  const items = leftInventory.items.slice(0, 5);
  const weight = useMemo(() => getTotalWeight(leftInventory.items), [leftInventory.items]);
  const weightPercent = leftInventory.maxWeight ? Math.min(100, (weight / leftInventory.maxWeight) * 100) : 0;

  //stupid fix for timeout
  const [handle, setHandle] = useState<ReturnType<typeof setTimeout>>();
  useNuiEvent('toggleHotbar', () => {
    if (hotbarVisible) {
      setHotbarVisible(false);
    } else {
      if (handle) clearTimeout(handle);
      setHotbarVisible(true);
      setHandle(setTimeout(() => setHotbarVisible(false), 3000));
    }
  });

  return (
    <SlideUp in={hotbarVisible}>
      <div className="hotbar-container">
        {leftInventory.maxWeight ? (
          <div className="hotbar-weight">
            <span>
              {(weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })}/{leftInventory.maxWeight / 1000}kg
            </span>
            <WeightBar percent={weightPercent} />
          </div>
        ) : null}
        <div className="hotbar-slots">
          {items.map((item) => (
            <div
              className="hotbar-item-slot"
              style={{
                backgroundImage: `url(${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`,
              }}
              key={`hotbar-${item.slot}`}
            >
              {isSlotWithItem(item) && (
                <div className="item-slot-wrapper">
                  <div className="hotbar-slot-header-wrapper">
                    <div className="inventory-slot-number">{item.slot}</div>
                    <div className="item-slot-info-wrapper">
                      <p>
                        {item.weight > 0
                          ? item.weight >= 1000
                            ? `${(item.weight / 1000).toLocaleString('en-us', {
                                minimumFractionDigits: 2,
                              })}kg `
                            : `${item.weight.toLocaleString('en-us', {
                                minimumFractionDigits: 0,
                              })}g `
                          : ''}
                      </p>
                      <p>{item.count ? item.count.toLocaleString('en-us') + `x` : ''}</p>
                    </div>
                  </div>
                  <div>
                    {item?.durability !== undefined && <WeightBar percent={item.durability} durability />}
                    <div className="inventory-slot-label-box">
                      <div className="inventory-slot-label-text">
                        {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </SlideUp>
  );
};

export default InventoryHotbar;
