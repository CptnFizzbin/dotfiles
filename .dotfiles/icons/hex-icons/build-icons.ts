import svgToIco from 'svg-to-ico';
import path, { join } from 'node:path';
import fs from 'node:fs/promises';
import { glob } from 'glob';

const SVG_DIR = path.resolve(__dirname, 'svg');
const ICO_DIR = path.resolve(__dirname, 'ico');

const svgIcons = await glob('**/*.svg', { cwd: SVG_DIR });

for (const svgIcon of svgIcons.filter(icon => !icon.startsWith('_'))) {
  const svgPath = join(SVG_DIR, svgIcon);
  const svgInfo = await fs.stat(svgPath);

  const icoPath = join(ICO_DIR, svgIcon.replace('.svg', '.ico'));
  const icoInfo = await fs.stat(icoPath).catch(() => null);

  if (icoInfo) {
    if (svgInfo.mtime <= icoInfo.mtime) {
      console.log(`Skipping ${svgPath.replace(__dirname, '')} (up to date)`);
      continue;
    }
  }

  console.log(`Converting ${svgPath.replace(__dirname, '')} to ${icoPath.replace(__dirname, '')}`);
  await svgToIco({ input_name: svgPath, output_name: icoPath });
}
