FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
RUN cat /etc/os-release
#RUN echo "deb [arch=amd64] http://mirrors.aliyun.com/ubuntu/ bionic main" > /etc/apt/sources.list
COPY ./sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk

# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN npm config set registry https://registry.npm.taobao.org

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

CMD [ "npm", "start" ]
