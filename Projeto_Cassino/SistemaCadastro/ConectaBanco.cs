using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data;

namespace SistemaCadastro
{
    internal class Cassino_2

    {
        MySqlConnection conexao = new MySqlConnection("server=localhost;user id=root;database=cassino_2");
        public String mensagem;
        public DataTable listaJogo()
        {
            
            MySqlCommand cmd = new MySqlCommand("lista_jogo", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                conexao.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable tabela = new DataTable();
                da.Fill(tabela);
                return tabela;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return null;
            }
            finally
            {
                conexao.Close();
            }

        }

        public DataTable listaAposta()
        {
            MySqlCommand cmd = new MySqlCommand("lista_aposta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                conexao.Open();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable tabela = new DataTable();
                da.Fill(tabela);
                return tabela;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return null;
            }
            finally
            {
                conexao.Close();
            }

        }



        public bool insereAposta(Aposta a)
        {
            MySqlCommand cmd = new MySqlCommand("proc_addAposta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("nvalor", a.Valor);
            cmd.Parameters.AddWithValue("jogo", a.Jogos_codJogo);
            cmd.Parameters.AddWithValue("formpag", a.FormaPagamento);
            cmd.Parameters.AddWithValue("cliente", a.NomeCliente);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }
        public bool insereJogo(String jogo)
        {
            MySqlCommand cmd = new MySqlCommand("proc_addJogos", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("novoJogo", jogo);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }
        public bool deletaAposta(int idaposta)
        {
            MySqlCommand cmd = new MySqlCommand("proc_deleteAposta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("codDelete", idaposta);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }

        public bool alteraAposta(Aposta a, int idaposta)
        {
            MySqlCommand cmd = new MySqlCommand("proc_alteraAposta", conexao);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("cod", idaposta);
            cmd.Parameters.AddWithValue("nvalor", a.Valor);
            cmd.Parameters.AddWithValue("formpag", a.FormaPagamento);
            cmd.Parameters.AddWithValue("cliente", a.NomeCliente);
            cmd.Parameters.AddWithValue("jogo", a.Jogos_codJogo);
            try
            {
                conexao.Open();
                cmd.ExecuteNonQuery(); 
                return true;
            }
            catch (MySqlException e)
            {
                mensagem = "Erro:" + e.Message;
                return false;
            }
            finally
            {
                conexao.Close();
            }
        }


    }
}
