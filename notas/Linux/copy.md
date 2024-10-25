# Copy

[..](../linux_me_la_pela.md)

## Copiado parametrizado

```bash
cp *.{txt,md} ~/Documents/copiados/
```

```powershell
cpi -Include *.txt,*.md -Destination ~/Documents/copiados/
```

## Copiado como accion despues de una busqueda

```bash
fd .(txt|md) -exec cp {} ~/Documents/copiados/ \;
```

```powershell
fd .(txt|md) | cpi -Destination ~/Documents/copiados/
```

## Mas argumentos para filtrar

```bash
fd ".(txt|yml)" --changed-within 4w -exec cp {} ~/Documents/copiados/ \;
```

```powershell
fd ".(txt|yml)" --changed-within 4w | cpi -Destination ~/Documents/copiados/
```
## Otro ejemplo de expresiones regulares

```bash
cp ejemplo[1,2,3].txt ~/Documents/copiados/
```

```powershell
fd "ejemplo(1|2|3).txt" | cpi -Destination ./nada/
```