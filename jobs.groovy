job("Devops_Task6_JOB1_GITHUB")
{
	description("In this Job I clone repo from GitHub")
	scm {
		github("sourabhskc/Devops-Task6","master")
	}
	triggers {
		scm("* * * * *")
	}
	steps{
		shell("""
		sudo mkdir -p /Base_OS/Devops_Task6
    sudo cp -v * /Base_OS/Devops_Task6
		sudo rm -f *
		""")
	}
}

job("Devops_Task6_JOB2_Launching_WebServer")
{
	description("In this Job I Launch WebServer")
	triggers {
		upstream("Devops_Task6_JOB1_GITHUB","SUCCESS")
	}
	steps {
		shell("sh /Base_OS/Devops_Task6/job2.sh")
	}
}

job("Devops_Task6_JOB3_Testing_and_Mailing")
{
	description("In this Job I do testing of my webpage and if there is any mistake then send mail to developer")
	triggers {
		upstream("Devops_Task6_JOB2_Launching_WebServer","SUCCESS")
	}
	steps{
		shell("sh /Base_OS/Devops_Task6/job3.sh")
	}
	publishers {
        mailer('sourabhskc30@gmail.com', false, false)
    }
}

buildPipelineView('Devops_Task6') {
    filterBuildQueue()
    filterExecutors()
    title('Devops_Task6_Build_PIPELINE')
    displayedBuilds(3)
    selectedJob("Devops_Task6_JOB1_GITHUB")
    alwaysAllowManualTrigger()
    showPipelineParameters()
    refreshFrequency(60)
}
