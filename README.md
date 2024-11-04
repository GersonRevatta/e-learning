# Documentación de Endpoints - E-Learning API

## Instalación

### Instalación 
```
- clone project 
- bundle install
- rails s 
```

### Versiones 
```

ruby -v 2.6.8
rails -v 5.2.8.1
```

### Specs
```

  rspec spec/models/*
  rspec spec/requests/*  
```


## Endpoints para Cursos

### Obtener todos los cursos
**GET /api/v1/courses**

- **Descripción**: Obtiene una lista de todos los cursos disponibles.
- **Respuesta**: Lista de cursos con sus detalles básicos (nombre, descripción, etc.).

### Obtener detalles de un curso específico
**GET /api/v1/courses/:id**

- **Descripción**: Obtiene los detalles de un curso específico.
- **Parámetro**:
  - `:id`: ID del curso.
- **Respuesta**: Detalles completos del curso.

### Crear un nuevo curso
**POST /api/v1/courses**

- **Descripción**: Crea un nuevo curso. Solo accesible para profesores.
- **Cuerpo**: JSON con los detalles del curso (nombre, descripción, etc.).
- **Respuesta**: Detalles del curso creado.

### Actualizar un curso existente
**PUT /api/v1/courses/:id**

- **Descripción**: Actualiza un curso existente. Solo accesible para profesores.
- **Parámetro**:
  - `:id`: ID del curso.
- **Cuerpo**: JSON con los nuevos detalles del curso.
- **Respuesta**: Detalles del curso actualizado.

### Eliminar un curso
**DELETE /api/v1/courses/:id**

- **Descripción**: Elimina un curso. Solo accesible para profesores.
- **Parámetro**:
  - `:id`: ID del curso.
- **Respuesta**: No hay contenido (204 No Content).

---

## Endpoints para Lecciones

### Obtener todas las lecciones de un curso
**GET /api/v1/courses/:course_id/lessons**

- **Descripción**: Obtiene una lista de todas las lecciones de un curso específico.
- **Parámetro**:
  - `:course_id`: ID del curso.
- **Respuesta**: Lista de lecciones con sus detalles básicos.

### Obtener detalles de una lección específica
**GET /api/v1/courses/:course_id/lessons/:id**

- **Descripción**: Obtiene los detalles de una lección específica.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:id`: ID de la lección.
- **Respuesta**: Detalles completos de la lección.

### Crear una nueva lección
**POST /api/v1/courses/:course_id/lessons**

- **Descripción**: Crea una nueva lección en un curso. Solo accesible para profesores.
- **Parámetro**:
  - `:course_id`: ID del curso.
- **Cuerpo**: JSON con los detalles de la lección (nombre, descripción, umbral de aprobación, etc.).
- **Respuesta**: Detalles de la lección creada.

### Actualizar una lección existente
**PUT /api/v1/courses/:course_id/lessons/:id**

- **Descripción**: Actualiza una lección existente en un curso. Solo accesible para profesores.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:id`: ID de la lección.
- **Cuerpo**: JSON con los nuevos detalles de la lección.
- **Respuesta**: Detalles de la lección actualizada.

### Eliminar una lección
**DELETE /api/v1/courses/:course_id/lessons/:id**

- **Descripción**: Elimina una lección de un curso. Solo accesible para profesores.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:id`: ID de la lección.
- **Respuesta**: No hay contenido (204 No Content).

---

## Endpoints para Preguntas

### Obtener todas las preguntas de una lección
**GET /api/v1/courses/:course_id/lessons/:lesson_id/questions**

- **Descripción**: Obtiene una lista de todas las preguntas de una lección específica.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:lesson_id`: ID de la lección.
- **Respuesta**: Lista de preguntas con detalles básicos.

### Obtener detalles de una pregunta específica
**GET /api/v1/courses/:course_id/lessons/:lesson_id/questions/:id**

- **Descripción**: Obtiene los detalles de una pregunta específica.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:lesson_id`: ID de la lección.
  - `:id`: ID de la pregunta.
- **Respuesta**: Detalles completos de la pregunta.

### Crear una nueva pregunta
**POST /api/v1/courses/:course_id/lessons/:lesson_id/questions**

- **Descripción**: Crea una nueva pregunta en una lección. Solo accesible para profesores.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:lesson_id`: ID de la lección.
- **Cuerpo**: JSON con los detalles de la pregunta (contenido, tipo de pregunta, puntuación, etc.).
- **Respuesta**: Detalles de la pregunta creada.

### Actualizar una pregunta existente
**PUT /api/v1/courses/:course_id/lessons/:lesson_id/questions/:id**

- **Descripción**: Actualiza una pregunta existente en una lección. Solo accesible para profesores.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:lesson_id`: ID de la lección.
  - `:id`: ID de la pregunta.
- **Cuerpo**: JSON con los nuevos detalles de la pregunta.
- **Respuesta**: Detalles de la pregunta actualizada.

### Eliminar una pregunta
**DELETE /api/v1/courses/:course_id/lessons/:lesson_id/questions/:id**

- **Descripción**: Elimina una pregunta de una lección. Solo accesible para profesores.
- **Parámetros**:
  - `:course_id`: ID del curso.
  - `:lesson_id`: ID de la lección.
  - `:id`: ID de la pregunta.
- **Respuesta**: No hay contenido (204 No Content).

---

## Endpoint para Tomar Lección

### Enviar respuestas a una lección
**POST /api/v1/choice_lessons/take**

- **Descripción**: Permite que los estudiantes envíen todas las respuestas de una lección en una única solicitud.
- **Cuerpo**: JSON con las respuestas a las preguntas de la lección.
- **Respuesta**: Resultado de la evaluación de la lección (ej., puntuación obtenida y si fue aprobada).
