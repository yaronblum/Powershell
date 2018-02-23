

$SQLServer      = "jdbc:postgresql://production-seg-db.ccoxtlumqj1k.us-west-2.redshift.amazonaws.com:5439/userprofile"
$SQLDBName      = "engage_demo_3"
      $uid      = "seg_user"
      $pwd      = "sU123456"
      $MyPort   = "5439"
      $SqlQuery = "SELECT * FROM $SQLDBName.user_profiles LIMIT 1;"

$DBConnectionString = " Driver={PostgreSQL UNICOD(x64)};
                        Server=$SQLServer; 
                        Port=$MyPort; 
                        Database=$SQLDBName; 
                        Uid=$uid; 
                        Pwd=$pwd; 
                        Integrated Security = False;"

                 $DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $DBConnectionString;
$DBConn.Open();

                    $DBCmd = $DBConn.CreateCommand();
        $DBCmd.CommandText = $SqlQuery;
        $DBCmd.ExecuteReader();
        $DBConn.Close();