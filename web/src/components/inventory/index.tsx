import React, { useEffect, useState } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryControl from './InventoryControl';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch, useAppSelector } from '../../store';
import { clothingClosed, setEquipment } from '../../store/clothing';
import { ClothingStage } from '../mystory/ClothingView';
import { refreshSlots, setAdditionalMetadata, setupInventory } from '../../store/inventory';
import { useExitListener } from '../../hooks/useExitListener';
import type { Inventory as InventoryProps } from '../../typings';
import RightInventory from './RightInventory';
import LeftInventory from './LeftInventory';
import Tooltip from '../utils/Tooltip';
import { closeTooltip } from '../../store/tooltip';
import InventoryContext from './InventoryContext';
import MetadataEditor from '../mystory/MetadataEditor';
import { closeContextMenu } from '../../store/contextMenu';
import Fade from '../utils/transitions/Fade';

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  const dispatch = useAppDispatch();
  const clothingOpen = useAppSelector((state) => state.clothing.open);

  useNuiEvent<boolean>('setInventoryVisible', setInventoryVisible);
  useNuiEvent<false>('closeInventory', () => {
    setInventoryVisible(false);
    dispatch(clothingClosed());
    dispatch(closeContextMenu());
    dispatch(closeTooltip());
  });
  useExitListener(setInventoryVisible);

  useEffect(() => {
    if (!inventoryVisible) dispatch(clothingClosed());
  }, [inventoryVisible]);

  useNuiEvent<{
    leftInventory?: InventoryProps;
    rightInventory?: InventoryProps;
  }>('setupInventory', (data) => {
    dispatch(setupInventory(data));
    !inventoryVisible && setInventoryVisible(true);
  });

  useNuiEvent('clothingEquipment', (data) => dispatch(setEquipment(data)));

  useNuiEvent('refreshSlots', (data) => dispatch(refreshSlots(data)));

  useNuiEvent('displayMetadata', (data: Array<{ metadata: string; value: string }>) => {
    dispatch(setAdditionalMetadata(data));
  });

  return (
    <>
      <Fade in={inventoryVisible}>
        <div className={`inventory-wrapper${clothingOpen ? ' clothing-open' : ''}`}>
          <div className="inventory-layout">
            <div className="inventory-columns">
              <LeftInventory />
              {clothingOpen ? <ClothingStage /> : <RightInventory />}
            </div>
            <InventoryControl />
          </div>
          <Tooltip />
          <InventoryContext />
          <MetadataEditor />
        </div>
      </Fade>
      <InventoryHotbar />
    </>
  );
};

export default Inventory;
