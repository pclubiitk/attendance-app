---
sidebar_position: 1
---


# Theory

## Abstract

This page presents a method to prevent spoofing of Face Recognition Systems in a scenario wherein expensive and specialized hardware can not be used and features like depth analysis, retina scanning etc can not be used due to financial and technical restraints. Such a scenario is presented in our problem statement, which involves developing an attendance application for the police personnel. More on this in the next section.

The model combines Face Recognition and Gesture Detection with randomized gestures in order to ensure that pre-recorded videos and pre-captured images can’t be used for the purposes of getting past the face recognition system. Face Recogntion and Gesture Detection will take place simultaneously in order to prevent any form of spoofing opportunities.

## Problem Statement
In various workplaces, the working conditions are not static due to which it is not practical to implement a centralized and specialized face recognition device. Moreover, certain job roles require the employee to report at certain locations for instance construction site inspection, police patrolling and other wide roles. In such a scenario, the only device the employee has is his/her mobile phone.

A major restriction in such scenarios is that most of the mobile phones are not equipped with advanced technologies like depth detection, retina scanning etc, and in some cases the restrictions in camera software leaves in a huge leeway for spoofing. Hence, there is an urgent need to create a system which caters to the problem of mobility and at the same time keeps in mind the restrictions presented by mobie phones.

Such a system can have an application in multiple workspaces and solve the issue of corruption and absence from critical positions. An instance could be Police Patrolling at remote places. Police officers are assigned duties to patrol different areas, which might be far away from the police station. There is no way to track whether the assigned officer actually reached the location or not. A simple solution to this is GPS tracking, but only GPS tracking can be spoofed via simple mechanisms like sending your phone to the assigned location via a co-worker. Moreover, adding only face recognition to the GPS tracking can also be cheated by using picture of the concerned individual. In standard scenarios, this is overcome via using retina scan, depth detection and other sophisticated technologies, but these require specialzied hardwares which one can’t expect in each and every mobile phone. In the next two sections, the workflow and architecture of the said model shall be presented.

## Model Pipeline
- **STEP 1:** Vanilla Face Recognition: Standard Face Recognition using Computer Vision algorithms is implemented for the first layer of verification. If the user fails this layer, he shall not be able to proceed to the lext step.
- **STEP 2:** Randomized Gesture Detection: This step will involve giving the user a randomized gesture from a repository of a huge number of gestures. These might involve specific hand signs like those used in sign language, other hand signs or specific hand movements. This is done by recognizing and tracking specific hand landmarks, followed by encoding each landmark into a vector which then can be fed into a classification model. Note, that along with gesture detection, there shall be a simultaneous face recongition in order to ensure that the gestures are performed by the said individual only. Verification shall happen only when these two conditions are satisfied. Note that Step 1 is still needed because it saves times in cases wherein the face does not matches the said person and time is not wasted in performing the specific gesture.

## Model Implementation
The backend is implemented using Python, along with in-built libraries like DLib and Mediapipe.

1. **Face Recognition:** *MMOD CNN* Face detector is implemeted for robust face detection. It is capable of face detection from varying viewing angles, lighting conditions, and occlusion. This ensures that the face detection is accurate even in different environments, lightings, and can detect faces
even if the camera quality is not professional.
2. **Prompt for Gesture:** Once the first layer of authentication is passed, a prompt is given to the user to perform a gesture. This prompt is randomly selected from a repository of a huge number and types of gestures in order to make it unpredictable.
3. **Image Preprocessing for Gesture Detection:** Image Preporcessing involves:
    - Detection of Hand
    - Resizing of Hand Image
    - **Landmark Detection:** This involves detection of prominent features which define a hand, for instance the joints and fingers.
    - **Landmark Encoding:** The landmarks are encoded into vectors in order to make them ready for classification model.
4. **Classification:** Random Forest model is used for classification of Landmark vectors into various gestures. The model is Hypertuned to provide maximum accuracy.
