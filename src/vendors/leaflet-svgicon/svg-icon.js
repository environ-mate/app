/* global L */

// Leaflet-SVGIcon
// SVG icon for any marker class
// Ilya Atkin

L.DivIcon.SVGIcon = L.DivIcon.extend({
  options: {
    circleText: '',
    className: 'svg-icon',
    circleAnchor: null,
    circleColor: null,
    circleOpacity: null,
    circleFillColor: 'rgb(255,255,255)',
    circleFillOpacity: null,
    circleRatio: 0.5,
    circleWeight: null,
    color: 'rgb(0,102,255)',
    fillColor: null,
    fillOpacity: 0.4,
    fontColor: 'rgb(0, 0, 0)',
    fontOpacity: '1',
    fontSize: null,
    fontWeight: 'normal',
    iconAnchor: null,
    iconSize: L.point(32, 48),
    opacity: 1,
    popupAnchor: null,
    weight: 2,
  },

  initialize(rawOptions) {
    const options = L.Util.setOptions(this, rawOptions);

    const { iconSize } = options;
    options.iconSize = L.point(iconSize);

    if (!options.circleAnchor) {
      options.circleAnchor = L.point(iconSize.x / 2, iconSize.x / 2);
    } else {
      options.circleAnchor = L.point(options.circleAnchor);
    }
    if (!options.circleColor) options.circleColor = options.color;
    if (!options.circleFillOpacity) options.circleFillOpacity = options.opacity;
    if (!options.circleOpacity) options.circleOpacity = options.opacity;
    if (!options.circleWeight) options.circleWeight = options.weight;
    if (!options.fillColor) options.fillColor = options.color;
    if (!options.fontSize) options.fontSize = iconSize.x / 4;

    if (!options.iconAnchor) {
      options.iconAnchor = L.point(iconSize.x / 2, iconSize.y);
    } else {
      options.iconAnchor = L.point(options.iconAnchor);
    }

    if (!options.popupAnchor) {
      options.popupAnchor = L.point(0, (-0.75) * iconSize.y);
    } else {
      options.popupAnchor = L.point(options.popupAnchor);
    }

    options.html = this.createSVG();
  },

  createCircle() {
    const {
      circleAnchor,
      iconSize,
      circleFillColor,
      circleFillOpacity,
      circleColor,
      circleOpacity,
      circleWeight,
      className,
    } = this.options;
    const cx = circleAnchor.x;
    const cy = circleAnchor.y;
    const radius = (iconSize.x / 2) * this.options.circleRatio;

    return (
      `<circle class="${className}-circle" cx="${cx}" cy="${cy}" r="${radius}" `
      + `fill="${circleFillColor}" fill-opacity="${circleFillOpacity}" `
      + `stroke="${circleColor}" stroke-opacity="${circleOpacity}" stroke-width="${circleWeight}"/>`
    );
  },

  createPathDescription() {
    const { iconSize, weight } = this.options;
    const height = iconSize.y;
    const width = iconSize.x;
    const margin = weight / 2;

    const startPoint = `M ${margin} ${width / 2} `;
    const leftLine = `L ${width / 2} ${height - weight} `;
    const rightLine = `L ${width - margin} ${width / 2} `;
    const arc = `A ${width / 4} ${width / 4} 0 0 0 ${margin} ${width / 2} Z`;

    return startPoint + leftLine + rightLine + arc;
  },

  createPath() {
    const {
      weight, color, opacity, fillColor, fillOpacity, className,
    } = this.options;

    const d = this.createPathDescription();

    return (
      `<path class="${className}-path" d="${d}" stroke-width="${weight}" `
      + `stroke="${color}" stroke-opacity="${opacity}" `
      + `fill="${fillColor}" fill-opacity="${fillOpacity}"/>`
    );
  },

  createText() {
    const {
      fontSize, fontWeight, circleAnchor, circleText, fontColor, fontOpacity,
    } = this.options;

    const { x } = circleAnchor;
    const y = circleAnchor.y + fontSize * 0.35;
    const fill = fontColor.replace('rgb(', 'rgba(').replace(')', `,${fontOpacity})`);

    return (
      `<text text-anchor="middle" x="${x}" y="${y}" `
      + `style="font-size: ${fontSize}px; font-weight: ${fontWeight}" `
      + `fill="${fill}">${circleText}</text>`
    );
  },

  createSVG() {
    const { className, iconSize } = this.options;

    const path = this.createPath();
    const circle = this.createCircle();
    const text = this.createText();

    const style = `width:${iconSize.x}px; height:${iconSize.y}px;`;

    return (
      `<svg xmlns='http://www.w3.org/2000/svg' version='1.1' `
      + `class='${className}-svg' style='${style}'>${path}${circle}${text}</svg>`
    );
  },
});

L.divIcon.svgIcon = function (options) {
  return new L.DivIcon.SVGIcon(options);
};

L.Marker.SVGMarker = L.Marker.extend({
  options: {
    iconFactory: L.divIcon.svgIcon,
    iconOptions: {},
  },

  initialize(latlng, rawOptions) {
    const options = L.Util.setOptions(this, rawOptions);
    options.icon = options.iconFactory(options.iconOptions);
    // eslint-disable-next-line no-underscore-dangle
    this.__latlng = latlng; // private var
  },

  // eslint-disable-next-line no-underscore-dangle
  getLatLng() {
    // eslint-disable-next-line no-underscore-dangle
    return this.__latlng;
  },

  onAdd(map) {
    L.Marker.prototype.onAdd.call(this, map);
  },

  setStyle(incomingStyle) {
    if (!this.iconEl) return;

    const svg = this.iconEl.children[0];
    const iconBody = svg.children[0];
    const iconCircle = svg.children[1];

    const styleOpts = { ...incomingStyle }; // Avoid param reassignment

    if (styleOpts.color && !styleOpts.iconOptions) {
      const stroke = styleOpts.color
        .replace('rgb', 'rgba')
        .replace(')', `,${this.options.icon.options.opacity})`);
      const fill = styleOpts.color
        .replace('rgb', 'rgba')
        .replace(')', `,${this.options.icon.options.fillOpacity})`);
      iconBody.setAttribute('stroke', stroke);
      iconBody.setAttribute('fill', fill);
      iconCircle.setAttribute('stroke', stroke);

      this.options.icon.fillColor = fill;
      this.options.icon.color = stroke;
      this.options.icon.circleColor = stroke;
    }

    if (styleOpts.opacity) {
      this.setOpacity(styleOpts.opacity);
    }

    if (styleOpts.iconOptions) {
      if (styleOpts.color) {
        styleOpts.iconOptions.color = styleOpts.color;
      }
      const iconOptions = L.Util.setOptions(this.options.icon, styleOpts.iconOptions);
      this.setIcon(L.divIcon.svgIcon(iconOptions));
    }
  },
});

L.marker.svgMarker = function (latlng, options) {
  return new L.Marker.SVGMarker(latlng, options);
};
