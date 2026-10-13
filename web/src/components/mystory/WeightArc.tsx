import React from 'react';

const RADIUS = 46;

// sunset palette: lavender while light, orange when heavy, red when (almost) full
const colorFor = (percent: number) => (percent >= 90 ? '#ef4444' : percent >= 65 ? '#f5a443' : '#a99bff');

const WeightArc: React.FC<{ weight: number; maxWeight: number }> = ({ weight, maxWeight }) => {
  const percent = maxWeight > 0 ? Math.min(100, (weight / maxWeight) * 100) : 0;
  const angle = Math.PI * (1 - percent / 100);
  const sunX = 60 + RADIUS * Math.cos(angle);
  const sunY = 56 - RADIUS * Math.sin(angle);
  const color = colorFor(percent);

  return (
    <div className="weight-arc" title={`${percent.toFixed(0)}%`}>
      <svg viewBox="0 0 120 62" aria-hidden>
        <path className="weight-arc-track" d="M14 56a46 46 0 0 1 92 0" pathLength={100} />
        <path
          className="weight-arc-fill"
          d="M14 56a46 46 0 0 1 92 0"
          pathLength={100}
          style={{ strokeDasharray: `${percent} 100`, stroke: color }}
        />
        <path className="weight-arc-horizon" d="M4 57h112" />
        <circle cx={sunX} cy={sunY} r={5} style={{ fill: color }} className="weight-arc-sun" />
      </svg>
      <div className="weight-arc-value">
        <strong>{(weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })}</strong>
        <span>/ {(maxWeight / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })} kg</span>
      </div>
    </div>
  );
};

export default WeightArc;
