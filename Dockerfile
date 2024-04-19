FROM node:20-alpine3.16 AS build
WORKDIR /app

# Dependencies
COPY ./package*.json ./
RUN npm ci

# Everything that shouldn't be copied has to be in .dockerignore
COPY . .

RUN npm run build

################################################################################

FROM node:20-alpine3.16 AS production
WORKDIR /app

# Install run time dependencies.
COPY --from=build /app/package*.json ./
RUN npm ci --omit=dev --ignore-scripts

# Migrate from build stage.
COPY --from=build /app/build ./

EXPOSE 3000
CMD ["node", "./index.js"]
