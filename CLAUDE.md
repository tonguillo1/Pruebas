# Pruebas — vídeos con HyperFrames

Repo para crear vídeos con [HyperFrames](https://github.com/heygen-com/hyperframes)
(HTML + CSS + GSAP → MP4), incluidos ZIPs exportados desde Claude Design.

## Entorno cloud
- `.claude/hooks/session-start.sh` instala Chrome Headless Shell y las skills core de
  HyperFrames al arrancar cada sesión (el contenedor es efímero).
- CLI fijada a `hyperframes@0.8.140` en el hook y en `scripts/new-video.sh`.
- **El proxy bloquea `cdn.jsdelivr.net`, `unpkg.com` y `cdnjs`.** Solo el registro npm
  (y Google Fonts) responden. Cualquier librería por CDN debe servirse en local desde
  `vendor/` (`npm pack <paquete>@<versión>` y copiar el `dist/`). Si no, el render falla con
  `sub_timeline_script_failure`.

## Flujo
- Proyecto nuevo: `scripts/new-video.sh <nombre> [--resolution portrait]`
- ZIP de Claude Design: descomprimir en una carpeta, sustituir el `<script src>` de GSAP
  por `vendor/gsap.min.js` (copiarlo de `demo/vendor/`) y verificar con `lint`.
- Dentro del proyecto: `npx hyperframes@0.8.140 lint` → `check` → `render -o salida.mp4`.
- `preview` (Studio en :3002) no se puede ver desde el entorno cloud; usar `snapshot`
  o extraer fotogramas con ffmpeg para revisar visualmente.
