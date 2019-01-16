
Setup for development
====================================

- Install Node.js & NPM (https://nodejs.org)
- Run "npm install" in the webform directory to install all dependencies, including Webpack


Build for development
====================================

- Run "npm run build-dev" to build the project (to "/dist") and start the webpack development webserver pointing to that directory
- Open "http://localhost:8085/index.html" in your browser to view the webform just built


Build for deployment to test (webq2test)
====================================

- Review the project settings for development in the WebQ manifest file in "manifest.config.js"
- Run "npm run build-test" to: build the project (to "/dist"), generate a WebQ manifest file, and a zip-file that should be imported in WebQ.
- Import the created zip-file ("/dist/webq-deploy.zip") in WebQ2test.eionet.europa.eu to deploy the build


Build for deployment to production (webforms)
====================================

- Review the project settings for production in the WebQ manifest file in "manifest.config.js"
- Run "npm run build-prod" to: build the project (to "/dist"), generate a WebQ manifest file, and a zip-file that should be imported in WebQ.
- Import the created zip-file ("/dist/webq-deploy.zip") in webforms.eionet.europa.eu to deploy the build









