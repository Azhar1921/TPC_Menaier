﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ProductoVendidoNegocio
    {
        public List<ProductoVendido> Listar(int id)
        {
            ProductoVendido aux;
            List<ProductoVendido> lstProductosVendidos = new List<ProductoVendido>();
            AccesoDB conexion = null;

            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("SELECT PXV.IDPXV, PXV.IDPRODUCTO, PXV.CANTIDAD, P.DESCRIPCION, M.DESCRIPCION, TP.DESCRIPCION, P.STOCKMIN, P.IDMARCA, P.IDTIPOPRODUCTO FROM PRODUCTOS_X_VENTA AS PXV " +
                                        "INNER JOIN PRODUCTOS AS P ON PXV.IDPRODUCTO = P.IDPRODUCTO " +
                                        "INNER JOIN MARCAS AS M ON P.IDMARCA = M.IDMARCA " +
                                        "INNER JOIN TIPOSPRODUCTO AS TP ON P.IDTIPOPRODUCTO = TP.IDTIPOPRODUCTO " +
                                        "WHERE PXV.ACTIVO = 1 AND IDVENTA = @id");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@id", id);
                conexion.AbrirConexion();
                conexion.EjecutarConsulta();

                while (conexion.Lector.Read())
                {
                    aux = new ProductoVendido
                    {
                        IdPxv = (int)conexion.Lector[0],
                        Producto = new Producto(),
                        Cantidad = (int)conexion.Lector[2]
                    };
                    aux.Producto.Marca = new Marca();
                    aux.Producto.TipoProducto = new TipoProducto();
                    aux.Producto.IdProducto = (int)conexion.Lector[1];
                    aux.Producto.Descripcion = (string)conexion.Lector[3];
                    aux.Producto.Marca.Descripcion = (string)conexion.Lector[4];
                    aux.Producto.Marca.IdMarca = (int)conexion.Lector[7];
                    aux.Producto.StockMin = (int)conexion.Lector[6];
                    aux.Producto.TipoProducto.Descripcion = (string)conexion.Lector[5];
                    aux.Producto.TipoProducto.IdTipoProducto = (int)conexion.Lector[8];
                    aux.Precio = CalcularPrecio(aux);

                    lstProductosVendidos.Add(aux);
                }

                return lstProductosVendidos;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        public float CalcularPrecio(ProductoVendido pv)
        {
            float precio;
            Lote lote;
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("SELECT TOP 1 L.COSTOPU FROM LOTES AS L " +
                    "INNER JOIN COMPRAS AS C ON C.IDCOMPRA = L.IDCOMPRA " +
                    "WHERE L.IDPRODUCTO = @idproducto " +
                    "ORDER BY C.FECHACOMPRA ASC");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@idproducto", pv.Producto.IdProducto);

                conexion.AbrirConexion();
                conexion.EjecutarConsulta();

                lote = new Lote
                {
                    IdLote = (int)conexion.Lector[0],
                    CostoPU = (float)Convert.ToDouble(conexion.Lector[1]),
                    UnidadesE = (int)conexion.Lector[2]
                };
                precio = lote.CostoPU * pv.Cantidad;
                return precio;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        public bool DescontarStock(ProductoVendido pv)
        {
            bool stocked = false;
            Lote lote;
            int stockTotal = 0;
            List<Lote> lstLotes = new List<Lote>();
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("SELECT L.IDLOTE, L.UNIDADESE FROM LOTES AS L " +
                    "INNER JOIN COMPRAS AS C ON C.IDCOMPRA = L.IDCOMPRA " +
                    "WHERE L.IDPRODUCTO = @idproducto " +
                    "ORDER BY C.FECHACOMPRA DESC");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@idproducto", pv.Producto.IdProducto);

                conexion.AbrirConexion();
                conexion.EjecutarConsulta();

                while (conexion.Lector.Read())
                {
                    lote = new Lote
                    {
                        IdLote = (int)conexion.Lector[0],
                        UnidadesE = (int)conexion.Lector[1]
                    };
                    stockTotal += lote.UnidadesE;
                    lstLotes.Add(lote);
                }
                if( stockTotal >= pv.Cantidad )
                {
                    int cantV = pv.Cantidad, i = 0, cantR, cantL, aux;
                    while(cantV > 0)
                    {
                        cantL = lstLotes[i].UnidadesE;
                        aux = cantV;
                        cantV -= cantL;
                        cantR = aux - cantV;
                        lstLotes[i].UnidadesE = cantL - cantR;
                        ActualizarStock(lstLotes[i]);
                        i++;
                    }
                    stocked = true;
                }
                return stocked;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        private void ActualizarStock(Lote l)
        {
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("UPDATE LOTES SET UNIDADESE = @unidadese WHERE IDLOTE = @idlote");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@unidadese", l.UnidadesE);
                conexion.Comando.Parameters.AddWithValue("@idlote", l.IdLote);

                conexion.AbrirConexion();
                conexion.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        public void Agregar(ProductoVendido nuevo)
        {
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("INSERT INTO PRODUCTOS_X_VENTA(IDVENTA,IDPRODUCTO,CANTIDAD) VALUES (@idventa,@idproducto,@cantidad)");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@idcompra", nuevo.IdVenta);
                conexion.Comando.Parameters.AddWithValue("@idproducto", nuevo.Producto.IdProducto);
                conexion.Comando.Parameters.AddWithValue("@cantidad", nuevo.Cantidad);

                conexion.AbrirConexion();
                conexion.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        public void Modificar(ProductoVendido pv)
        {
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("UPDATE PRODUCTOS_X_VENTA SET IDPRODUCTO = @idproducto, CANTIDAD = @cantidad WHERE IDPXV = @id");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@idproducto", pv.Producto.IdProducto);
                conexion.Comando.Parameters.AddWithValue("@cantidad", pv.Cantidad);
                conexion.Comando.Parameters.AddWithValue("@id", pv.IdPxv);

                conexion.AbrirConexion();
                conexion.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }


        public void EliminarProductosDeVenta(int id)
        {
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("DELETE FROM PRODUCTOS_X_VENTA WHERE IDVENTA = @id");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@id", id);
                conexion.AbrirConexion();
                conexion.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }

        public void EliminarFisico(long id)
        {
            AccesoDB conexion = null;
            try
            {
                conexion = new AccesoDB();
                conexion.SetearConsulta("DELETE FROM PRODUCTOS_X_VENTA WHERE IDPXV = @id");
                conexion.Comando.Parameters.Clear();
                conexion.Comando.Parameters.AddWithValue("@id", id);
                conexion.AbrirConexion();
                conexion.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conexion.CheckearConexion() == true)
                {
                    conexion.CerrarConexion();
                }
            }
        }
    }
}
