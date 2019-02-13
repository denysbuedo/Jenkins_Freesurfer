/*
@Autor: Denys Buedo Hidalgo
@Proyecto: Jenkins_Freesurfer
@Joint China-Cuba Laboratory
@Universidad de las Ciencias InformÃ¡ticas
*/

node{

    //--- Getting the upstream build number
    echo "Reading the build parent number"
    def manualTrigger = true
  	def upstreamBuilds = ""
  	currentBuild.upstreamBuilds?.each {b ->
    	upstreamBuilds = "${b.getDisplayName()}"
    	manualTrigger = false
  	}
  	def xml_name = "$upstreamBuilds" + ".xml"
	
	//--- Reading current job config ---
	echo "Reading the job config"
  	def job_config = readFile "$JENKINS_HOME/jobs/recon-all/builds/QueueJobs/$xml_name"
	def parser = new XmlParser().parseText(job_config)
	def job_name = "${parser.attribute("job")}"
	def build_ID ="${parser.attribute("build")}"
	def owner_name ="${parser.attribute("name")}"
	def subject_name="${parser.attribute("subject")}"
	def output_folder="${parser.attribute("output")}"
	 
	//Setting Build description
	currentBuild.displayName = "BUILD# $build_ID-$owner_name"  
	
	stage('DATA ACQUISITION'){
		
		//Copy de Subject file to SUBJECT_DIR in Freesuerfer Server
		echo "Connecting to freesurfer server to copy subject file"
		sshagent(['JenkinsToFreesurfer_rsa']) {      
			//Create de subject file
			echo "$JENKINS_HOME/jobs/$JOB_NAME/builds/$build_ID/fileParameters/$subject_name"
			//def subject = new File ("$JENKINS_HOME/jobs/$JOB_NAME/builds/$build_ID/fileParameters/$subject_name")
			
			echo "Copy de Subject file to SUBJECT_DIR in Freesuerfer Server" 
			//sh "scp $subject root@192.168.17.132:/usr/local/freesurfer/subjects/"
			
			//echo "Remove task and subject file"
			//sh "rm -f $JENKINS_HOME/workspace/$JOB_NAME/$SUBJECT"
			//sh "rm -f $JENKINS_HOME/workspace/$JOB_NAME/Task.xml"
        } 
	}

	stage('DATA PROCESSING'){
		echo "DATA PROCESSING"
	}
	
	stage('DATA STORAGED'){
		echo "DATA STORAGED"
	}
	
	stage('NOTIFICATION'){
		echo "NOTIFICATION"
	}

}
