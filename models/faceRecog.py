from deepface import DeepFace


def recog(img_1_path, img_2_path):
    '''
    Returns a truth value after comparing the images

    Parameters:
        img_1_path: path of image to be checked
        imt_2_path: path of original image
    
    Returns:
        A truth value
        True if the faces match, else False
    '''
    obj = DeepFace.verify(img_1_path, img_2_path
                            , model_name = 'ArcFace', detector_backend = 'retinaface')
    
    return obj["verified"]

