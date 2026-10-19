# DevOps workflow of this project

1. **Linux** - the project is created in `~/devops/asan_abylai` with directories and a Bash script.
2. **Git** - every change is a commit; new work is done in the `development` branch.
3. **GitHub** - the repository `asan-abylai-devops` stores the code and is the source for Jenkins.
4. **Jenkins** - job `Asan_Abylai_DevOps` reads the `Jenkinsfile` from GitHub.
5. **Pipeline** - Checkout -> Build -> Test -> Docker Build -> Docker Run.
6. **Docker** - the image `asan-abylai-devops` is built and the container `asan-abylai-container` is started.

If any stage fails, the pipeline stops and the build is marked FAILURE.
