# -*- coding: utf-8 -*-

import xmlrpclib, os, sys, getopt, datetime, urllib2, urllib
import ConfigParser

PAMS_OBLIGATION = 'http://rod.eionet.europa.eu/obligations/696'
PAMS_SCHEMA = 'http://dd.eionet.europa.eu/schemas/mmr-pams/MMR_PAMs.xsd'
PAMS_XSL = 'mmr-pams-sql.xsl'
ACCOUNTS_CONF = 'accounts.conf'

def usage():
    sys.stderr.write("""Usage: Obligation is not specified!\n""" % sys.argv[0])

def set_authentication(cdrserver, cdruser, cdrpass):
    auth_handler = urllib2.HTTPBasicAuthHandler()
    auth_handler.add_password("Zope", cdrserver, cdruser, cdrpass)
    opener = urllib2.build_opener(auth_handler)
    urllib2.install_opener(opener)

def downloadfile(fileurl, tmpfile):
    tempFd = open(tmpfile, 'wb')
    conn = urllib2.urlopen(urllib.quote(fileurl, '/:'))
    data = conn.read(8192)
    while data:
        tempFd.write(data)
        data = conn.read(8192)
    conn.close()
    tempFd.close()

if __name__ == '__main__':
    config = ConfigParser.SafeConfigParser()
    config.read(ACCOUNTS_CONF)

    cdrserver = config.get('cdr', 'server')
    cdruser = config.get('cdr', 'username')
    cdrpass = config.get('cdr', 'password')
    released = config.getboolean('cdr', 'released')
    obligation = config.get('cdr', 'obligation')
    testdata = 0

    try:
        opts, args = getopt.getopt(sys.argv[1:], "rdt", ["--released","--draft","--testdata" ])
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    for o, a in opts:
        if o in ("-r", "--released"):
            released = 1
        if o in ("-d", "--draft"):
            released = 0
        if o in ("-t", "--testdata"):
            testdata = 1

    if len(args) == 0:
        usage()
        sys.exit(2)
            
    obligation = args[0]

    #sys.stdout.write("""DELETE FROM db_info;
    #DELETE FROM data_report;
    #DELETE FROM data_table1;
    #""")

    if obligation == PAMS_OBLIGATION:
        tmpfilename = 'pams.xml'
   # elif obligation == ODS_OBLIGATION:
   #     tmpfilename = 'downloadtmp-ods.xml'
        
    sys.stdout.flush()

    server = xmlrpclib.ServerProxy(cdrserver)
	
    # Create auth handler
    set_authentication(cdrserver, cdruser, cdrpass)
    
    for envelope in server.xmlrpc_search_envelopes(obligation, released):
        reportingdate = envelope['released']
        envelopeurl = envelope['url']
        
        #if reportingdate[:4] not in ('2015'):
            #print >>sys.stderr, "-- ENVELOPE HAS WRONG YEAR -- %s " % reportingdate[:4]
        #    continue

        #ignore test accounts, unless not included through "t" argument
        if testdata == 1 and not('/pams30000/' in envelopeurl or '/ods30000/' in envelopeurl):
            continue
        if testdata == 0 and ('/pams30000/' in envelopeurl or '/ods30000/' in envelopeurl):
            continue

        print >>sys.stderr, "-- ++++++++++++++++++++++ Envelope %s ++++++++++++++++++++" % envelope['url']

        #check if feedback contains "Data delivery was not acceptable"
        # envelope/has_blocker_feedback did not work for some envelopes in BDR
        hasBlockerFeedback = False
        try:
            hasBlockerFeedback = xmlrpclib.ServerProxy(envelopeurl).has_blocker_feedback()
        except:
            print >>sys.stderr, "-- Failed to call has_blocker_feedback --"
            
        #feedbacks = xmlrpclib.ServerProxy(envelopeurl).feedback_objects_details()
        #for feedback in feedbacks['feedbacks']:
        #    if feedback['title'] == "Data delivery was not acceptable":
        #        hasBlockerFeedback = True
        #        continue
        if hasBlockerFeedback:
            print >>sys.stderr, "-- HAS BLOCKER FEEDBACK --"
            continue

        files = envelope['files']
        #ignore envelope if it contains more than 1 xml
        xmlCount = 0
        for f in files:
            if f[1] == "text/xml":
                xmlCount += 1;
                
        #if xmlCount > 1:
        #    print >>sys.stderr, "Envelope contains more than 1 XML file"
        #    continue
        
        for f in files:
            if f[2] == PAMS_SCHEMA:
                xsl = PAMS_XSL
            else:
                xsl = ''
            scriptargs = {
                            'cdruser': cdruser,
                            'cdrpass': cdrpass,
                            'fileurl': "%s/%s" % (envelope['url'], f[0]),
                            'countrycode': envelope['country_code'],
                            'envelopeurl': envelope['url'],
                            'isreleased': envelope['isreleased'],
                            'filename': f[0],
                            'uploadtime': f[4],
                            'accepttime': f[5],
                            'reportingtime': envelope['released'],
                            'xsl': xsl,
                            'tmpfile': 'tmp' + os.sep + envelope['country_code'] + '-' + tmpfilename
                        }

            if (f[2] == PAMS_SCHEMA and obligation == PAMS_OBLIGATION):
                fileurl = "%s/%s" % (envelope['url'], f[0])
                tmpfile = 'tmp' + os.sep + envelope['country_code'] + '-' + tmpfilename
                try:
                    downloadfile(fileurl, tmpfile)
                    #os.system("""wget -nv -O %(tmpfile)s --http-user=%(cdruser)s --http-passwd=%(cdrpass)s '%(fileurl)s'  --ca-certificate=rapidssl.crt """ % scriptargs )
                    os.system("""xsltproc --stringparam envelopeurl '%(envelopeurl)s' --stringparam filename '%(filename)s' --stringparam country '%(countrycode)s' --stringparam releasetime '%(reportingtime)s' --param isreleased '%(isreleased)s' %(xsl)s %(tmpfile)s """ % scriptargs )
                    #os.unlink(tmpfile)
                except Exception:
                    print >>sys.stderr, "Downloading / Converting this File failed: %s" % fileurl

    sys.stdout.write("""
    INSERT INTO db_info (last_modified) VALUES ('%s'); """ %  (datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
    sys.stdout.flush()
