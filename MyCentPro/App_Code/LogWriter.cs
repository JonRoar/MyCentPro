using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using MyCentPro;

/// <summary>
/// Summary description for Log
/// </summary>
public class LogWriter
{

    SqlConnection con;

    /// <summary>
    /// Private constructor to prevent instance creation
    /// </summary>
    public LogWriter()
    {

    }

    public SqlConnection OpenDBConnection()
    {
        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["CentProSQL"].ConnectionString);
            return con;
        }
        catch (SqlException)
        {
            return null;
        }
        finally
        {
            con.Close();
        }
    }

    /// <summary>
    /// The single instance method that writes to the log file
    /// </summary>
    /// <param name="user">The UserInfo object of the user to attach the entry to</param>
    /// <param name="message">The message to write to the log</param>
    public Exception WriteToLog(UserInfo user, string message)
    {
        
        try
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = OpenDBConnection();

            //define query
            cmd.CommandText = "INSERT INTO Log (uID, Timestamp, logEntry) VALUES((SELECT u.uID FROM Users u WHERE u.aspID = '" + user.AspID + "'), GETDATE(), '" + message + "')";
            cmd.Connection = con;
            //execute
            con.Open();
            cmd.ExecuteNonQuery();
            //close and cleanup
            con.Close();

            //make an empty Exception if everything was OK.
            Exception ex = null;
            return ex;
        }
        catch (Exception ex)
        {
            //something failed - return the Exception to the caller.
            return ex;
        }        
        finally
        {
            //cleanup, even if things failed.
            con.Close();
        }
    }
}