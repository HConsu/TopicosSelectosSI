#!/usr/bin/perl
use DBI();
use DBD::mysql;
use File::Copy;
use Switch;
use Digest::MD5 qw(md5 md5_hex md5_base64);

# Variables para la conexion a la BD
($seg, $min, $hora, $dia, $mes, $anho, @zape) = localtime(time);
$mes++;
$anho+=1900;
$dd=$dia < 10 ? '0'.$dia : $dia;
$mm=$mes < 10 ? '0'.$mes :$mes;
$horaactual="$hora:$min:$seg";
$fecha_actual= "$dd/$mm/$anho";
print "$fecha_actual";

my $db_usr = "independiente";
my $db_pss = "blankenship";
my $db_htn = "localhost";
my $db_nme = "independiente";

my @digest;

my $q_stg="DBI:mysql:host=$db_htn;database=$db_nme";

my $dbh=(DBI->connect($q_stg,$db_usr,$db_pss,{PrintError => 0,RaiseError => 1}));

$query="Select edicion from t_remision_rutas where fecha='$fecha_actual' limit 1";
#print "$query";
$ejecuta=$dbh->prepare($query);
$ejecuta->execute();
$ejecuta->bind_columns(undef,\$edicion);
$ejecuta->fetchrow_array;
$edicion=$edicion+1;
$query="Select count(DISTINCT(ruta)) AS NoRutas from c_proveedores";
$ejecuta->execute();
$ejecuta->bind_columns(undef,\$norutas);
$ejecuta->fetchrow_array;
print "$norutas";




#$dbh->disconnect;

