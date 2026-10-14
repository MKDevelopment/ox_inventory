export let imagepath = 'images';
export let imageformat = 'png';

export function setImagePath(path: string) {
  if (path && path !== '') imagepath = path;
}

export function setImageFormat(format?: string) {
  if (format && /^[a-z0-9]+$/.test(format)) imageformat = format;
}
