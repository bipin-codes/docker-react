# start with node:16-alpine base image
# builder is the name given to this step
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .

RUN npm install
COPY . .

RUN npm run build

#second build phase
FROM nginx
# FOR EBS
EXPOSE 80
# COPY FROM DIFFERENT PHASE'S some folder into
COPY --from=builder /app/build /usr/share/nginx/html
