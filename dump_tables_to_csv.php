<?php
// usage: php dump_tables_to_csv.php localhost root password database
//
// For every table in the database, dump the table to a CSV file


function output_to_csv($fp, $table)
{
  // fetch the data
  $rows = mysql_query('SELECT * FROM ' . $table);
  $rows || die(mysql_error());

  // output the column headings
  $fields = array();
  for($i = 0; $i < mysql_num_fields($rows); $i++) {
      $field_info = mysql_fetch_field($rows, $i);
      $fields[] = $field_info->name;
  }
  fputcsv($fp, $fields, ';', '"');

  // loop over the rows, outputting them
  while ($row = mysql_fetch_assoc($rows)) fputcsv($fp, $row, ';', '"');
}

$server = $argv[1];
$user = $argv[2];
$password = $argv[3];
$db = $argv[4];

mysql_connect($server, $user, $password) or die(mysql_error());
mysql_select_db($db) or die(mysql_error());

// fetch the tables from the database
$rows = mysql_query('SHOW TABLES FROM ' . $db);
$rows || die(mysql_error());

$timestamp=date('Y-m-d_his');
$dir = "./$timestamp/";

if (! mkdir($dir, 0700, true) )
{
    die("Failed to create dir [$dir] ...");
}

$table_column = 'Tables_in_'.$db;

// foreach table create a CSV
while ($row = mysql_fetch_assoc($rows)) 
{
  $filename = "$dir/" . $row[$table_column] . ".csv";
  if (($output = fopen($filename, "w")) !== FALSE)
  {
    output_to_csv($output, $row[$table_column]);
    fclose($output);
  }
}

?>
