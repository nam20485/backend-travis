#! /bin/bash

# Tag, Push and Deploy only if it's not a pull request
if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]; then

    # Push only if we're testing the staging branch
    #if [ "$TRAVIS_BRANCH" == "staging" ]; then

        export PATH=$PATH:$HOME/.local/bin

        echo Getting the ECR login...
        eval $(aws ecr get-login --region $AWS_DEFAULT_REGION)
        
        echo Running docker push command...
        docker push "$DOCKER_REPO"/"$DEPLOY_TARGET"/"$DOCKER_IMAGE":latest
        
        #echo Running ecs-deploy.sh script...
        #bin/ecs-deploy.sh  \
        #    -n "$ECS_SERVICE_NAME" \
        #    -c "$ECS_CLUSTER"   \
        #    -i "$DOCKER_REPO"/"$DEPLOY_TARGET"/"$DOCKER_IMAGE":latest \
        #    --timeout 300
    #else
    #    echo "Skipping deploy because branch is not staging"
    #fi
else
    echo "Skipping deploy because it's a pull request"
fi