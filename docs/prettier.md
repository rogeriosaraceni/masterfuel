# Instalar Prettier

-   npm install --save-dev prettier prettier-plugin-astro

#

Arquivo .prettierrc.json

```
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 4,
  "useTabs": false,
  "plugins": ["prettier-plugin-astro"]
}
```

"semi": true, // Sem ponto e vírgula no final das linhas<br>
"singleQuote": true, // Aspas simples<br>
"trailingComma": "es5", // Vírgula após o último elemento em arrays e objetos<br>
"printWidth": 80, // Largura máxima da linha<br>
"tabWidth": 4, // Tamanho da tabulação<br>
"useTabs": false, // Utiliza espaços em vez de tabs<br>
"plugins": ["prettier-plugin-astro"] // Plugin para formatar arquivos Astro
