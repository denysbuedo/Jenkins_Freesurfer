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
  	
	
	//--- Reading current job config ---
	echo "Reading the job config"
  def job = readFile "$JENKINS_HOME/jobs/recon-all/builds/QueueJobs/$upstreamBuilds.xml"
	def parser = new XmlParser().parseText(job)
	def job = "${parser.attribute("job")}"
	def build ="${parser.attribute("build")}"
	def name ="${parser.attribute("name")}"
	def subject="${parser.attribute("subject")}"
	def output="${parser.attribute("output")}"
	 
	 //Setting Build description
	 currentBuild.displayName = "BUILD# $BUILD_ID- $OWNER"  
	
	stage('DATA ACQUISITION'){
		echo "DATA ACQUISITION" 
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
