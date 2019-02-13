node {
  def manualTrigger = true
  def upstreamBuilds = ""
  currentBuild.upstreamBuilds?.each {b ->
     		"$upstreamBuilds = ${b.getDisplayName()}"
            "$manualTrigger = false"
  }
  echo "$upstreamBuilds"
}
