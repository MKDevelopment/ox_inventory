import InventoryComponent from './components/inventory';
import useNuiEvent from './hooks/useNuiEvent';
import { Items } from './store/items';
import { Locale } from './store/locale';
import { setImageFormat, setImagePath } from './store/imagepath';
import { setupInventory } from './store/inventory';
import { setClothingEnabled } from './store/clothing';
import { setClothingImage } from './helpers/clothing';
import { Inventory } from './typings';
import { useAppDispatch } from './store';
import { debugData } from './utils/debugData';
import DragPreview from './components/utils/DragPreview';
import { fetchNui } from './utils/fetchNui';
import { useDragDropManager } from 'react-dnd';
import KeyPress from './components/utils/KeyPress';
import StoreApp from './components/stores/StoreApp';

debugData([
  {
    action: 'setupInventory',
    data: {
      leftInventory: {
        id: 'test',
        type: 'player',
        slots: 50,
        label: 'Bob Smith',
        weight: 3000,
        maxWeight: 5000,
        items: [
          {
            slot: 1,
            name: 'iron',
            weight: 3000,
            metadata: {
              description: `name: Svetozar Miletic  \n Gender: Male`,
              ammo: 3,
              mustard: '60%',
              ketchup: '30%',
              mayo: '10%',
            },
            count: 5,
          },
          { slot: 2, name: 'powersaw', weight: 0, count: 1, metadata: { durability: 75 } },
          { slot: 3, name: 'copper', weight: 100, count: 12, metadata: { type: 'Special' } },
          {
            slot: 4,
            name: 'water',
            weight: 100,
            count: 1,
            metadata: { description: 'Generic item description' },
          },
          { slot: 5, name: 'water', weight: 100, count: 1 },
          {
            slot: 6,
            name: 'backwoods',
            weight: 100,
            count: 1,
            metadata: {
              label: 'Russian Cream',
              imageurl: 'https://i.imgur.com/2xHhTTz.png',
            },
          },
          {
            slot: 7,
            name: 'WEAPON_PISTOL',
            weight: 1130,
            count: 1,
            metadata: { durability: 64, serial: 'POL123', ammo: 12 },
          },
          { slot: 8, name: 'clothing_top', weight: 300, count: 1, metadata: { label: 'Top #42' } },
          { slot: 9, name: 'bandage', weight: 115, count: 4 },
        ],
      },
      rightInventory: {
        id: 'shop',
        type: 'crafting',
        slots: 5000,
        label: 'Bob Smith',
        weight: 3000,
        maxWeight: 5000,
        items: [
          {
            slot: 1,
            name: 'lockpick',
            weight: 500,
            price: 300,
            ingredients: {
              iron: 5,
              copper: 12,
              powersaw: 0.1,
            },
            metadata: {
              description: 'Simple lockpick that breaks easily and can pick basic door locks',
            },
          },
        ],
      },
    },
  },
]);

const App: React.FC = () => {
  const dispatch = useAppDispatch();
  const manager = useDragDropManager();

  useNuiEvent<{
    locale: { [key: string]: string };
    items: typeof Items;
    leftInventory: Inventory;
    imagepath: string;
    imageformat?: string;
    clothing?: boolean;
    clothingImage?: string;
  }>('init', ({ locale, items, leftInventory, imagepath, imageformat, clothing, clothingImage }) => {
    for (const name in locale) Locale[name] = locale[name];
    for (const name in items) Items[name] = items[name];

    setImagePath(imagepath);
    setImageFormat(imageformat);
    dispatch(setupInventory({ leftInventory }));
    dispatch(setClothingEnabled(!!clothing));
    setClothingImage(clothingImage);
  });

  fetchNui('uiLoaded', {});

  useNuiEvent('closeInventory', () => {
    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  return (
    <div className="app-wrapper">
      <InventoryComponent />
      <DragPreview />
      <KeyPress />
      <StoreApp />
    </div>
  );
};

const isTextField = (target: EventTarget | null) =>
  target instanceof HTMLInputElement && (target.type === 'text' || target.type === 'number');

addEventListener('focusin', (event) => isTextField(event.target) && fetchNui('inputFocus', true));
addEventListener('focusout', (event) => isTextField(event.target) && fetchNui('inputFocus', false));

addEventListener('dragstart', function (event) {
  event.preventDefault();
});

export default App;
