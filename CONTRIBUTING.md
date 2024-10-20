## Development Guide

 1. **Comventional Commits**

    For contributors, it is important to follow the commit message convention to have a clean and organized history. The commit message should be structured as follows:

    ```bash
        <type>(<scope>): <subject>
    ```

    Where `<type>` is one of the following:

    - **build**: Cambios que afectan el sistema de construcción o dependencias externas (ejemplo: gulp, broccoli, npm).
    - **ci**: Cambios en los archivos y scripts de configuración y automatización de CI (ejemplo: Travis, Circle, BrowserStack, SauceLabs).
    - **chore**: Otros cambios que no modifican el código fuente ni los archivos de prueba.
    - **docs**: Cambios en la documentación.
    - **feat**: Una nueva funcionalidad.
    - **fix**: Una corrección de errores.
    - **perf**: Un cambio de código que mejora el rendimiento.
    - **refactor**: Un cambio de código que no corrige un error ni agrega una función.
    - **revert**: Revierte un commit anterior.
    - **style**: Cambios que no afectan el significado del código (espacios en blanco, formato, punto y coma que faltan, etc.).
    - **test**: Agregar pruebas faltantes o corregir pruebas existentes.
    - **deploy**: Cambios referidos al despliege de la aplicacion

    For `<scope>`, it is optional and represents the module or component that is being modified.

    Example:

    ```bash
        feat(auth): allow provided config object to extend other configs
        fix(user): ensure bucket key does not have leading slash