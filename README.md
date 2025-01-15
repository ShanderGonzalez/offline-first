# Offline First
Significa que una aplicación está diseñada para funcionar sin conexión a internet, permitiendo que los usuarios puedan usarla normalmente incluso cuando no tienen acceso a la red. Una vez que la conexión se restablece, la aplicación sincroniza los cambios realizados cuando estaba sin conexión.
Se menciona tambien donde offline first debería ser una opción predeterminada para los dispositivos móviles ya que facilitaria la interacción de estos con los usuarios.

**Lo que se necesita:**

- **Procesamiento de datos locales:** Se guarda información directamente en el dispositivo para usar la app sin internet y con mayor rapidez.
- **Procesamiento de datos en la nube:** Almacena una copia de los datos en internet para seguridad y acceso desde múltiples dispositivos.
- **Sincronización de datos:** Mantiene la información igual en el dispositivo y en la nube, actualizando los cambios entre ellos, se maneja de manera bidireccional.

**Algunas partes a considerar:**
- **WhatsApp:** Si bien es una aplicacion de mensajeria, no es al 100% offline first, por lo que parcialmente cumple con esta funcionalidad, el caso de enviar mensajes, estos encolan para luego ser enviados cuando se recupera la conexión.
- **Notion:** Esta aplicacion implementa parcialmente la arquitectura offline first ya que permite acceder y editar páginas visitadas recientemente sin conexión.
- **Trello:** Ofrece un soporte limitado de offline first ya que permite ver tableros y tarjetas ya cargadas, aunque si se realiza alguna edición, estos se guardan y se sincronizan luego cuando exista conexión.

Por lo tanto, esta practica se enfoca en la arquitectura **Offline-first** en base a las siguientes métricas:
- Flutter
- ObjectBox (como base de dato local)
- Supabase (como base de dato remota)

![image](https://github.com/user-attachments/assets/3bf555f2-9065-4fea-8c03-889b229bffbf)


