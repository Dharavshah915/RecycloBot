#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import cv2

from dotenv import load_dotenv
from openai import OpenAI
import os
import base64

import serial
import time



#initialize for cv
camera = cv2.VideoCapture(0)  # 0 is the default camera (your Mac's built-in webcam)

if not camera.isOpened():
    print("Error: Could not open camera.")
    exit()

# Set resolution (optional)
camera.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)  # Set width
camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)  # Set height



#initialize for gpt

load_dotenv()
openai.api_key = "Your-key"
# Your Prompt
prompt = "Can you take a look at the object in the image and classify it as recycling, glass, garbage or organics. Answer with only the catagory. Cans, juice boxes, chip bags, paper and plastic should be in recycling. glass bottles, should be in glass. banana peels or any food should be in organics. Masks, wipes, gloves, or anything that does not fit in the other 3 catagories should be in the grabage." 
client = OpenAI(api_key="Your-key")

# Image file path
image_path = "/Users/dharavshah/Desktop/DeltaHacks/cv_ss.jpeg"

# Function to encode the image
def encode_image(image_path):
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode("utf-8")

    
    
#initialize for arduino   
dict = {
    "Recycling": "1",
    "Glass": "2",
    "Garbage": "3",
    "Organics": "4"
}

arduino_port = '/dev/cu.usbmodem1301' #edit port as needed
baud_rate = 9600  # Match the baud rate in your Arduino code
ser = serial.Serial(arduino_port, baud_rate, timeout=1)
time.sleep(2)  # Wait for the Arduino to initialize
    



while True:
    ret, frame = camera.read()
    if not ret:
        print("Error: Failed to capture image.")
        break

    # Display the live video feed
    cv2.imshow("Camera", frame)

    # Wait for a key press 
    key = cv2.waitKey(0) & 0xFF

    if key == ord('s'):
        cv2.imwrite(image_path, frame)  # Save the frame as an image
        print(f"Image saved to {image_path}")
        
    # Encode the image
    base64_image = encode_image(image_path)

    # Create chat completion
    try:
        chat_completion = client.chat.completions.create(
            model="gpt-4-turbo",
            max_tokens=300,
            messages=[
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": prompt
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{base64_image}"
                            }
                        }
                    ]
                }
            ]
        )
        x = chat_completion.choices[0].message.content
        print(x)
    except Exception as e:
        print(f"An error occured: {e}")

    ser.write(f"{dict[x]}\n".encode())  # Send input to Arduino
    print(f"Sent: {x}")
    
camera.release()
cv2.destroyAllWindows()
    
    
