import { Inventory, SlotWithItem } from '../../typings';
import React, { Fragment, useMemo } from 'react';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { useAppSelector } from '../../store';
import ClockIcon from '../utils/icons/ClockIcon';
import { getItemUrl } from '../../helpers';
import Divider from '../utils/Divider';
import Markdown from '../utils/Markdown';
import WeightBar from '../utils/WeightBar';
import { getCategoryLabel, getItemCategory } from '../../helpers/category';

const formatDuration = (seconds: number) => {
  const days = Math.floor(seconds / 86400);
  const hours = Math.floor((seconds % 86400) / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);

  if (days > 0) return `${days} d ${hours} h`;
  if (hours > 0) return `${hours} h ${minutes} min`;
  return `${Math.max(1, minutes)} min`;
};

// metadata.durability of spoiling items is a unix timestamp (seconds) of when they spoil
const formatSpoilTime = (expiresAt: number) => {
  const remaining = expiresAt - Math.floor(Date.now() / 1000);

  if (remaining <= 0) return Locale.ui_spoiled || 'Spoiled';

  return (Locale.ui_spoils_in || 'Spoils in %s').replace('%s', formatDuration(remaining));
};

const formatWeight = (weight: number) =>
  weight >= 1000 ? `${(weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 2 })}kg` : `${weight}g`;

const SlotTooltip: React.ForwardRefRenderFunction<
  HTMLDivElement,
  { item: SlotWithItem; inventoryType: Inventory['type']; style: React.CSSProperties }
> = ({ item, inventoryType, style }, ref) => {
  const additionalMetadata = useAppSelector((state) => state.inventory.additionalMetadata);
  const itemData = useMemo(() => Items[item.name], [item]);
  const ingredients = useMemo(() => {
    if (!item.ingredients) return null;
    return Object.entries(item.ingredients).sort((a, b) => a[1] - b[1]);
  }, [item]);
  const description = item.metadata?.description || itemData?.description;
  const ammoName = itemData?.ammoName && Items[itemData?.ammoName]?.label;

  return (
    <>
      {!itemData ? (
        <div className="tooltip-wrapper" ref={ref} style={style}>
          <div className="tooltip-header-wrapper">
            <p>{item.name}</p>
          </div>
          <Divider />
        </div>
      ) : (
        <div style={{ ...style }} className="tooltip-wrapper" ref={ref}>
          <div className="tooltip-header-wrapper">
            <p>{item.metadata?.label || itemData.label || item.name}</p>
            {inventoryType === 'crafting' ? (
              <div className="tooltip-crafting-duration">
                <ClockIcon />
                <p>{(item.duration !== undefined ? item.duration : 3000) / 1000}s</p>
              </div>
            ) : (
              <span className="tooltip-category">
                {item.metadata?.type || getCategoryLabel(getItemCategory(item.name))}
              </span>
            )}
          </div>
          {inventoryType !== 'crafting' && (
            <div className="tooltip-stats">
              {item.weight > 0 && (
                <span>
                  {Locale.ui_weight || 'Weight'}: <b>{formatWeight(item.weight)}</b>
                </span>
              )}
              {item.count > 1 && (
                <span>
                  <b>{item.count.toLocaleString('en-us')}x</b>
                </span>
              )}
            </div>
          )}
          <Divider />
          {item.metadata?.renamed && (
            <p className="tooltip-original">
              {Locale.ui_original_name || 'Original name'}: {item.metadata.baseLabel || itemData.label}
            </p>
          )}
          {description && (
            <div className="tooltip-description">
              <Markdown content={description} className="tooltip-markdown" />
            </div>
          )}
          {inventoryType !== 'crafting' ? (
            <>
              {item.durability !== undefined && (
                <div className="tooltip-durability">
                  <p>
                    {item.metadata?.degrade ? Locale.ui_freshness || 'Freshness' : Locale.ui_durability}:{' '}
                    {Math.trunc(item.durability)}%
                  </p>
                  <WeightBar percent={item.durability} durability />
                  {item.metadata?.degrade && item.metadata?.durability > 100 && (
                    <p>{formatSpoilTime(item.metadata.durability)}</p>
                  )}
                  {item.metadata?.degrade && item.durability <= 0 && getItemCategory(item.name) === 'food' && (
                    <p className="tooltip-spoiled">{Locale.ui_spoiled_edible || 'Can be eaten, but may poison you'}</p>
                  )}
                  {item.metadata?.cooled && (
                    <p className="tooltip-cooled">
                      {(Locale.ui_cooled || 'In a fridge, spoils %sx slower').replace(
                        '%s',
                        String(item.metadata.cooled)
                      )}
                    </p>
                  )}
                </div>
              )}
              {item.metadata?.ammo !== undefined && (
                <p>
                  {Locale.ui_ammo}: {item.metadata.ammo}
                </p>
              )}
              {ammoName && (
                <p>
                  {Locale.ammo_type}: {ammoName}
                </p>
              )}
              {item.metadata?.serial && (
                <p>
                  {Locale.ui_serial}: {item.metadata.serial}
                </p>
              )}
              {item.metadata?.components && item.metadata?.components[0] && (
                <p>
                  {Locale.ui_components}:{' '}
                  {(item.metadata?.components).map((component: string, index: number, array: []) =>
                    index + 1 === array.length ? Items[component]?.label : Items[component]?.label + ', '
                  )}
                </p>
              )}
              {item.metadata?.weapontint && (
                <p>
                  {Locale.ui_tint}: {item.metadata.weapontint}
                </p>
              )}
              {additionalMetadata.map((data: { metadata: string; value: string }, index: number) => (
                <Fragment key={`metadata-${index}`}>
                  {item.metadata && item.metadata[data.metadata] && (
                    <p>
                      {data.value}: {item.metadata[data.metadata]}
                    </p>
                  )}
                </Fragment>
              ))}
            </>
          ) : (
            <div className="tooltip-ingredients">
              {ingredients &&
                ingredients.map((ingredient) => {
                  const [item, count] = [ingredient[0], ingredient[1]];
                  return (
                    <div className="tooltip-ingredient" key={`ingredient-${item}`}>
                      <img src={item ? getItemUrl(item) : 'none'} alt="item-image" />
                      <p>
                        {count >= 1
                          ? `${count}x ${Items[item]?.label || item}`
                          : count === 0
                            ? `${Items[item]?.label || item}`
                            : count < 1 && `${count * 100}% ${Items[item]?.label || item}`}
                      </p>
                    </div>
                  );
                })}
            </div>
          )}
        </div>
      )}
    </>
  );
};

export default React.forwardRef(SlotTooltip);
