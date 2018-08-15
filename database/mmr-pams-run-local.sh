#!/bin/sh
labels_xml="mmr-pams-labels-en.xml"
labels_xsl="update-labels.xsl"
labels_script="mmr-update-labels-`date +%F`.sql"
sql_script="mmr-pams-extraction-`date +%F`.sql"
rm -f $labels_script
rm -f $sql_script

empty_db="MMR-PAMs-empty-db.accdb"
tmp_db="MMR-PAMs-temp-db`date +%F`.accdb"
database="mmr-pams-aggregation-db`date +%F`.accdb"
jdbcDriver="sqlbatch.jar"

rm -f $tmp_db
rm -f $database

trap "echo Exited!; exit;" SIGINT SIGTERM

echo Updating Labels
xsltproc -o $labels_script $labels_xsl $labels_xml

echo Creating temp database
cp $empty_db $tmp_db
java -jar $jdbcDriver $tmp_db $labels_script

obligation="http://rod.eionet.europa.eu/obligations/696"
echo Grabbing files 
python2 grabfiles-local.py $obligation -d >> $sql_script 2>debug.log

echo Store data in MS Access
cp $tmp_db $database
java -jar $jdbcDriver $database $sql_script

#eval `python readconfig.py location`
#mv "$tmp_db" "$ftpdirectory"
#chown "$ftpuser.$ftpgroup" "$ftpdirectory/$tmp_db"

#cleanup
#rm $labels_script
#rm $sql_script
#rm $tmp_db
#rm $database

# Send notification
#eval `python readconfig.py notification`
#mail -S "from=$from" -s "$subject" $recipients <debug.log
#rm debug.log
