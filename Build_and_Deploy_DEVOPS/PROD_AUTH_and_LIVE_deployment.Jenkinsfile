pipeline {
	agent any
	options{timestamps()}
	stages {
		stage('Build') {
			steps {
                 parallel(
        	        buildtsapp : {build job: "Build - TS-App/${BRANCH_NAME}"} ,
                    buildtsweb : {build job: "Build - TS-Web/${BRANCH_NAME}"} ,
                    buildsearchapp : { build job: "Build - Search-App/${BRANCH_NAME}"}
                 )
				}
			}
		
		stage('AUTH WCBDataload'){ 
			steps {
				echo 'WCBDataload AUTH started'
				build job: "Run_WCBDataLoad" , parameters: [string(name: 'Env_name', value: "prod"), string(name: 'Env_type', value: "auth"),string(name: 'branchName', value: "${BRANCH_NAME}")] 
				echo 'WCBDataload AUTH completed'
				}
			}
		
		stage('AUTH deploy'){
			steps {
				echo 'AUTH Tag and deployment is in progress'
				build job: "Tag_and_Deployment" , parameters: [string(name: 'Env_name', value: "prod"), string(name: 'Env_type', value: "auth"), string(name: 'BranchName', value: "${BRANCH_NAME}")]
				echo 'AUTH Tag and deployment completed'
				sleep(time:5,unit:"MINUTES")
				}
			}


		stage('AUTH Cache Clear'){
			steps{
				build job: "Clear-Cache" , parameters: [string(name: 'ENVIRONMENT', value: "prod"), string(name: 'ENVTYPE', value: "auth"), string(name: 'CLEAR_ALL', value: "true"), string(name: 'CACHE_APP_DOMAIN', value: "cache-hp2b-prodauth.corp.hpicloud.net")]
				echo 'AUTH cache clear completed'
				}
			}

		
		stage('LIVE WCBDataload'){ 
			steps {
				echo 'WCBDataload LIVE started'
				build job: "Run_WCBDataLoad" , parameters: [string(name: 'Env_name', value: "prod"), string(name: 'Env_type', value: "live"),string(name: 'branchName', value: "${BRANCH_NAME}")] 
				echo 'WCBDataload LIVE completed'
				}
			}


		stage('LIVE deploy'){
			steps {
				echo 'LIVE Tag and deployment is in progress'
				build job: "Tag_and_Deployment" , parameters: [string(name: 'Env_name', value: "prod"), string(name: 'Env_type', value: "live"), string(name: 'BranchName', value: "${BRANCH_NAME}")]
				echo 'AUTH Tag and deployment completed'
				sleep(time:5,unit:"MINUTES")
				}
			}


		stage('LIVE Cache Clear'){
			steps{
				build job: "Clear-Cache" , parameters: [string(name: 'ENVIRONMENT', value: "prod"), string(name: 'ENVTYPE', value: "live"), string(name: 'CLEAR_ALL', value: "true"), string(name: 'CACHE_APP_DOMAIN', value: "cache-hp2b-prodlive.hpcloud.hp.com")]
				echo 'LIVE cache clear completed'
				}
			}
			
		}	
		post{
		    success{
		        emailext body: '''
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><meta http-equiv=Content-Type content="text/html; charset=utf-8"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MV Boli";
	panose-1:2 0 5 0 3 2 0 9 0 0;}
@font-face
	{font-family:Stencil;
	panose-1:4 4 9 5 13 8 2 2 4 4;}
@font-face
	{font-family:"HP Simplified";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle25
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle26
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle27
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle28
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle29
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle30
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle31
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle32
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle33
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle34
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle35
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle36
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 style='border-collapse:collapse'><tr><td width=36 valign=top style='width:26.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal>&nbsp;<o:p></o:p></p></td><td width=588 valign=top style='width:440.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>Hello All, </span><o:p></o:p></p><p class=MsoNormal><b><span style='font-family:Stencil;color:#7030A0'></span></b><b><span style='font-size:20.0pt;font-family:Stencil;color:#00B050'></span></b><b><span style='font-family:Stencil;color:#7030A0'></span></b><span style='color:#7030A0'> $PROJECT_NAME job has completed successfully.</span><span style='font-family:"HP Simplified";color:#002060'><o:p></o:p></span></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>&nbsp;<o:p></o:p></span></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'></span><o:p></o:p></p></td></tr><tr><td width=36 valign=top style='width:26.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal>&nbsp;<o:p></o:p></p></td><td width=588 valign=top style='width:440.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal><span style='font-family:"HP Simplified";color:black'>&nbsp;</span><o:p></o:p></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>Thank you!<o:p></o:p></span></p><p class=MsoNormal><b><i><span style='font-family:"HP Simplified";color:#0096D6'>Your Jukebox DevOps Team</span></i></b><o:p></o:p></p><p class=MsoNormal><a href="mailto:hp2b.poc.stream@hp.com"><span style='font-family:"HP Simplified"'>hp2b.poc.stream@hp.com</span></a><o:p></o:p></p></td></tr></table><p class=MsoNormal>&nbsp;<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>''', postsendScript: '$DEFAULT_POSTSEND_SCRIPT', presendScript: '$DEFAULT_PRESEND_SCRIPT', subject: '$PROJECT_NAME - $BUILD_TIMESTAMP - Build # $BUILD_NUMBER - $BUILD_STATUS' , to: 'hp2blrdev@hp.com,HP2B_Notifications@external.groups.hp.com,hp2b_dev_it@hp.com'
		    }
		    failure{
		        emailext body: '''
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><meta http-equiv=Content-Type content="text/html; charset=utf-8"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MV Boli";
	panose-1:2 0 5 0 3 2 0 9 0 0;}
@font-face
	{font-family:Stencil;
	panose-1:4 4 9 5 13 8 2 2 4 4;}
@font-face
	{font-family:"HP Simplified";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle25
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle26
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle27
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle28
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle29
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle30
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle31
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle32
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle33
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle34
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle35
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle36
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 style='border-collapse:collapse'><tr><td width=36 valign=top style='width:26.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal>&nbsp;<o:p></o:p></p></td><td width=588 valign=top style='width:440.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>Hello All, </span><o:p></o:p></p><p class=MsoNormal><b><span style='font-family:Stencil;color:#7030A0'></span></b><b><span style='font-size:20.0pt;font-family:Stencil;color:#00B050'></span></b><b><span style='font-family:Stencil;color:#7030A0'></span></b><span style='color:#7030A0'> $PROJECT_NAME job has failed. Kindly check on it.</span><span style='font-family:"HP Simplified";color:#002060'><o:p></o:p></span></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>&nbsp;<o:p></o:p></span></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'></span><o:p></o:p></p></td></tr><tr><td width=36 valign=top style='width:26.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal>&nbsp;<o:p></o:p></p></td><td width=588 valign=top style='width:440.75pt;padding:0in 5.4pt 0in 5.4pt'><p class=MsoNormal><span style='font-family:"HP Simplified";color:black'>&nbsp;</span><o:p></o:p></p><p class=MsoNormal><span style='font-family:"HP Simplified";color:#002060'>Thank you!<o:p></o:p></span></p><p class=MsoNormal><b><i><span style='font-family:"HP Simplified";color:#0096D6'>Your Jukebox DevOps Team</span></i></b><o:p></o:p></p><p class=MsoNormal><a href="mailto:hp2b.poc.stream@hp.com"><span style='font-family:"HP Simplified"'>hp2b.poc.stream@hp.com</span></a><o:p></o:p></p></td></tr></table><p class=MsoNormal>&nbsp;<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>''', postsendScript: '$DEFAULT_POSTSEND_SCRIPT', presendScript: '$DEFAULT_PRESEND_SCRIPT', subject: '$PROJECT_NAME - $BUILD_TIMESTAMP - Build # $BUILD_NUMBER - $BUILD_STATUS' , to: 'HP2B_Notifications@external.groups.hp.com,hp2b_dev_it@hp.com'
		    }
			always{
				cleanWs()
			}
		}
}
