import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// Essas linhas são necessárias para usar __dirname com ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const distDir = path.join(__dirname, 'dist');

function fixPaths(dir) {
  fs.readdir(dir, (err, files) => {
    if (err) {
      console.error(`Erro ao ler o diretório ${dir}: ${err}`);
      return;
    }

    files.forEach((file) => {
      const filePath = path.join(dir, file);
      if (fs.statSync(filePath).isDirectory()) {
        fixPaths(filePath);
      } else if (file.endsWith('.html')) {
        let content = fs.readFileSync(filePath, 'utf8');
        content = content.replace(/href="\/_astro\//g, 'href="./_astro/');
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Caminhos corrigidos em ${filePath}`);
      }
    });
  });
}

fixPaths(distDir);
