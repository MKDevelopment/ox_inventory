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
import { garmentGender, garmentParts, partLabel } from '../../helpers/clothing';

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

const pad = (value: number) => String(value).padStart(2, '0');

const formatBestBefore = (expiresAt: number) => {
  const date = new Date(expiresAt * 1000);
  const day = `${pad(date.getDate())}.${pad(date.getMonth() + 1)}.${date.getFullYear()}`;

  return `${Locale.ui_best_before || 'Best before'}: ${day} ${pad(date.getHours())}:${pad(date.getMinutes())}`;
};

// vms_documentsv2 documents keep their data in metadata (see its item renderer)
const LICENSE_KEYS = ['drive_a', 'drive_b', 'drive_c', 'practical_plane', 'practical_helicopter', 'practical_boat'];

const documentRows = (metadata: Record<string, any>) => {
  const licenses = LICENSE_KEYS.map((key) => metadata[key])
    .filter((value) => typeof value === 'string' && value.trim() !== '')
    .join(', ');
  const name = [metadata.firstName, metadata.lastName].filter(Boolean).join(' ');

  return [
    [Locale.ui_doc_name || 'Name', name],
    [Locale.ui_doc_birth || 'Date of birth', metadata.dateOfBirth],
    [Locale.ui_doc_ssn || 'SSN', metadata.ssn],
    [Locale.ui_doc_licenses || 'Licences', licenses],
    [Locale.ui_doc_grade || 'Grade', metadata.jobGrade],
    [Locale.ui_doc_badge || 'Badge number', metadata.badgeNumber],
    [Locale.ui_doc_serial || 'Serial number', metadata.document_id],
  ].filter(([, value]) => value !== undefined && value !== null && String(value).trim() !== '' && value !== 'NONE');
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
                {(item.metadata?.type !== 'clothe' && item.metadata?.type) ||
                  getCategoryLabel(getItemCategory(item.name))}
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
          {itemData.tier && (
            <p className="tooltip-tier">
              <b>{Locale[`ui_tier_${itemData.tier.name}`] || itemData.tier.name}</b>
              {Object.entries(itemData.tier.caps)
                .map(([status, cap]) =>
                  (Locale[`ui_tier_${status}`] || `${status} up to %s%%`).replace('%s', String(cap)).replace('%%', '%')
                )
                .map((text) => `, ${text}`)
                .join('')}
            </p>
          )}
          {item.metadata?.renamed && (
            <p className="tooltip-original">
              {Locale.ui_original_name || 'Original name'}: {item.metadata.baseLabel || itemData.label}
            </p>
          )}
          {item.metadata?.document_id && (
            <div className="tooltip-document">
              {documentRows(item.metadata).map(([label, value]) => (
                <p key={label}>
                  <span>{label}</span>
                  <b>{String(value)}</b>
                </p>
              ))}
            </div>
          )}
          {garmentParts(item.metadata).length > 0 && (
            <div className="tooltip-document tooltip-garment">
              {garmentGender(item.metadata?.model) && (
                <p>
                  <span>{Locale.ui_clothing_fits || 'Fits'}</span>
                  <b>{Locale[`ui_clothing_${garmentGender(item.metadata?.model)}`]}</b>
                </p>
              )}
              {garmentParts(item.metadata).map((part) => (
                <p key={`${part.category}${part.id}`}>
                  <span>{partLabel(part)}</span>
                  <b>
                    {Locale.ui_clothing_drawable || 'ID'} {part.data.index} · {Locale.ui_clothing_texture || 'Variant'}{' '}
                    {part.data.texture}
                    {part.data.collection ? ` · ${part.data.collection}` : ''}
                  </b>
                </p>
              ))}
            </div>
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
                    <>
                      <p>{formatBestBefore(item.metadata.durability)}</p>
                      <p>{formatSpoilTime(item.metadata.durability)}</p>
                    </>
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
