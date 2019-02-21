/*
@Autor: Denys Buedo Hidalgo
@Proyecto: Jenkins_Freesurfer (https://github.com/denysbuedo/Jenkins_Freesurfer.git)
@Joint China-Cuba Laboratory
@Universidad de las Ciencias Informaticas
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
		
		//--- Starting ssh agent on Freesurfer server ---
		sshagent(['fsf_id_rsa']) {      
			
			//--- Creating de subject file ---
			def subject = new File ("$JENKINS_HOME/jobs/recon-all/builds/$build_ID/fileParameters/$subject_name")
			
			//--- Copying de Subject file to SUBJECT_DIR in Freesuerfer Server --- 
			sh 'ssh -o StrictHostKeyChecking=no root@192.168.17.129'
			sh "scp $subject root@192.168.17.129:/usr/local/freesurfer/subjects/"
			
			//--- Remove task and subject file ---
			sh "rm -f $JENKINS_HOME/jobs/recon-all/builds/$build_ID/fileParameters/$subject_name"
			//sh "rm -f $JENKINS_HOME/jobs/recon-all/builds/QueueJobs/$xml_name"
        } 
	}

	stage('DATA PROCESSING (Freesurfer)'){
		
		//--- Starting ssh agent on Freesurfer server ---
		sshagent(['fsf_id_rsa']) { 
		
			/*--- Goal: Execute the freesurfer command, package and copy the results in the FTP server and clean the workspace.  
			@file: jenkins.sh
        	@Parameter{
    			$1-action [run, delivery]
        		$2-Name of the person who run the task ($owner_name)
        		$3-Subject name file ($subject_name)
        		$4-Result output folder ($output_folder) 
			} ---*/           
       		echo "--- Run Freesuerfer command ---"
        	sh 'ssh -o StrictHostKeyChecking=no root@192.168.17.129'
        	sh "ssh root@192.168.17.129 /usr/local/freesurfer/subjects/jenkins.sh run $owner_name $subject_name $output_folder"	
		}
		
	}
	
	stage('DATA DELIVERY'){
        
        sshagent(['fsf_id_rsa']) { 
        	/*--- Goal: Execute the freesurfer command, package and copy the results in the FTP server and clean the workspace.  
			@file: jenkins.sh
        	@Parameter{
    			$1-action [run, delivery]
        		$2-Name of the person who run the task ($owner_name)
        		$3-Subject name file ($subject_name)
        		$4-Result output folder ($output_folder) 
			} ---*/ 
        	echo "--- Tar and copy files result to FTP Server ---"
        	sh 'ssh -o StrictHostKeyChecking=no root@192.168.17.129'
        	sh "ssh root@192.168.17.129 /usr/local/freesurfer/subjects/jenkins.sh delivery $owner_name $subject_name $output_folder"
        }
	}
	
	stage('NOTIFICATION AND REPORT'){
	
		//--- Inserting data in influxdb database ---/
		step([$class: 'InfluxDbPublisher', customData: null, customDataMap: null, customPrefix: null, target: 'influxdb'])
	}

}
