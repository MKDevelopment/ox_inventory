import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { fetchNui } from '../utils/fetchNui';
import { isEnvBrowser } from '../utils/misc';
import type { AppDispatch } from '.';

export interface GarmentPart {
  category: 'component' | 'prop';
  id: number;
  data: { collection?: string; index: number; texture: number };
}

export interface EquipmentEntry {
  item: string;
  worn: boolean;
  parts: GarmentPart[];
}

interface ClothingState {
  enabled: boolean;
  open: boolean;
  camera: boolean;
  equipment: EquipmentEntry[];
}

const initialState: ClothingState = {
  enabled: isEnvBrowser(),
  open: false,
  camera: false,
  equipment: [],
};

// Lua encodes an empty table as an object
const toList = <T>(value: unknown): T[] => (Array.isArray(value) ? value : []);

const normalise = (equipment: unknown): EquipmentEntry[] =>
  toList<EquipmentEntry>(equipment).map((entry) => ({ ...entry, parts: toList<GarmentPart>(entry.parts) }));

export const clothingSlice = createSlice({
  name: 'clothing',
  initialState,
  reducers: {
    setClothingEnabled(state, action: PayloadAction<boolean>) {
      state.enabled = action.payload;
    },
    clothingOpened(state, action: PayloadAction<{ camera: boolean; equipment: unknown }>) {
      state.open = true;
      state.camera = action.payload.camera;
      state.equipment = normalise(action.payload.equipment);
    },
    clothingClosed(state) {
      state.open = false;
      state.camera = false;
    },
    setEquipment(state, action: PayloadAction<unknown>) {
      state.equipment = normalise(action.payload);
    },
  },
});

export const { setClothingEnabled, clothingOpened, clothingClosed, setEquipment } = clothingSlice.actions;

export const openClothing = async (dispatch: AppDispatch) => {
  const response = await fetchNui<{ enabled: boolean; camera?: boolean; equipment?: unknown } | undefined>(
    'clothingOpen'
  );

  if (response && !response.enabled) {
    dispatch(setClothingEnabled(false));
    return false;
  }

  dispatch(clothingOpened({ camera: !!response?.camera, equipment: response?.equipment }));
  return true;
};

export const closeClothing = (dispatch: AppDispatch) => {
  dispatch(clothingClosed());
  fetchNui('clothingClose');
};

export default clothingSlice.reducer;
