"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[0],{4666:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>d,contentTitle:()=>a,default:()=>h,frontMatter:()=>o,metadata:()=>r,toc:()=>c});var i=n(4848),s=n(8453);const o={},a="Contribute",r={id:"ml/face_recognition/contribute",title:"Contribute",description:"NOTE: The `models` segment of the repository is highly underdeveloped from an implementation standpoint, and has to be worked upon. A step-by-step guide to do the same is present in the third section of the page.",source:"@site/docs/ml/face_recognition/contribute.md",sourceDirName:"ml/face_recognition",slug:"/ml/face_recognition/contribute",permalink:"/attendance-app/docs/ml/face_recognition/contribute",draft:!1,unlisted:!1,editUrl:"https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/docs/ml/face_recognition/contribute.md",tags:[],version:"current",frontMatter:{},sidebar:"mlSidebar",previous:{title:"Theory",permalink:"/attendance-app/docs/ml/face_recognition/intro"}},d={},c=[{value:"Repsitory Structure",id:"repsitory-structure",level:2},{value:"Current Repsitory Status",id:"current-repsitory-status",level:2},{value:"To-Do",id:"to-do",level:2},{value:"Short Term",id:"short-term",level:3},{value:"Long Term",id:"long-term",level:3}];function l(e){const t={code:"code",em:"em",h1:"h1",h2:"h2",h3:"h3",header:"header",input:"input",li:"li",p:"p",strong:"strong",ul:"ul",...(0,s.R)(),...e.components};return(0,i.jsxs)(i.Fragment,{children:[(0,i.jsx)(t.header,{children:(0,i.jsx)(t.h1,{id:"contribute",children:"Contribute"})}),"\n",(0,i.jsxs)(t.p,{children:[(0,i.jsx)(t.em,{children:(0,i.jsx)(t.strong,{children:"NOTE:"})})," The ",(0,i.jsx)(t.code,{children:"models"})," segment of the repository is highly underdeveloped from an implementation standpoint, and has to be worked upon. A step-by-step guide to do the same is present in the third section of the page."]}),"\n",(0,i.jsx)(t.h2,{id:"repsitory-structure",children:"Repsitory Structure"}),"\n",(0,i.jsx)(t.p,{children:"The contributor can navigate to the models directory of the main tree in order to find all files related to the Machine Learning Model."}),"\n",(0,i.jsxs)(t.ul,{children:["\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsxs)(t.p,{children:[(0,i.jsx)(t.code,{children:"models/TrainData_preprocess.py"})," contains the script to resize the training images, implement mediapipe detection on the image in order to detect hand landmarks, and hence draw the landmarks on the image. The data, that is the vectorized information of hand landmarks along with the labels, that is the alphabet the vector corresponds to, is saved in two separate lists, post which these two lists are dumped in a pickle file as a dictionary with the format ",(0,i.jsx)(t.code,{children:"{'data': data, 'labels': labels}"}),", wherein ",(0,i.jsx)(t.code,{children:"data"})," corresponds to the list of landmark vectors, and ",(0,i.jsx)(t.code,{children:"labels"})," corresponds to the list of alphabets, with the indexes synchronized.\xa0"]}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsxs)(t.p,{children:[(0,i.jsx)(t.code,{children:"models/RandomForest.py"})," \xa0trains the random forest model on the data processed in \xa0",(0,i.jsx)(t.code,{children:"models/TrainData_preprocess.py"}),", and saves the same in a pickle file named ",(0,i.jsx)(t.code,{children:"model.p"})]}),"\n"]}),"\n",(0,i.jsxs)(t.li,{children:["\n",(0,i.jsxs)(t.p,{children:[(0,i.jsx)(t.code,{children:"models/main.py"})," performs inference based on the model laid down in the previous two scripts. The input is taken in the form of a video feed from the webcam of the human (alternatively, non-human) running the script, and the prediction is displayed visually in a CV2 window."]}),"\n"]}),"\n"]}),"\n",(0,i.jsxs)(t.p,{children:[(0,i.jsx)(t.em,{children:(0,i.jsx)(t.strong,{children:"NOTE:"})})," Training data and ",(0,i.jsx)(t.code,{children:"model.p"})," are not present in the repository. Training data is the train split of Standard English ASL Alphabet Dataset (Save this in ",(0,i.jsx)(t.code,{children:"'./ASL_Alphabet_Dataset/asl_alphabet_train'"}),", or alternatively change the path for local testing purposes), while the model file must be generated by running\xa0 ",(0,i.jsx)(t.code,{children:"models/TrainData_preprocess.py"})," followed by ",(0,i.jsx)(t.code,{children:"models/RandomForest.py"}),"\n\xa0"]}),"\n",(0,i.jsx)(t.h2,{id:"current-repsitory-status",children:"Current Repsitory Status"}),"\n",(0,i.jsx)(t.p,{children:"The files present in the repository are just a rough implementation of gesture detection and classification. Face recognition is yet to be added, both integrated with each other and with the input from the user (information coming from the frontend) in order to implement anti-spoofing."}),"\n",(0,i.jsx)(t.h2,{id:"to-do",children:"To-Do"}),"\n",(0,i.jsx)(t.h3,{id:"short-term",children:"Short Term"}),"\n",(0,i.jsxs)(t.ul,{className:"contains-task-list",children:["\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","\xa0Modify and functionize ",(0,i.jsx)(t.code,{children:"main.py"})," to take a single image as input and return class and confidence as the output. Let the function, for the purposes of this document, be called ",(0,i.jsx)(t.code,{children:"classifyHand"})]}),"\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","\xa0Implement an inference script for face recognition, which contains a function that takes two images (ground truth and test image) as the input and returns a truth value. Let the function, for the purposes of this document, be called ",(0,i.jsx)(t.code,{children:"faceRecog"})]}),"\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","Integrate ",(0,i.jsx)(t.code,{children:"faceRecog"})," and ",(0,i.jsx)(t.code,{children:"classifyHand"})," to implement antispoofing functionality, as explained in the ",(0,i.jsx)(t.em,{children:"Theory"})," page of the documentation."]}),"\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","Implement the functions as a Flask app (could also be a Django app for FastAPI API), and Dockerize the same."]}),"\n"]}),"\n",(0,i.jsx)(t.h3,{id:"long-term",children:"Long Term"}),"\n",(0,i.jsxs)(t.ul,{className:"contains-task-list",children:["\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","Expand the dataset for hand signs in order to prevent spoofing in the worst-case scenario."]}),"\n",(0,i.jsxs)(t.li,{className:"task-list-item",children:[(0,i.jsx)(t.input,{type:"checkbox",disabled:!0})," ","Possibly implement a detection and classification algorithm for dynamic (sequencial, time-continuous) video gestures, for instance, wave of hand or snapping, possibly via an LSTM architecture, in order to expand the diversity of classes."]}),"\n"]})]})}function h(e={}){const{wrapper:t}={...(0,s.R)(),...e.components};return t?(0,i.jsx)(t,{...e,children:(0,i.jsx)(l,{...e})}):l(e)}},8453:(e,t,n)=>{n.d(t,{R:()=>a,x:()=>r});var i=n(6540);const s={},o=i.createContext(s);function a(e){const t=i.useContext(o);return i.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function r(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:a(e.components),i.createElement(o.Provider,{value:t},e.children)}}}]);