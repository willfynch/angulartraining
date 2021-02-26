#  A Dockerfile must begin with a FROM instruction. 
FROM node

WORKDIR /app

# everything happens in /app
COPY /my-app ./

# initialize project with dependencies
COPY /my-app/package.json /app

# copy also json-lock to prevent conflicts with newer versions
COPY /my-app/package-lock.json /app


RUN npm install -g npm@7.5.6

# need angular cli to have angular cli in the future container
RUN npm install -g @angular/cli 

# npm install to install dependencies 
#if there is a package.json, npm install is based on this file (by convention)
RUN npm install 

#expose port to show app in browser
EXPOSE 4200

# tell container to add in container path all modules installed with npm
ENV PATH /app/node_modules/.bin:$PATH

# The main purpose of a CMD is to provide defaults for an executing container

#launch project 
CMD ng serve --host 0.0.0.0

# two possibilities 
# 1 : docker build
# 2 : use docker compose : define services 
