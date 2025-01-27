
#CREACION DE LA tde_matricula_especial

CREATE TABLE tde_matricula_especial (
    marca_temporal VARCHAR(255),
    modalidad_matricula VARCHAR(255),
    referencia_matricula_especial VARCHAR(255),
    documento_identidad VARCHAR(255),
    nombres VARCHAR(255),
    apellido_paterno VARCHAR(255),
    apellido_materno VARCHAR(255),
    fecha_nacimiento VARCHAR(255),
    genero VARCHAR(255),
    correo VARCHAR(255),
    prefijo_movil VARCHAR(255),
    movil VARCHAR(255),
    pais VARCHAR(255),
    departamento_estado VARCHAR(255),
    linkedin VARCHAR(255),
    universidad VARCHAR(255),
    carrera VARCHAR(255),
    grado_academico VARCHAR(255),
    trabajo_practicas VARCHAR(255),
    centro_laboral VARCHAR(255),
    puesto_laboral VARCHAR(255),
    flag_reunion VARCHAR(255)
);

#CREACION DE LA tpm_matricula_especial

CREATE TABLE tpm_matricula_especial AS
SELECT
    STR_TO_DATE(marca_temporal, '%d/%m/%Y %H:%i:%s') AS d_marca_temporal,
    UPPER(modalidad_matricula) AS s_modalidad_matricula,
    UPPER(referencia_matricula_especial) AS s_referencia_matricula_especial,
    documento_identidad AS n_documento_identidad,
    UPPER(nombres) AS s_nombres,
    UPPER(apellido_paterno) AS s_apellido_paterno,
    UPPER(apellido_materno) AS s_apellido_materno,
    fecha_nacimiento AS d_fecha_nacimiento,
    UPPER(genero) AS s_genero,
    UPPER(correo) AS s_correo_usuario,
    CAST(prefijo_movil AS DECIMAL(40,0)) AS n_prefijo_movil,
    CAST(movil AS DECIMAL(40,0)) AS n_movil,
    UPPER(pais) AS s_pais,
    UPPER(departamento_estado) AS s_departamento_estado,
    UPPER(linkedin) AS s_linkedin,
    UPPER(universidad) AS s_universidad,
    UPPER(carrera) AS s_carrera,
    UPPER(grado_academico) AS s_grado_academico,
    UPPER(trabajo_practicas) AS s_trabajo_practicas,
    UPPER(centro_laboral) AS s_centro_laboral,
    UPPER(puesto_laboral) AS s_puesto_laboral,
    UPPER(flag_reunion) AS s_flag_reunion,
    SYSDATE() AS fecha_carga
FROM tde_matricula_especial;

#CREACION DE LA tde_matricula_ordinaria

CREATE TABLE tde_matricula_ordinaria (
    marca_temporal VARCHAR(255),
    documento_identidad VARCHAR(255),
    nombre VARCHAR(255),
    apellido_paterno VARCHAR(255),
    apellido_materno VARCHAR(255),
    fecha_nacimiento VARCHAR(255),
    genero VARCHAR(255),
    correo VARCHAR(255),
    prefijo_movil VARCHAR(255),
    movil VARCHAR(255),
    pais VARCHAR(255),
    departamento_estado VARCHAR(255),
    linkedin VARCHAR(255),
    universidad VARCHAR(255),
    carrera VARCHAR(255),
    grado_academico VARCHAR(255),
    perfil VARCHAR(255),
    trabajo_practicas VARCHAR(255),
    centro_laboral VARCHAR(255),
    puesto_laboral VARCHAR(255),
    flag_reunion VARCHAR(255)
);

#CREACION DE LA tpm_matricula_ordinaria

CREATE TABLE tpm_matricula_ordinaria AS
SELECT
    STR_TO_DATE(marca_temporal, '%d/%m/%Y %H:%i:%s') AS d_marca_temporal,
    documento_identidad AS n_documento_identidad,
    UPPER(nombre) AS s_nombre,
    UPPER(apellido_paterno) AS s_apellido_paterno,
    UPPER(apellido_materno) AS s_apellido_materno,
    fecha_nacimiento AS d_fecha_nacimiento,
    UPPER(genero) AS s_genero,
    UPPER(correo) AS s_correo_usuario,
    CAST(prefijo_movil AS DECIMAL(40,0)) AS n_prefijo_movil,
    CAST(movil AS DECIMAL(40,0)) AS n_movil,
    UPPER(pais) AS s_pais,
    UPPER(departamento_estado) AS s_departamento_estado,
    UPPER(linkedin) AS s_linkedin,
    UPPER(universidad) AS s_universidad,
    UPPER(carrera) AS s_carrera,
    UPPER(grado_academico) AS s_grado_academico,
    UPPER(perfil) AS s_perfil,
    UPPER(trabajo_practicas) AS s_trabajo_practicas,
    UPPER(centro_laboral) AS s_centro_laboral,
    UPPER(puesto_laboral) AS s_puesto_laboral,
    UPPER(flag_reunion) AS s_flag_reunion,
    SYSDATE() AS fecha_carga
FROM tde_matricula_ordinaria;


#tpm_matricula_ordinaria y tpm_matricula_especial creadas

select*from tpm_matricula_ordinaria;

#CREAMOS TEMPORAL t$_matriculados_ordinario_1

    CREATE TABLE t$_matriculados_ordinario_1 AS
        SELECT
            d_marca_temporal,
            n_documento_identidad,
            CAST(CONCAT(UPPER(s_nombre), ' ', UPPER(s_apellido_paterno), ' ', UPPER(s_apellido_materno)) AS CHAR(255))  s_nombres,
            STR_TO_DATE(d_fecha_nacimiento, '%d/%m/%Y') as d_fecha_nacimiento,
            s_genero,
            s_correo_usuario,
            n_prefijo_movil,
            n_movil,
            s_pais,
            s_departamento_estado,
            s_linkedin,
            s_universidad,
            s_carrera,
            s_grado_academico,
            s_perfil,
            s_trabajo_practicas,
            s_centro_laboral,
            s_puesto_laboral,
            s_flag_reunion
        FROM tpm_matricula_ordinaria;


#CREAMOS TEMPORAL t$_matriculados_especial_1

CREATE TABLE t$_matriculados_especial_1 AS
    SELECT
        d_marca_temporal,
        s_modalidad_matricula,
        s_referencia_matricula_especial,
        n_documento_identidad,
        CAST(CONCAT(UPPER(s_nombres), ' ', UPPER(s_apellido_paterno), ' ', UPPER(s_apellido_materno)) AS CHAR(255)) s_nombres,
        STR_TO_DATE(d_fecha_nacimiento, '%d/%m/%Y') as d_fecha_nacimiento,
        s_genero,
        s_correo_usuario,
        n_prefijo_movil,
        n_movil,
        s_pais,
        s_departamento_estado,
        s_linkedin,
        s_universidad,
        s_carrera,
        s_grado_academico,
        s_trabajo_practicas,
        s_centro_laboral,
        s_puesto_laboral,
        s_flag_reunion
    FROM tpm_matricula_especial;


# JOIN DEL t$_matriculados_especial_1, t$_matriculados_ordinario_1 CON EL t$_reuniones_zoom_2

    CREATE TABLE t$_matriculados AS (
        SELECT
            tr2.s_periodo,
            tr2.s_nombre_reunion,
            tr2.s_num_sesion,
            tr2.flag_reunion,
            tr2.tip_reunion,
            tr2.rubro_reunion,
            tr2.s_id_usuario_reunion,
            CASE
                WHEN tme1.s_nombres IS NOT NULL THEN tme1.s_nombres
                WHEN tmo1.s_nombres IS NOT NULL THEN tmo1.s_nombres
                ELSE tr2.s_nombres
            END AS s_nombres,
            tr2.s_correo_usuario,
            tr2.d_fec_ingreso,
            tr2.s_hora_ingreso,
            tr2.d_fec_salida,
            tr2.s_hora_salida,
            tr2.n_dur_segundos,
            tr2.n_dur_minutos,
            tr2.n_dur_horas,
            tr2.s_estado_usuario,
            tr2.d_fec_carga
        FROM t$_reuniones_zoom_2 tr2
        LEFT JOIN t$_matriculados_especial_1 tme1
            ON tr2.s_correo_usuario = tme1.s_correo_usuario
        LEFT JOIN t$_matriculados_ordinario_1 tmo1
            ON tr2.s_correo_usuario = tmo1.s_correo_usuario
    );

#CREACION DE TEM DE PRUEBA

        create table tem_reuniones_prueba
    (
        s_periodo            varchar(6) charset utf8mb4              null,
        s_nombre_reunion     varchar(255) collate utf8mb4_unicode_ci null,
        s_num_sesion         varchar(2) collate utf8mb4_unicode_ci   null,
        s_turno              varchar(9) charset utf8mb4              null,
        flag_reunion         varchar(255) collate utf8mb4_unicode_ci null,
        tip_reunion          varchar(255) collate utf8mb4_unicode_ci null,
        rubro_reunion        varchar(255) collate utf8mb4_unicode_ci null,
        s_id_usuario_reunion varchar(255) collate utf8mb4_unicode_ci null,
        s_nombres            varchar(255) collate utf8mb4_unicode_ci null,
        s_correo_usuario     varchar(255) collate utf8mb4_unicode_ci null,
        d_fec_ingreso        date                                    null,
        d_fec_salida         date                                    null,
        s_hora_ingreso       time                                    null,
        s_hora_salida        time                                    null,
        n_dur_segundos       decimal(42)                             null,
        n_dur_minutos        decimal(46, 4)                          null,
        n_dur_horas          decimal(46, 4)                          null,
        s_estado_usuario     varchar(17) charset utf8mb4             null,
        d_fec_carga          datetime                                not null
    );
#INSERCION DE DATOS A LA TEM

       INSERT INTO tem_reuniones_prueba (
        s_periodo,
        s_nombre_reunion,
        s_num_sesion,
        flag_reunion,
        tip_reunion,
        rubro_reunion,
        s_id_usuario_reunion,
        s_nombres,
        s_correo_usuario,
        d_fec_ingreso,
        s_hora_ingreso,
        d_fec_salida,
        s_hora_salida,
        n_dur_segundos,
        n_dur_minutos,
        n_dur_horas,
        s_estado_usuario,
        d_fec_carga
    )
    SELECT
        s_periodo,
        s_nombre_reunion,
        s_num_sesion,
        flag_reunion,
        tip_reunion,
        rubro_reunion,
        s_id_usuario_reunion,
        s_nombres,
        s_correo_usuario,
        d_fec_ingreso,
        s_hora_ingreso,
        d_fec_salida,
        s_hora_salida,
        n_dur_segundos,
        n_dur_minutos,
        n_dur_horas,
        s_estado_usuario,
        d_fec_carga
    FROM t$_matriculados;
