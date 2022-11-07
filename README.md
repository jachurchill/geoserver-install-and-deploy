# geoserver-install-and-deploy

This repository is to host a Dockerfile that builds a Docker image to install geoserver. This repository is attached to a CI/CD build with Google Cloud, this live instance can be accessed at https://geoserver-cicd-test-kdeha2pasa-uc.a.run.app/geoserver

## Usage

To build a docker image checkout the repo and in the root directory run:

```bash
docker build -t geoserver-install .
```
Note: geoserver-install can be replaced with a preferred name for the image

## Reasoning

For this assignment I chose to implement this installation as a Docker image deployed to Google Cloud.
- Docker was chosen because it is the containerization option I am most familiar with
- The image was built with Apline Linux because it's more lightweight than Ubuntu and there was no benefit for this project to going with Ubuntu
- Tomcat was chosen as the webserver because it is the standard for GeoServer production builds
- Java 11 was chosen over Java 8 because while the latest GeoServer supports both, this installation does not have any dependencies that require the older version
- Google Cloud was selected as the cloud platform to deploy to with CI/CD because it is an easy to work with platform with a free tier suitable to the needs of this assignment
