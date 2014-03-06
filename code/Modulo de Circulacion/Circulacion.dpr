program Circulacion;

uses
  Forms,
  Fprincipal in 'Fprincipal.pas' {FPrincipalCirculacion},
  Acerca_de_Subs in 'Acerca_de_Subs.pas' {FAcercade},
  FCCatalogo_de_edificios in 'FCCatalogo_de_edificios.pas' {FCEdificios},
  FC_Catalogo_de_rutas_metropolitanas in 'FC_Catalogo_de_rutas_metropolitanas.pas' {FC_rutas_metropolitanas},
  FC_Catalogo_de_rutas_foraneas in 'FC_Catalogo_de_rutas_foraneas.pas' {FC_Rutas_foraneas},
  FC_Catalogo_de_repartidores_y_choferes in 'FC_Catalogo_de_repartidores_y_choferes.pas' {FC_Catalogo_repartidores_choferes},
  FC_Catalogo_de_proveedores_vendedores in 'FC_Catalogo_de_proveedores_vendedores.pas' {FC_Catalogo_proveedores_y_vendedores},
  F_Buscar_Proveedor in 'F_Buscar_Proveedor.pas' {FBuscar_proveedor},
  FC_Tipo_de_circulacion in 'FC_Tipo_de_circulacion.pas' {FCTipo_Circulacion},
  FR_Proveedores_dotacion in 'FR_Proveedores_dotacion.pas' {FR_Proveedoresdotacion},
  FAdministracion_rutas in 'FAdministracion_rutas.pas' {FAdmon_rutas},
  FRemision_ruta in 'FRemision_ruta.pas' {FRemision},
  FR_Imprimeremision in 'FR_Imprimeremision.pas' {FR_Imprime_remision},
  FC_Municipios_con_entrega in 'FC_Municipios_con_entrega.pas' {FCMunicipiosconentrega},
  FAlta_de_queja in 'FAlta_de_queja.pas' {FAltaQueja},
  FSeguimiento_Quejas in 'FSeguimiento_Quejas.pas' {FSeguimientoQ},
  FR_Reporte_seguimiento_queja in 'FR_Reporte_seguimiento_queja.pas' {FR_RepSegQueja},
  FR_Reporte_de_quejas in 'FR_Reporte_de_quejas.pas' {FR_reportequejas},
  FCaptura_Pagos in 'FCaptura_Pagos.pas' {FCapturaPagos},
  FBuscar_codigo_vendedor in 'FBuscar_codigo_vendedor.pas' {Fbuscarcodigo},
  FCaptura_devoluciones in 'FCaptura_devoluciones.pas' {Fdevoluciones},
  FCaptura_pagos_x_distribuidor in 'FCaptura_pagos_x_distribuidor.pas' {FCapturaXdistribuidor},
  FREstado_de_Cuenta in 'FREstado_de_Cuenta.pas' {FREstadoCuenta},
  FR_reporte_edo_cuenta_imp in 'FR_reporte_edo_cuenta_imp.pas' {FR_Edo_cuenta},
  FCorte_circulacion in 'FCorte_circulacion.pas' {Fcorte},
  FR_Hoja_Corte in 'FR_Hoja_Corte.pas' {FR_HojaCorte},
  FRImprime_Poliza in 'FRImprime_Poliza.pas' {FRImprimePoliza},
  FAutorizacion in 'FAutorizacion.pas' {FPassword},
  FC_Vendedores_zocalo in 'FC_Vendedores_zocalo.pas' {FCVendedoresZocalo},
  FCaptura_pagos_zocalo in 'FCaptura_pagos_zocalo.pas' {FCapturaZocalo},
  FC_Dotacion_total in 'FC_Dotacion_total.pas' {FCTotal_dotacion},
  FCorte_Zocalo in 'FCorte_Zocalo.pas' {Fcortezocalo},
  FRHojadeModifiacionRuta in 'FRHojadeModifiacionRuta.pas' {Fhoja_modif_ruta},
  F_BuscarCP in 'Subscripciones\F_BuscarCP.pas' {FbuscarCP},
  F_Modificar_Subscripcion in 'Subscripciones\F_Modificar_Subscripcion.pas' {FModificar_Subscripcion},
  FAlta_de_subscriptor in 'Subscripciones\FAlta_de_subscriptor.pas' {FAlta_subscriptor},
  FAlta_Subscripciones in 'Subscripciones\FAlta_Subscripciones.pas' {FSubscripciones},
  FAreas_de_entrega_en_edificio in 'Subscripciones\FAreas_de_entrega_en_edificio.pas' {FAreas_entrega_edificio},
  FAsignar_a_ruta_metropolitana in 'Subscripciones\FAsignar_a_ruta_metropolitana.pas' {FAsignarARutaMetro},
  FCancelar_subscripcion in 'Subscripciones\FCancelar_subscripcion.pas' {FCancelaciones},
  FModificar_subscriptor in 'Subscripciones\FModificar_subscriptor.pas' {FModif_subscriptor},
  FNueva_Area_Edificio in 'Subscripciones\FNueva_Area_Edificio.pas' {FNueva_area_de_edifcio},
  FNuevaSubscripcion in 'Subscripciones\FNuevaSubscripcion.pas' {FNueva_Subscripcion},
  FC_Codigos_postales in 'FC_Codigos_postales.pas' {FC_CP},
  FCambioNoFactura in 'Subscripciones\FCambioNoFactura.pas' {FCambio_Factura},
  FCambio_Subscriptor in 'FCambio_Subscriptor.pas' {FCambioSubscriptor},
  FR_Alta_Subscripcion in 'FR_Alta_Subscripcion.pas' {FRAltaSubscripcion},
  FImpCodigoBarras in 'FImpCodigoBarras.pas' {FImpCodigo},
  FImpHojasRuta in 'FImpHojasRuta.pas' {Fimprimirrutas},
  FR_Imprime_rutas_metro in 'FR_Imprime_rutas_metro.pas' {Form1},
  FQuejas_Cerradas in 'FQuejas_Cerradas.pas' {FQuejasCerradas},
  FQuejas_Subscripciones in 'Subscripciones\FQuejas_Subscripciones.pas' {FQuejasSubscripciones},
  FQuejasReporte in 'Subscripciones\FQuejasReporte.pas' {FQuejasR},
  FHistorial_Quejas in 'Subscripciones\FHistorial_Quejas.pas' {FHistorialQueja},
  FCanceladas_en_ruta in 'FCanceladas_en_ruta.pas' {FCanceladasR},
  FNuevas_enRuta in 'FNuevas_enRuta.pas' {FNuevosR},
  FAdmon_codigos in 'FAdmon_codigos.pas' {FAdmonCodigos},
  FEstadisticas_rutas in 'FEstadisticas_rutas.pas' {FEstadisticasRutas},
  FSuspender_Entrega in 'FSuspender_Entrega.pas' {FSuspenderEntrega},
  FInicidencias_ruta in 'FInicidencias_ruta.pas' {FIncidencias},
  FOrden_Entrega in 'FOrden_Entrega.pas' {FOrdenEntrega},
  FSeguimientoAltas in 'Supervisor\FSeguimientoAltas.pas' {FSeguimientoA},
  FSeguimientoCancelados in 'Supervisor\FSeguimientoCancelados.pas' {FCancelados},
  FNotasSubscripcion in 'Supervisor\FNotasSubscripcion.pas' {FNotas},
  FverNotas in 'Supervisor\FverNotas.pas' {Fver},
  FR_Notificacion_alta in 'Subscripciones\FR_Notificacion_alta.pas' {FRNotificacionalta},
  FBuscar_Supervisor in 'Supervisor\FBuscar_Supervisor.pas' {FBuscarSupervisor},
  FR_lista_ruta in 'FR_lista_ruta.pas' {FRHojadeRuta},
  FR_lista_edificio in 'FR_lista_edificio.pas' {FRlistaedificio},
  FR_lista_rutac in 'FR_lista_rutac.pas' {FRListaCancelados},
  FAsignar_C_Edificio in 'FAsignar_C_Edificio.pas' {FAsignarCEdificio},
  FNuevo_codigo in 'FNuevo_codigo.pas' {FNuevoCodigo},
  FAgrupar_codigos in 'FAgrupar_codigos.pas' {FAgruparCodigos},
  FSeguimiento_Cambios in 'FSeguimiento_Cambios.pas' {FSeguimientoCambios},
  F_Incidencias_descripcion in 'F_Incidencias_descripcion.pas' {FIncidenciasDescripcion},
  FIncidencia_global_circulacion in 'FIncidencia_global_circulacion.pas' {FIncidenciaGlobal},
  FLoginpass in 'FLoginpass.pas' {Flogin},
  FFCodigos_Agrupados in 'Supervisor\FFCodigos_Agrupados.pas' {FGrupos_codigos},
  FC_Lista_correos in 'Supervisor\FC_Lista_correos.pas' {FListaCorreos},
  Fadmon_DotaRuta in 'Fadmon_DotaRuta.pas' {FChoferDot},
  FReporteRemisionesRutas in 'FReporteRemisionesRutas.pas' {FRemisionRutas},
  FHistorial_entrega in 'Subscripciones\FHistorial_entrega.pas' {FHistorialEntrega},
  FAdmonCodigosVendedores in 'FAdmonCodigosVendedores.pas' {FCod_vendedores},
  FEntregaRutaVenta in 'FEntregaRutaVenta.pas' {FEntregaRutaVentas},
  FNotificarEntrega in 'FNotificarEntrega.pas' {FactivarEntrega},
  FEstadisticas_rutas_ventas in 'FEstadisticas_rutas_ventas.pas' {FestadisticasVEntas},
  Forden_Entrega_ventas in 'Forden_Entrega_ventas.pas' {FOrdenEntregaVentas},
  FDescripcion_Incidente_Entrega in 'FDescripcion_Incidente_Entrega.pas' {FDescripcionIncidente},
  FComentarios_quejas in 'Subscripciones\FComentarios_quejas.pas' {FcomentariosQuejas},
  FCerra_ConActa in 'FCerra_ConActa.pas' {FCierreConActa},
  FReactivar_suscripcion in 'Subscripciones\FReactivar_suscripcion.pas' {FReactivar},
  FInfo_Proveedor in 'FInfo_Proveedor.pas' {FInfoProveedor},
  FEntregaRuta in 'FEntregaRuta.pas' {FEntregadeRuta};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFlogin, Flogin);
  Application.CreateForm(TFPrincipalCirculacion, FPrincipalCirculacion);
  Application.CreateForm(TFAcercade, FAcercade);
  Application.CreateForm(TFCEdificios, FCEdificios);
  Application.CreateForm(TFC_rutas_metropolitanas, FC_rutas_metropolitanas);
  Application.CreateForm(TFC_Rutas_foraneas, FC_Rutas_foraneas);
  Application.CreateForm(TFC_Catalogo_repartidores_choferes, FC_Catalogo_repartidores_choferes);
  Application.CreateForm(TFC_Catalogo_proveedores_y_vendedores, FC_Catalogo_proveedores_y_vendedores);
  Application.CreateForm(TFBuscar_proveedor, FBuscar_proveedor);
  Application.CreateForm(TFCTipo_Circulacion, FCTipo_Circulacion);
  Application.CreateForm(TFR_Proveedoresdotacion, FR_Proveedoresdotacion);
  Application.CreateForm(TFAdmon_rutas, FAdmon_rutas);
  Application.CreateForm(TFRemision, FRemision);
  Application.CreateForm(TFR_Imprime_remision, FR_Imprime_remision);
  Application.CreateForm(TFCMunicipiosconentrega, FCMunicipiosconentrega);
  Application.CreateForm(TFAltaQueja, FAltaQueja);
  Application.CreateForm(TFSeguimientoQ, FSeguimientoQ);
  Application.CreateForm(TFR_RepSegQueja, FR_RepSegQueja);
  Application.CreateForm(TFR_reportequejas, FR_reportequejas);
  Application.CreateForm(TFCapturaPagos, FCapturaPagos);
  Application.CreateForm(TFbuscarcodigo, Fbuscarcodigo);
  Application.CreateForm(TFdevoluciones, Fdevoluciones);
  Application.CreateForm(TFCapturaXdistribuidor, FCapturaXdistribuidor);
  Application.CreateForm(TFREstadoCuenta, FREstadoCuenta);
  Application.CreateForm(TFR_Edo_cuenta, FR_Edo_cuenta);
  Application.CreateForm(TFcorte, Fcorte);
  Application.CreateForm(TFR_HojaCorte, FR_HojaCorte);
  Application.CreateForm(TFRImprimePoliza, FRImprimePoliza);
  Application.CreateForm(TFPassword, FPassword);
  Application.CreateForm(TFCVendedoresZocalo, FCVendedoresZocalo);
  Application.CreateForm(TFCapturaZocalo, FCapturaZocalo);
  Application.CreateForm(TFCTotal_dotacion, FCTotal_dotacion);
  Application.CreateForm(TFcortezocalo, Fcortezocalo);
  Application.CreateForm(TFhoja_modif_ruta, Fhoja_modif_ruta);
  Application.CreateForm(TFbuscarCP, FbuscarCP);
  Application.CreateForm(TFModificar_Subscripcion, FModificar_Subscripcion);
  Application.CreateForm(TFAlta_subscriptor, FAlta_subscriptor);
  Application.CreateForm(TFSubscripciones, FSubscripciones);
  Application.CreateForm(TFAreas_entrega_edificio, FAreas_entrega_edificio);
  Application.CreateForm(TFAsignarARutaMetro, FAsignarARutaMetro);
  Application.CreateForm(TFCancelaciones, FCancelaciones);
  Application.CreateForm(TFModif_subscriptor, FModif_subscriptor);
  Application.CreateForm(TFNueva_area_de_edifcio, FNueva_area_de_edifcio);
  Application.CreateForm(TFNueva_Subscripcion, FNueva_Subscripcion);
  Application.CreateForm(TFC_CP, FC_CP);
  Application.CreateForm(TFCambio_Factura, FCambio_Factura);
  Application.CreateForm(TFCambioSubscriptor, FCambioSubscriptor);
  Application.CreateForm(TFRAltaSubscripcion, FRAltaSubscripcion);
  Application.CreateForm(TFImpCodigo, FImpCodigo);
  Application.CreateForm(TFimprimirrutas, Fimprimirrutas);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFQuejasCerradas, FQuejasCerradas);
  Application.CreateForm(TFQuejasSubscripciones, FQuejasSubscripciones);
  Application.CreateForm(TFQuejasR, FQuejasR);
  Application.CreateForm(TFHistorialQueja, FHistorialQueja);
  Application.CreateForm(TFCanceladasR, FCanceladasR);
  Application.CreateForm(TFNuevosR, FNuevosR);
  Application.CreateForm(TFAdmonCodigos, FAdmonCodigos);
  Application.CreateForm(TFEstadisticasRutas, FEstadisticasRutas);
  Application.CreateForm(TFSuspenderEntrega, FSuspenderEntrega);
  Application.CreateForm(TFIncidencias, FIncidencias);
  Application.CreateForm(TFOrdenEntrega, FOrdenEntrega);
  Application.CreateForm(TFSeguimientoA, FSeguimientoA);
  Application.CreateForm(TFCancelados, FCancelados);
  Application.CreateForm(TFNotas, FNotas);
  Application.CreateForm(TFver, Fver);
  Application.CreateForm(TFRNotificacionalta, FRNotificacionalta);
  Application.CreateForm(TFBuscarSupervisor, FBuscarSupervisor);
  Application.CreateForm(TFRHojadeRuta, FRHojadeRuta);
  Application.CreateForm(TFRlistaedificio, FRlistaedificio);
  Application.CreateForm(TFRListaCancelados, FRListaCancelados);
  Application.CreateForm(TFAsignarCEdificio, FAsignarCEdificio);
  Application.CreateForm(TFNuevoCodigo, FNuevoCodigo);
  Application.CreateForm(TFAgruparCodigos, FAgruparCodigos);
  Application.CreateForm(TFSeguimientoCambios, FSeguimientoCambios);
  Application.CreateForm(TFIncidenciasDescripcion, FIncidenciasDescripcion);
  Application.CreateForm(TFIncidenciaGlobal, FIncidenciaGlobal);
  Application.CreateForm(TFGrupos_codigos, FGrupos_codigos);
  Application.CreateForm(TFListaCorreos, FListaCorreos);
  Application.CreateForm(TFChoferDot, FChoferDot);
  Application.CreateForm(TFRemisionRutas, FRemisionRutas);
  Application.CreateForm(TFHistorialEntrega, FHistorialEntrega);
  Application.CreateForm(TFCod_vendedores, FCod_vendedores);
  Application.CreateForm(TFEntregaRutaVentas, FEntregaRutaVentas);
  Application.CreateForm(TFactivarEntrega, FactivarEntrega);
  Application.CreateForm(TFestadisticasVEntas, FestadisticasVEntas);
  Application.CreateForm(TFOrdenEntregaVentas, FOrdenEntregaVentas);
  Application.CreateForm(TFDescripcionIncidente, FDescripcionIncidente);
  Application.CreateForm(TFcomentariosQuejas, FcomentariosQuejas);
  Application.CreateForm(TFCierreConActa, FCierreConActa);
  Application.CreateForm(TFReactivar, FReactivar);
  Application.CreateForm(TFInfoProveedor, FInfoProveedor);
  Application.CreateForm(TFEntregadeRuta, FEntregadeRuta);
  Application.Run;
end.
