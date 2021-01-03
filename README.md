# Q-Response

HackVerse hackathon NIT-K Surathkal. A software to alert traffic police in case of potential accidents.

1. Flutter Mobile Application: UI for the user side. Measures overspeeding.
2. React Website: UI for the traffic police. Uses Google Maps API.
3. DarkNet Object Detection: Model to detect accidents.

### Setup

1. Create a Firebase project and update `App.js` file in `Traffic Cop Website` folder.
2. Run the following commands
```
flutter pub get

python3 -m venv venv
cd darknet
make
wget https://pjreddie.com/media/files/yolov3.weights
Run darknet detector

cd Traffic\ Cop\ Website
npm install
npm start
```
